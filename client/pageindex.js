 let serviceCount = 0;

    function addService() {
        serviceCount++;
        document.getElementById('serviceCount').innerText = serviceCount;
        updateServices();
    }

    function removeService() {
        if (serviceCount > 0) {
            serviceCount--;
            document.getElementById('serviceCount').innerText = serviceCount;
            updateServices();
        }
    }

    function updateServices() {
        let servicesDiv = document.getElementById('services');
        servicesDiv.innerHTML = '';

        for (let i = 0; i < serviceCount; i++) {

            let serviceDiv = document.createElement('div');
            serviceDiv.classList.add('card');
            serviceDiv.innerHTML = `
                <div id="service">
                <img src="" alt="Фото организации">
                <h2>Название организации ${i + 1}</h2>
                <p>Описание ${i + 1}</p>
                </div>
            `;
            servicesDiv.appendChild(serviceDiv);
        }
    }