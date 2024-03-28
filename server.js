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

app.get("/org_profile/:inn/:success", function (req, res) {
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
      res.render("org_profile", { organization: data, success: success });
    } else {
      res.status(401).send('Необходима аутентификация');
    }
  });
});

app.get("/usr_profile", function (req, res) {
  res.render("usr_profile");
});

app.get("/selector", function (req, res) {
    res.render("selector");
});

app.get("/auth", function (req, res) {
  res.render("auth");
});

// возвращаем форму для регистрации
app.get("/org_create", function (req, res) {
  if (req.session.user) {
    res.render("org_create");
  } else {
    res.status(401).send('Необходима аутентификация');
  }
});

app.post("/org_create", (req, res) => {
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
          res.redirect(`/org_profile/${INN}/success`);
        }
      });
    });
  });
});

app.get("/about", (req, res) => {
  res.render('about');
})


// Регистрация ОРГАНИЗАЦИИ
app.post('/org_registration', (req, res) => {
  const { email, password, organization_full_name, organization_short_name, inn, kpp, ogrn, responsible_person_surname, responsible_person_name, responsible_person_patronymic, responsible_person_email, responsible_person_phone_number, add_info, profile_image} = req.body;

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

    // Сохранение хеша пароля и остальных данных в базе данных
    const queryOrg = 'INSERT INTO organization (organization_full_name, organization_short_name, inn, kpp, ogrn, responsible_person_surname, responsible_person_name, responsible_person_patronymic, responsible_person_email, responsible_person_phone_number, add_info, profile_image ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
    const queryReg = 'INSERT INTO registrations (email, password) VALUES (?, ?)';
    
    pool.query(queryOrg, [email ,organization_full_name, organization_short_name, inn, kpp, ogrn, responsible_person_surname, responsible_person_name, responsible_person_patronymic, responsible_person_email, responsible_person_phone_number, add_info, profile_image], (err, result) => {
      if (err) {
        console.error('Ошибка при добавлении пользователя в базу данных:', err);
        return res.status(500).send('Ошибка при регистрации пользователя');
      }
      
      // Добавление email и хеша пароля в таблицу 'registrations'
      pool.query(queryReg, [email, hash], (err, result) => {
        if (err) {
          console.error('Ошибка при добавлении пользователя в таблицу "registrations":', err);
          return res.status(500).send('Ошибка при регистрации пользователя');
        }
        
        res.send(`
          <html>
            <head>
              <style>
                body {
                  background-color: #112533;
                  font-family: Arial, sans-serif;
                  padding: 30px;
                  text-align: center;
                }
                p {
                  color: #fff;
                  font-size: 24px;
                }
              </style>
            </head>
            <body>
              <p>Регистрация прошла успешно. Сейчас вы будете перенаправлены на главную страницу...</p>
              <script>
                setTimeout(function(){
                  window.location.href = '/';
                }, 1500);
              </script>
            </body>
          </html>
        `);
      });
    });
  });
});


// возвращаем форму для регистрации организации
app.get("/org_registration", function (req, res) {
  res.render("org_registration.hbs");
});

// Регистрация ПОЛЬЗОВАТЕЛЯ
app.post('/usr_registration', (req, res) => {
  const { email, password, customer_name, customer_surname, customer_patronymic, customer_phone_number, add_info } = req.body;

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

    // Сохранение хеша пароля и остальных данных в базе данных
    const queryUsr = 'INSERT INTO customer (customer_name, customer_surname, customer_patronymic, customer_phone_number, add_info ) VALUES (?, ?, ?, ?, ?)';
    const queryUReg = 'INSERT INTO registrations (email, password) VALUES (?, ?)';

    pool.query(queryUsr, [email, customer_name, customer_surname, customer_patronymic, customer_phone_number, add_info], (err, result) => {
      if (err) {
        console.error('Ошибка при добавлении пользователя в базу данных:', err);
        return res.status(500).send('Ошибка при регистрации пользователя');
      }
      
      // Добавление email и хеша пароля в таблицу 'registrations'
      pool.query(queryUReg, [email, hash], (err, result) => {
        if (err) {
          console.error('Ошибка при добавлении пользователя в таблицу "registrations":', err);
          return res.status(500).send('Ошибка при регистрации пользователя');
        }
        
        res.send(`
          <html>
            <head>
              <style>
                body {
                  background-color: #112533;
                  font-family: Arial, sans-serif;
                  padding: 30px;
                  text-align: center;
                }
                p {
                  color: #fff;
                  font-size: 24px;
                }
              </style>
            </head>
            <body>
              <p>Регистрация прошла успешно. Сейчас вы будете перенаправлены на главную страницу...</p>
              <script>
                setTimeout(function(){
                  window.location.href = '/';
                }, 1500);
              </script>
            </body>
          </html>
        `);
      });
    });
  });
});

