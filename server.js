const mysql = require("mysql2");
const express = require("express");
const bcrypt = require('bcrypt');
const session = require('express-session');
const bodyParser = require('body-parser');
const fileUpload = require('express-fileupload')
const exphbs = require('express-handlebars')
const handlebars = require('handlebars')
const helpers = require('handlebars-helpers')();

const app = express();

// Регистрируем хелперы Handlebars
handlebars.registerHelper(helpers);

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
  resave: false,
  saveUninitialized: true
}));

// Подключаем middleware для парсинга тела запроса
app.use(bodyParser.urlencoded({ extended: true }));

// Передача userType в макет при каждом запросе
app.use(function(req, res, next) {
  let userType = null;
  if(req.session.user) {
    userType = req.session.user.type
    res.locals.userType = userType
    console.log(res.locals.userType)
  } else {
    console.log("Нет сессии")
  }
  next();
});

// Middleware для проверки роли "организация"
function checkOrganization(req, res, next) {
  if (req.session && req.session.user && req.session.user.type === 'ORG') {
    // Если пользователь - организация, переходим к следующему обработчику
    next();
  } else {
    // Если роль не соответствует, отправляем сообщение об ошибке
    res.status(403).send('Доступ запрещен');
  }
}

// Middleware для проверки роли "пользователь"
function checkUser(req, res, next) {
  if (req.session && req.session.user && req.session.user.type === 'USR') {
    // Если пользователь - обычный пользователь, переходим к следующему обработчику
    next();
  } else {
    // Если роль не соответствует, отправляем сообщение об ошибке
    res.status(403).send('Доступ запрещен');
  }
}

function checkAdmin(req, res, next) {
  if (req.session && req.session.user && req.session.user.type === 'ADM') {
    // Если пользователь - обычный пользователь, переходим к следующему обработчику
    next();
  } else {
    // Если роль не соответствует, отправляем сообщение об ошибке
    res.status(403).send('Доступ запрещен');
  }
}


app.get("/org_profile/:registrations_id", checkOrganization, function (req, res) {
  const email = req.session.user.email;

  // Используйте параметризированный запрос для безопасности
  pool.query("SELECT * FROM organization WHERE responsible_person_email = ?", [email], function (err, data) {
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
      res.render("org_profile", { organization: data });
    } else {
      res.status(401).send('Необходима аутентификация');
    }
  });
});

app.get("/org_profile", checkOrganization, function (req, res) {
  res.redirect(`/org_profile/${req.session.user.registrations_id}`);
});

// Middleware для проверки аутентификации пользователя
function checkAuthentication(req, res, next) {
  if (req.session.user) {
      next();
  } else {
      res.status(401).send('Необходима аутентификация');
  }
}

app.get("/org_card/:organization_id", checkAuthentication, function (req, res) {
  const organization_id = req.params.organization_id;
  const service_detail_code = organization_id;

  // Параметризированный запрос к базе данных для получения информации об организации
  pool.query("SELECT * FROM organization WHERE organization_id = ?", [organization_id], function (err, orgData) {
    if (err) {
      console.error(err);
      return res.status(500).send('Произошла ошибка при выполнении запроса к базе данных.');
    }

    // Проверяем, найдена ли организация
    if (orgData.length === 0) {
      return res.status(404).send('Организация не найдена.');
    }

    // Параметризированный запрос к базе данных для получения информации о детализации услуги
    pool.query("SELECT * FROM service_detail WHERE service_detail_code = ?", [service_detail_code], function (err, serviceData) {
      if (err) {
        console.error(err);
        return res.status(500).send('Произошла ошибка при выполнении запроса к базе данных.');
      }

      // Если данные о детализации услуги не найдены, то продолжаем отображение страницы org_card только с данными об организации
      if (serviceData.length === 0) {
        return res.render("org_card", { organization: orgData[0], service_detail: null });
      }

      // Отображаем страницу org_card с данными об организации и детализации услуги
      res.render("org_card", { organization: orgData[0], service_detail: serviceData[0] });
    });
  });
});




