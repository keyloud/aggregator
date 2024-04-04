function saveData() {
    // Создаем объект FormData для сбора данных из полей
    var formData = new FormData();

    // Добавляем данные из каждого поля в объект FormData
    fields.forEach(function (field) {
        var inputElement = document.querySelector(field.inputSelector);
        formData.append(field.inputSelector.replace('.edit-', ''), inputElement.value);
        console.log(formData)
    });

    // Отправляем AJAX запрос
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/saveDataOrg', true);
    xhr.onload = function () {
        if (xhr.status === 200) {
            alert('Данные успешно сохранены!');
        } else {
            alert('Произошла ошибка при сохранении данных.');
        }
    };
    xhr.onerror = function () {
        alert('Произошла ошибка при отправке запроса.');
    };
    xhr.send(formData);
}
var fields = [
    { textSelector: '.org_prof_surname .txt', inputSelector: '.edit-surname' },
    { textSelector: '.org_prof_name .txt', inputSelector: '.edit-name' },
    { textSelector: '.org_prof_patronymic .txt', inputSelector: '.edit-patronymic' },
    { textSelector: '.org_prof_email .txt', inputSelector: '.edit-email' },
    { textSelector: '.phone .txt', inputSelector: '.edit-phone' },
    { textSelector: '.fullname .txt', inputSelector: '.edit-fullname' },
    { textSelector: '.shortname .txt', inputSelector: '.edit-shortname' },
    { textSelector: '.dscrpt .txt', inputSelector: '.edit-dscrpt' },
    { textSelector: '.inn .txt', inputSelector: '.edit-inn' },
    { textSelector: '.kpp .txt', inputSelector: '.edit-kpp' },
    { textSelector: '.ogrn .txt', inputSelector: '.edit-ogrn' }
];

var saveButton = document.querySelector('.btnSAVE button');

function toggleEdit() {
    fields.forEach(function (field) {
        var textElement = document.querySelector(field.textSelector);
        var inputElement = document.querySelector(field.inputSelector);

        if (inputElement.classList.contains('hidden')) {
            textElement.classList.add('hidden');
            inputElement.classList.remove('hidden');
            inputElement.value = textElement.textContent.trim();
        } else {
            textElement.classList.remove('hidden');
            inputElement.classList.add('hidden');
            textElement.textContent = inputElement.value.trim();
        }
    });

    if (saveButton.textContent === 'Изменить данные') {
        saveButton.textContent = 'Сохранить';
    } else {
        saveButton.textContent = 'Изменить данные';
        saveData();
    }
}