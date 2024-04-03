function fetchDataAndDisplay(path, headerText, dataPropertyName, createRowContent) {
    fetch(path)
        .then(response => {
            if (!response.ok) {
                throw new Error('Ошибка HTTP: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            if (!data[dataPropertyName] || data[dataPropertyName].length === 0) {
                console.error(`Нет данных: ${dataPropertyName}`);
                return;
            }
            const tableBody = document.querySelector(".table-fill tbody");
            tableBody.innerHTML = ""; // Очищаем содержимое таблицы перед обновлением

            const tableHeaders = document.querySelectorAll("thead th");
            tableHeaders.forEach((header, index) => {
                header.textContent = headerText[index] || "";
            });

            data[dataPropertyName].forEach(item => {
                const row = document.createElement("tr");
                row.innerHTML = createRowContent(item);
                tableBody.appendChild(row);
            });
        })
        .catch(error => console.error(`Ошибка при получении данных: ${path}`, error));
}

document.querySelector(".org_btn").addEventListener("click", () => {
    const headerTextOrg = ["Red/Del", "Email", "Full name", "Short Name", "INN", "KPP", "OGRN", "Responsible name", "Responsible surname", "Responsible patronymic", "Responsible phone number", "Description"];
    fetchDataAndDisplay("/admin_panel/organizations", headerTextOrg, "organizations", organization => `
        <td>
            <button class="delete-btn" onclick="delete('${organization.responsible_person_email}')"><i class="fas fa-trash-alt"></i></button>
            <button class="edit-btn" onclick="edit('${organization.responsible_person_email}')"><i class="fas fa-edit"></i></button>
        </td>
        <td>${organization.responsible_person_email}</td>
        <td>${organization.organization_full_name}</td>
        <td>${organization.organization_short_name}</td>
        <td>${organization.inn}</td>
        <td>${organization.kpp}</td>
        <td>${organization.ogrn}</td>
        <td>${organization.responsible_person_surname}</td>
        <td>${organization.responsible_person_name}</td>
        <td>${organization.responsible_person_patronymic}</td>
        <td>${organization.responsible_person_phone_number}</td>
        <td>${organization.add_info}</td>
    `);
});

document.querySelector(".user_btn").addEventListener("click", () => {
    const headerTextUsr = ["Red/Del", "Email", "Name", "Surname", "Patronymic", "Phone number", "Description", "Image", "-", "-", "-", "-"];
    fetchDataAndDisplay("/admin_panel/users", headerTextUsr, "customers", customer => `
        <td>
            <button class="delete-btn" onclick="delete('${customer.customer_email}')"><i class="fas fa-trash-alt no-border"></i></button>
            <button class="edit-btn" onclick="edit('${customer.customer_email}')"><i class="fas fa-edit no-border"></i></button>
        </td>
        <td>${customer.customer_email}</td>
        <td>${customer.customer_name}</td>
        <td>${customer.customer_surname}</td>
        <td>${customer.customer_patronymic}</td>
        <td>${customer.customer_phone_number}</td>
        <td>${customer.add_info}</td>
        <td>${customer.profile_image}</td>
        <td>--</td>
        <td>--</td>
        <td>--</td>
        <td>--</td>
    `);
});

function searchTable() {
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("searchInput");
    filter = input.value.toUpperCase();
    table = document.querySelector(".table-fill tbody");
    tr = table.getElementsByTagName("tr");

    // Проходим по всем строкам таблицы и скрываем те, которые не соответствуют запросу поиска
    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[1]; // Ищем в столбце с индексом 0, но можно адаптировать под любой столбец
        if (td) {
            txtValue = td.textContent || td.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

function edit(email) {
    const tableRows = document.querySelectorAll(".table-fill tbody tr");
    tableRows.forEach(row => {
        const emailCell = row.querySelector("td:nth-child(2)");
        if (emailCell.textContent.trim() === email) {
            const cells = row.querySelectorAll("td");
            cells.forEach(cell => {
                // Проверяем, что ячейка не содержит кнопок
                if (cell.querySelector("button")) return;

                const text = cell.textContent.trim();
                const input = document.createElement("input");
                input.setAttribute("type", "text");
                input.setAttribute("value", text);
                cell.textContent = ''; // Очищаем содержимое ячейки
                cell.appendChild(input);
            });

            // Меняем кнопку "редактировать" на "сохранить"
            const editBtn = row.querySelector('.edit-btn');
            if (editBtn) {
                editBtn.innerHTML = '<i class="fas fa-check"></i>'; // меняем иконку на галочку
                editBtn.onclick = function () { save(row); }; // передаем ссылку на строку
            }
        }
    });
}

function save(row) {
    const emailCell = row.querySelector("td:nth-child(2)");
    const email = emailCell.textContent.trim();

    const inputs = row.querySelectorAll("input");
    inputs.forEach(input => {
        const cell = input.closest("td");
        const columnIndex = Array.from(cell.parentElement.children).indexOf(cell);
        const newValue = input.value;

        // Обновляем содержимое ячейки таблицы новым значением
        row.cells[columnIndex].textContent = newValue;
    });

    // Возвращаем кнопку "Редактировать" после сохранения
    const editBtn = row.querySelector('.edit-btn');
    if (editBtn) {
        editBtn.innerHTML = '<i class="fas fa-edit"></i>'; // меняем иконку на карандаш
        editBtn.onclick = function () { edit(email); }; // меняем функцию на редактирование
    }

    // Если содержимое ячейки email было пустым, восстанавливаем исходное значение
    if (!emailCell.textContent.trim()) {
        emailCell.textContent = email;
    }
}

function deleteRow(email) {
    // Находим в таблице строку, которая содержит нужный email
    // Предполагается, что email находится во второй колонке, поэтому используем :nth-child(2)
    const rows = document.querySelectorAll('.table-fill tbody tr');
    for (let row of rows) {
        const cellEmail = row.querySelector("td:nth-child(2)").textContent.trim();
        if (cellEmail === email) {
            row.remove(); // Удаляем строку
            break; // Выходим из цикла после удаления строки
        }
    }
}

// Кнопки
document.querySelector('.table-fill tbody').addEventListener('click', function (e) {
    // Получаем ссылку на элемент, который был нажат
    const clickedElement = e.target;

    // Определяем, внутри какой строки находится нажатая кнопка
    const row = clickedElement.closest('tr');
    if (!row) return; // Если по какой-то причине строка не найдена, прекращаем выполнение функции

    // Получаем email или другие данные, которые могут понадобиться для действий
    const email = row.querySelector("td:nth-child(2)").textContent.trim();

    // Проверяем, какая кнопка была нажата, и выполняем соответствующие действия
    if (clickedElement.closest('.edit-btn')) {
        // Вызов функции редактирования для данного email
        edit(email);
    } else if (clickedElement.closest('.delete-btn')) {
        // Вызов функции удаления для данного email
        deleteRow(email); // Убедитесь, что функция deleteRow определена и правильно обрабатывает удаление
    } else if (clickedElement.closest('.another-btn')) {
        // Обработка нажатия на другую кнопку
        anotherAction(email); // Убедитесь, что функция anotherAction определена
    }
    // Добавьте столько условий, сколько необходимо для обработки всех кнопок
});