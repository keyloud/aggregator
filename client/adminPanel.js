document.querySelector(".org_btn").addEventListener("click", () => {
    fetch("/admin_panel/organizations")
        .then(response => {
            if (!response.ok) {
                throw new Error('Ошибка HTTP: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            // Проверяем, есть ли данные в ответе
            if (!data.organizations || data.organizations.length === 0) {
                console.error("Нет данных об организациях");
                return;
            }
            // Обновляем содержимое таблицы с данными об организациях
            const tableBody = document.querySelector(".table-fill tbody");
            tableBody.innerHTML = ""; // Очищаем содержимое таблицы перед обновлением

            // После обновления содержимого таблицы
            const tableHeaders = document.querySelectorAll("thead th");
            const headerTextOrg = ["ID","Email", "Full name", "Short Name", "INN", "KPP", "OGRN", "Responsible name", "Responsible surname", "Responsible patronymic", "Responsible phone number", "Description"];

            tableHeaders.forEach((header, index) => {
                header.textContent = headerTextOrg[index];
            });

            // Перебираем каждую организацию и добавляем ее данные в таблицу
            data.organizations.forEach(organization => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${organization.organization_id}</td>
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
                `;
                tableBody.appendChild(row);
            });
        })
        .catch(error => console.error("Ошибка при получении данных об организациях:", error));
});

document.querySelector(".user_btn").addEventListener("click", () => {
    fetch("/admin_panel/users")
        .then(response => {
            if (!response.ok) {
                throw new Error('Ошибка HTTP: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            // Проверяем, есть ли данные в ответе
            if (!data.customers || data.customers.length === 0) {
                console.error("Нет данных об пользователях");
                return;
            }
            // Обновляем содержимое таблицы с данными об организациях
            const tableBody = document.querySelector(".table-fill tbody");
            tableBody.innerHTML = ""; // Очищаем содержимое таблицы перед обновлением

            // После обновления содержимого таблицы
            const tableHeaders = document.querySelectorAll("thead th");
            const headerTextUsr = ["ID", "Email", "Name", "Surname", "Patronymic", "Phone number", "Description", "Image", "-", "-", "-", "-"];

            tableHeaders.forEach((header, index) => {
                header.textContent = headerTextUsr[index];
            });

            // Перебираем каждую организацию и добавляем ее данные в таблицу
            data.customers.forEach(customer => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${customer.customer_id}</td>
                    <td>${customer.customer_name}</td>
                    <td>${customer.customer_surname}</td>
                    <td>${customer.customer_patronymic}</td>
                    <td>${customer.customer_phone_number}</td>
                    <td>${customer.customer_email}</td>
                    <td>${customer.add_info}</td>
                    <td>${customer.profile_image}</td>
                `;
                tableBody.appendChild(row);
            });
        })
        .catch(error => console.error("Ошибка при получении данных об организациях:", error));
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
