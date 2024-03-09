const mysql = require("mysql2");
const express = require("express");
const bcrypt = require('bcrypt');
const session = require('express-session');
const bodyParser = require('body-parser');
const fileUpload = require('express-fileupload')
const exphbs = require('express-handlebars')

const app = express();

const urlencodedParser = express.urlencoded({ extended: false });
const path = require('path'); // Добавленная строка
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, 'client')));
app.use(express.static(path.join(__dirname, 'upload')));

const CONFIG = require('./config')
const pool = mysql.createPool(CONFIG);
const PORT = 3306;

app.use(fileUpload());

//Загрузка шаблонизатора hbs
app.engine('hbs', exphbs.engine({
  defaultLayout: 'main',
  extname: '.hbs'
}));

app.set("view engine", "hbs");


// Middleware для парсинга JSON и работы с сессиями
app.use(express.json());
app.use(session({
  secret: 'secret',
  resave: true,
  saveUninitialized: true
}));

// Подключаем middleware для парсинга тела запроса
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/organization/:inn/:success", function (req, res) {
  const inn = req.params.inn;
  const success = req.params.success;

  // Используйте параметризированный запрос для безопасности
  pool.query("SELECT organization_full_name, profile_image, inn FROM organization WHERE inn = ?", [inn], function (err, data) {
    if (err) {
      console.error(err);
      return res.status(500).send('Произошла ошибка при выполнении запроса к базе данных.');
    }
    // Проверьте, найдены ли данные
    if (data.length === 0) {
      return res.status(404).send('Организация не найдена.');
    }
    //Если юзер авторизирован, то покажет страницу, если нет ,то err
    if (req.session.user) {
      res.render("organization", { organization: data, success: success });
    } else {
      res.status(401).send('Необходима аутентификация');
    }
  });
});

// возвращаем форму для регистрации
app.get("/create_protected", function (req, res) {
  if (req.session.user) {
    res.render("create_protected");
  } else {
    res.status(401).send('Необходима аутентификация');
  }
});

app.post("/create_protected", (req, res) => {
  let sampleFile;
  let uploadPath;

  if (!req.files || Object.keys(req.files).length === 0) {
    return res.status(400).send('Файлы не были загружены.');
  }
  const fullName = req.body.organization_full_name;
  const INN = req.body.inn;

  // Проверка наличия пароля
  if (!fullName || !INN) {
    return res.status(400).send('Данные отстутствуют.');
  }
  sampleFile = req.files.sampleFile;
  uploadPath = __dirname + '/public/upload/' + sampleFile.name;

  sampleFile.mv(uploadPath, function (err) {
    if (err) return res.status(500).send(err);

    pool.getConnection((err, connection) => {
      if (err) throw err; // not connection
      //console.log('Connected!');
      connection.query("INSERT INTO organization (organization_full_name, inn, profile_image) VALUES (?,?,?)", [fullName, INN, sampleFile.name], (err, rows) => {
        // После того как закончим запрос, отсоединяемся.  
        connection.release();

        if (err) {
          console.log(err);
          res.status(500).send('Произошла ошибка при выполнении запроса к базе данных.');
        } else {
          // Отправка данных на страницу. Добавить переход по INN!!!
          res.redirect(`/organization/${INN}/success`);
        }
      });
    });
  });
});

app.get("/about", (req, res) => {
  res.render('about');
})

// возвращаем форму для регистрации
app.get("/register", function (req, res) {
  res.render("register.hbs");
});

// Регистрация пользователя
app.post('/register', (req, res) => {

  const username = req.body.username;
  const password = req.body.password;

  // Проверка наличия пароля
  if (!password) {
    return res.status(400).send('Пароль отсутствует');
  }

  // Хеширование пароля
  bcrypt.hash(password, 10, (err, hash) => {
    if (err) {
      console.error('Ошибка хеширования пароля:', err);
      return res.status(500).send('Ошибка при регистрации пользователя');
    }
    // Сохранение хеша пароля в базе данных
    pool.query(
      'INSERT INTO registrations (username, password) VALUES (?, ?)',
      [username, hash],
      (err, result) => {
        if (err) {
          console.error('Ошибка при добавлении пользователя в базу данных:', err);
          return res.status(500).send('Ошибка при регистрации пользователя');
        }

        res.redirect("/");
      }
    );
  });
});

// возвращаем форму для входа
app.get("/login", function (req, res) {
  res.render("login.hbs");
});

// Вход пользователя
app.post('/login', (req, res) => {

  const username = req.body.username;
  const password = req.body.password;

  pool.query(
    'SELECT * FROM registrations WHERE username = ?',
    [username],
    (err, result) => {
      if (err) {
        res.status(500).send('Ошибка при входе');
      } else if (result.length > 0) {
        bcrypt.compare(password, result[0].password, (err, match) => {
          if (err) {
            res.status(500).send('Ошибка при входе');
          } else if (match) {
            req.session.user = username;
            res.status(200).send('Вход выполнен успешно');
          } else {
            res.status(401).send('Неверные имя пользователя или пароль');
          }
        });
      } else {
        res.status(401).send('Неверные имя пользователя или пароль');
      }
    }
  );
});


// Выход пользователя
app.get('/logout', (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      res.status(500).send('Ошибка при выходе');
    } else {
      res.status(200).send('Выход выполнен успешно');
    }
  });
});


// получем id редактируемого пользователя, получаем его из бд и отправлям с формой редактирования
app.get("/edit/:id", function (req, res) {
  const id = req.params.id;
  pool.query("SELECT * FROM users WHERE id=?", [id], function (err, data) {
    if (err) return console.log(err);
    res.render("edit.hbs", {
      user: data[0]
    });
  });
});
// получаем отредактированные данные и отправляем их в БД
app.post("/edit", urlencodedParser, function (req, res) {

  if (!req.body) return res.sendStatus(400);
  const name = req.body.name;
  const age = req.body.age;
  const id = req.body.id;

  pool.query("UPDATE users SET name=?, age=? WHERE id=?", [name, age, id], function (err, data) {
    if (err) return console.log(err);
    res.redirect("/");
  });
});

// получаем id удаляемого пользователя и удаляем его из бд
app.post("/delete/:id", function (req, res) {

  const id = req.params.id;
  pool.query("DELETE FROM users WHERE id=?", [id], function (err, data) {
    if (err) return console.log(err);
    res.redirect("/");
  });
});

// отображение главной страницы
app.get("/", function (req, res) {
  res.render("index.hbs");
});

app.listen(PORT, function () {
  console.log("Сервер запущен на порту:" + PORT);
});