document.querySelector(".org_btn").addEventListener("click", () => {
    fetch("/admin/organizations")
        .then(response => {
            if (!response.ok) {
                throw new Error('Ошибка HTTP: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            console.log(data);
            data.forEach(organization => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${organization.email}</td>
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
                    <td>${organization.profile_image}</td>
                    <td>${organization.type}</td>
                `;
                tableBody.appendChild(row);
            });
        })
        .catch(error => console.error("Ошибка при получении данных об организациях:", error));

});
