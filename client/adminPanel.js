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
            const tableBody = document.querySelector("tbody");
            tableBody.innerHTML = ""; // Очищаем содержимое таблицы перед обновлением
            
            // Перебираем каждую организацию и добавляем ее данные в таблицу
            data.organizations.forEach(organization => {
                const row = document.createElement("tr");
                row.innerHTML = `
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

function searchTable() {
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("searchInput");
    filter = input.value.toUpperCase();
    table = document.querySelector(".table-fill");
    tr = table.getElementsByTagName("tr");

    // Проходим по всем строкам таблицы и скрываем те, которые не соответствуют запросу поиска
    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[0]; // Ищем в столбце с индексом 0, но можно адаптировать под любой столбец
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