function searchCards() {
    var input, filter, cards, card, h3, i, txtValue;
    input = document.querySelector(".search");
    filter = input.value.toUpperCase();
    cards = document.querySelectorAll(".card");

    // Проходим по всем карточкам и скрываем те, которые не соответствуют запросу поиска
    for (i = 0; i < cards.length; i++) {
        h3 = cards[i].querySelector(".card_h3"); // Ищем в заголовке h3, но можно адаптировать под любой элемент
        if (h3) {
            txtValue = h3.textContent || h3.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                cards[i].style.display = "";
            } else {
                cards[i].style.display = "none";
            }
        }
    }
}
document.querySelector(".search").addEventListener("keyup", searchCards);
document.querySelector(".search").addEventListener("input", searchCards);