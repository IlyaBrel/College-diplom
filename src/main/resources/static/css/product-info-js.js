

function getSelectedFilters() {
    var selectedFilters = [];
    var checkboxes = document.querySelectorAll("input[type=checkbox]:checked");
    for (var i = 0; i < checkboxes.length; i++) {
        selectedFilters.push(checkboxes[i].id);
    }
    return selectedFilters;
}

// Функция для отображения выбранных фильтров в блоке с крестиками
function showSelectedFilters(selectedFilters) {
    var container = document.getElementById("selectedFiltersContainer");
    container.innerHTML = ""; // Очищаем содержимое контейнера
    for (var i = 0; i < selectedFilters.length; i++) {
        var filter = document.createElement("span");
        filter.textContent = selectedFilters[i];
        var closeButton = document.createElement("span");
        closeButton.textContent = "x";
        closeButton.className = "closeButton";
        closeButton.addEventListener("click", function (event) {
            var filterToRemove = event.target.previousSibling.textContent;
            removeSelectedFilter(filterToRemove);
        });
        filter.appendChild(closeButton);
        container.appendChild(filter);
    }
}

// Функция для удаления выбранного фильтра
function removeSelectedFilter(filterToRemove) {
    var selectedFilters = getSelectedFilters();
    var index = selectedFilters.indexOf(filterToRemove);
    if (index !== -1) {
        selectedFilters.splice(index, 1);
    }
    showSelectedFilters(selectedFilters);
    saveFiltersToCookie(selectedFilters);
}

// Функция для применения выбранных фильтров
function applyFilters() {
    // Получаем выбранные фильтры
    var selectedFilters = getSelectedFilters();

    // Выполняем действия с выбранными фильтрами (например, применяем их к результатам поиска)

    // Отображаем выбранные фильтры в блоке с крестиками
    showSelectedFilters(selectedFilters);

    // Сохраняем выбранные фильтры в куки
    saveFiltersToCookie(selectedFilters);
}

// Функция для сохранения выбранных фильтров в куки
function saveFiltersToCookie(selectedFilters) {
    var selectedFiltersString = JSON.stringify(selectedFilters);
    // Сохраняем строку с выбранными фильтрами в куки на 1 день
    var expiryDate = new Date();
    expiryDate.setDate(expiryDate.getDate() + 1);
    document.cookie = "selectedFilters=" + selectedFiltersString + "; expires=" + expiryDate.toUTCString();

// Функция для загрузки выбранных фильтров из куки
    function loadFiltersFromCookie() {
        var selectedFiltersString = getCookie("selectedFilters");
        if (selectedFiltersString) {
            var selectedFilters = JSON.parse(selectedFiltersString);
            showSelectedFilters(selectedFilters);
        }
    }

// Функция для получения значения куки по имени
    function getCookie(name) {
        var cookies = document.cookie.split(";");
        for (var i = 0; i < cookies.length; i++) {
            var cookie = cookies[i].trim();
            if (cookie.indexOf(name + "=") === 0) {
                return cookie.substring(name.length + 1);
            }
        }
        return "";
    }

// Обработчик события клика на кнопку "Применить фильтры"
    document.getElementById("applyFiltersButton").addEventListener("click", applyFilters);

// Загружаем выбранные фильтры из куки при загрузке страницы
    loadFiltersFromCookie();
}