app.get("/usr_profile/:registrations_id", checkUser, function (req, res) {
  const email = req.session.user.email;

  // Используйте параметризированный запрос для безопасности
  pool.query("SELECT * FROM customer WHERE customer_email = ?", [email], function (err, data) {
    if (err) {
      console.error(err);
      return res.status(500).send('Произошла ошибка при выполнении запроса к базе данных.');
    }
    // Проверьте, найдены ли данные
    if (data.length === 0) {
      return res.status(404).send('Пользователь не найдена.');
    }
    //Если юзер авторизирован, то покажет страницу, если нет ,то err
    if (req.session.user) {
      res.render("usr_profile", { customer: data[0] });
    } else {
      res.status(401).send('Необходима аутентификация');
    }
  });
});

app.get("/usr_profile", checkUser, function (req, res) {
  res.redirect(`/usr_profile/${req.session.user.registrations_id}`);
});

app.get("/selector", function (req, res) {
  res.render("selector");
});

app.get("/about", (req, res) => {
  res.render('about');
})

// Регистрация ОРГАНИЗАЦИИ
app.post('/org_registration', (req, res) => {
  const { email, password, organization_full_name, organization_short_name, inn, kpp, ogrn, responsible_person_surname, responsible_person_name, responsible_person_patronymic, responsible_person_phone_number, add_info, profile_image, type } = req.body;
  let responsible_person_email = email;

  let sampleFile;
  let uploadPath;

  if (!req.files || Object.keys(req.files).length === 0) {
    return res.status(400).send('Файлы не были загружены.');
  }
  sampleFile = req.files.sampleFile;
  uploadPath = __dirname + '/public/upload/' + sampleFile.name;

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
    const queryReg = 'INSERT INTO registrations (email, password, type) VALUES (?, ?, ?)';

    sampleFile.mv(uploadPath, function (err) {
      if (err) return res.status(500).send(err);
      pool.query(queryOrg, [organization_full_name, organization_short_name, inn, kpp, ogrn, responsible_person_surname, responsible_person_name, responsible_person_patronymic, responsible_person_email, responsible_person_phone_number, add_info, sampleFile.name], (err, result) => {
        if (err) {
          console.error('Ошибка при добавлении пользователя в базу данных:', err);
          return res.status(500).send('Ошибка при регистрации пользователя');
        }

        // Добавление email, хеша пароля и типа аккаунта в таблицу 'registrations'
        pool.query(queryReg, [email, hash, type], (err, result) => {
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
});



// возвращаем форму для регистрации организации
app.get("/org_registration", function (req, res) {
  res.render("org_registration.hbs");
});

// Регистрация ПОЛЬЗОВАТЕЛЯ
app.post('/usr_registration', (req, res) => {
  const { email, password, customer_name, customer_surname, customer_patronymic, customer_phone_number, add_info, profile_image, type } = req.body;
  let customer_email = email;

  let sampleFile;
  let uploadPath;

  if (!req.files || Object.keys(req.files).length === 0) {
    return res.status(400).send('Файлы не были загружены.');
  }
  sampleFile = req.files.sampleFile;
  uploadPath = __dirname + '/public/upload/' + sampleFile.name;

  sampleFile.mv(uploadPath, function(err) {
    if (err)
      return res.status(500).send(err);
  
    console.log('File uploaded!');
  });

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
    const queryUsr = 'INSERT INTO customer (customer_name, customer_surname, customer_patronymic, customer_phone_number, customer_email, add_info, profile_image) VALUES (?, ?, ?, ?, ?, ?, ?)';
    const queryReg = 'INSERT INTO registrations (email, password, type) VALUES (?, ?, ?)';

    pool.query(queryUsr, [customer_name, customer_surname, customer_patronymic, customer_phone_number, customer_email, add_info, sampleFile.name], (err, result) => {
      if (err) {
        console.error('Ошибка при добавлении пользователя в базу данных:', err);
        return res.status(500).send('Ошибка при регистрации пользователя');
      }

      // Добавление email и хеша пароля в таблицу 'registrations'
      pool.query(queryReg, [email, hash, type], (err, result) => {
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


app.post('/auth', (req, res) => {
  const email = req.body.email;
  const password = req.body.password;
  //const registrations_id =

  const queryOrg = 'SELECT * FROM organization WHERE responsible_person_email = ?';
  const queryUsr = 'SELECT * FROM customer WHERE customer_email = ?';
  const queryReg = 'SELECT * FROM registrations WHERE email = ?';

  pool.query(queryReg, [email], (err, result) => {
    if (err) {
      res.status(500).send('Ошибка при входе');
    } else if (result.length > 0) {
      bcrypt.compare(password, result[0].password, (err, match) => {
        if (err) {
          res.status(500).send('Ошибка при входе');
        } else if (match) {
          const role = result[0].type; // Предполагается, что тип пользователя хранится здесь
          const registrations_id = result[0].registrations_id
          req.session.user = { email: email, type: role, registrations_id: registrations_id };
          if (role === 'ORG') {
            // Выполняем запрос к базе данных для получения данных об организации
            pool.query(queryOrg, [email], (err, orgResults) => {
              if (err) {
                res.status(500).send('Ошибка при получении данных об организации');
              } else if (orgResults.length > 0) {
                // Здесь можно добавить информацию об организации в сессию, если нужно
                req.session.org = orgResults[0];
                res.redirect(`/org_profile/${req.session.user.registrations_id}`);
              } else {
                res.status(404).send('Организация не найдена');
              }
            });
          } else if (role === "USR") {
            // Выполняем запрос к базе данных для получения данных о пользователе
            pool.query(queryUsr, [email], (err, usrResults) => {
              if (err) {
                res.status(500).send('Ошибка при получении данных об организации');
              } else if (usrResults.length > 0) {
                // Здесь можно добавить информацию об пользователе в сессию, если нужно
                req.session.usr = usrResults[0];
                res.redirect(`/usr_profile/${req.session.user.registrations_id}`);
              } else {
                res.status(404).send('Пользователь не найден');
              }
            });
          } else if (role === "ADM") {
            res.redirect("admin_panel")
          }
        } else {
          res.status(404).send('Неверный пароль');
        }
      });
    } else {
      res.status(404).send('Пользователь не найден');
    }
  });
});



app.get("/auth", function (req, res) {
  res.render("auth");
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

app.get("/admin_panel", checkAdmin, function (req,res){
  res.render('admin_panel')
})

// Маршрут для получения списка пользователей (можете реализовать по аналогии с organizations)
app.get("/admin_panel/users", checkAdmin, (req, res) => {
  pool.query("SELECT * FROM customer", (error, results) => {
    if (error) {
      console.error("Ошибка при выполнении запроса к базе данных:", error);
      return res.status(500).json({ error: 'Ошибка при получении данных об организациях' });
    }
    const customers = results;
    // Отправляем данные об организациях в формате JSON
    res.json({ customers: JSON.parse(JSON.stringify(customers)) });
  });
});

// Маршрут для получения списка организаций в формате JSON
app.get("/admin_panel/organizations", checkAdmin, (req, res) => {
  pool.query("SELECT * FROM organization", (error, results) => {
    if (error) {
      console.error("Ошибка при выполнении запроса к базе данных:", error);
      return res.status(500).json({ error: 'Ошибка при получении данных об организациях' });
    }
    const organizations = results;
    // Отправляем данные об организациях в формате JSON
    res.json({ organizations: JSON.parse(JSON.stringify(organizations)) });
  });
});


// Маршрут для получения списка заявок (можете реализовать по аналогии с users)
app.get("/admin/reviews", checkAdmin, (req, res) => {
  // Здесь вы можете выполнить запрос к базе данных, чтобы получить список заявок
  // Затем отправить этот список обратно клиенту для отображения на странице администратора
});

// отображение главной страницы
app.get("/", function (req, res) {
  if (req.session.user) {
    let userType = req.session.user.type;
    //console.log(userType)
    pool.query('SELECT * FROM organization', function (error, results, fields) {
      if (error) throw error;
      res.render('index', { organization: results, userType: userType });
    });
  } 
  else {
    pool.query('SELECT * FROM organization', function (error, results, fields) {
      if (error) throw error;
      res.render('index', { organization: results });
    });
  }
});

app.listen(PORT, function () {
  console.log("Сервер запущен на порту:" + PORT);
});