// возвращаем форму для регистрации пользователя
app.get("/usr_registration", function (req, res) {
  res.render("usr_registration.hbs");
});


// возвращаем форму для входа
app.get("/usr_authorization", function (req, res) {
  res.render("usr_authorization.hbs");
});

// Вход под юзером
app.post('/usr_authorization', (req, res) => {

  const email = req.body.email;
  const password = req.body.password;

  pool.query('SELECT * FROM registrations WHERE email = ?',[email], (err, result) => {
      if (err) {
        res.status(500).send('Ошибка при входе');
      } else if (result.length > 0) {
        bcrypt.compare(password, result[0].password, (err, match) => {
          if (err) {
            res.status(500).send('Ошибка при входе');
          } else if (match) {
            req.session.user = email;
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

// Вход пользователя
app.post('/auth', (req, res) => {
  const INN = req.body.inn;
  const email = req.body.email;
  const password = req.body.password;

  pool.query('SELECT * FROM registrations WHERE email = ?',[email], (err, result) => {
      if (err) {
        res.status(500).send('Ошибка при входе');
      } else if (result.length > 0) {
        bcrypt.compare(password, result[0].password, (err, match) => {
          if (err) {
            res.status(500).send('Ошибка при входе');
          } else if (match) {
            req.session.user = email;
            res.redirect(`/org_profile/${INN}/success`);
          } else {
            res.status(404).send('Неверные имя пользователя или пароль');
          }
        });
      } else {
        res.status(404).send('Неверные имя пользователя или пароль');
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
      res.send(`
              <html>
                <head>
                  <style>
                    body {
                      background-color: #112533;
                      font-family: Arial, sans-serif;
                      padding: 30px;
                      text-align: center;
                    }
                    p {
                      color: #fff;
                      font-size: 24px;
                    }
                  </style>
                </head>
                <body>
                  <p>Выполняется выход. Сейчас вы будете перенаправлены на главную страницу...</p>
                  <script>
                    setTimeout(function(){
                      window.location.href = '/';
                    }, 1500);
                  </script>
                </body>
              </html>
            `);
    }
  });
});


// // получем id редактируемого пользователя, получаем его из бд и отправлям с формой редактирования
// app.get("/edit/:id", function (req, res) {
//   const id = req.params.id;
//   pool.query("SELECT * FROM users WHERE id=?", [id], function (err, data) {
//     if (err) return console.log(err);
//     res.render("edit.hbs", {
//       user: data[0]
//     });
//   });
// });


// // получаем отредактированные данные и отправляем их в БД
// app.post("/edit", urlencodedParser, function (req, res) {

//   if (!req.body) return res.sendStatus(400);
//   const name = req.body.name;
//   const age = req.body.age;
//   const id = req.body.id;

//   pool.query("UPDATE users SET name=?, age=? WHERE id=?", [name, age, id], function (err, data) {
//     if (err) return console.log(err);
//     res.redirect("/");
//   });
// });

// // получаем id удаляемого пользователя и удаляем его из бд
// app.post("/delete/:id", function (req, res) {

//   const id = req.params.id;
//   pool.query("DELETE FROM users WHERE id=?", [id], function (err, data) {
//     if (err) return console.log(err);
//     res.redirect("/");
//   });
// });

// отображение главной страницы
app.get("/", function (req, res) {
  res.render("index.hbs");
});

app.listen(PORT, function () {
  console.log("Сервер запущен на порту:" + PORT);
});
