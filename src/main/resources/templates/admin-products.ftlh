<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html"
      xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Boxicons -->

    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <!-- My CSS -->
    <link rel="stylesheet" href="../static/css/admin.css">

    <title>Панель администратора(Пользователи)</title>
</head>
<body>

<!-- SIDEBAR -->
<section id="sidebar">
    <a href="#" class="brand">
        <i class='bx bxs-smile'></i>
        <span class="text">BELLSELL</span>
    </a>
    <ul class="side-menu top">
        <li>
            <a href="/admin">
                <i class='bx bxs-dashboard'></i>
                <span class="text">Пользователи</span>
            </a>
        </li>
        <li>
            <a href="/admin/products">
                <i class='bx bxs-shopping-bag-alt'></i>
                <span class="text">Товары</span>
            </a>
        </li>
        <li>
            <a href="/admin/categorys">
                <i class='bx bxs-doughnut-chart'></i>
                <span class="text">Категории</span>
            </a>
        </li>
        <li>
            <a href="/admin/orders">
                <i class='bx bxs-message-dots'></i>
                <span class="text">Заказы</span>
            </a>
        </li>
        <li>
            <a href="/admin/news">
                <i class='bx bxs-group'></i>
                <span class="text">Новости</span>
            </a>
        </li>
        <li>
            <a href="/admin/analytics">
                <i class='bx bxs-group'></i>
                <span class="text">Аналитика</span>
            </a>
        </li>
    </ul>
    <ul class="side-menu">
        <li>
            <a href="/">
                <i class='bx bxs-cog'></i>
                <span class="text">На главную</span>
            </a>
        </li>
    </ul>
</section>

<section id="content">
    <!-- NAVBAR -->
    <nav>
        <i class='bx bx-menu'></i>
        <a href="#" class="nav-link">Админ</a>

        <input type="checkbox" id="switch-mode" style="visibility: hidden">
        <label for="switch-mode" class="switch-mode"></label>
        <a href="#" class="notification">
            <i class='bx bxs-bell'></i>
            <span class="num">8</span>
        </a>
        <a href="#" class="profile">
            <#--<img src="img/people.png">-->
        </a>
    </nav>
    <!-- NAVBAR -->

    <!-- MAIN -->
    <main>
        <div class="container">
            <div class="accordion">
                <dl>
                    <dt>
                        <a href="#accordion1" aria-expanded="false" aria-controls="accordion1"
                           class="accordion-title accordionTitle js-accordionTrigger">Новый товар
                        </a>
                    </dt>
                    <dd class="accordion-content accordionItem is-collapsed" id="accordion1"
                        aria-hidden="true">
                        <form action="/admin/products/create" method="post"
                              enctype="multipart/form-data">
                            <div class="row">
                                <div class="col2">
                                    <input class="inp" type="text" name="title">
                                    <label for="name">Название объявления:
                                    </label>
                                </div>
                                <div class="col2">
                                    <input class="inp" type="text" name="description"/>
                                    <label for="name">Описание объявления:</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col2">
                                    <#list category as category>
                                        <div>
                                            <a>${category.name}<input id="category" type="radio" name="category"
                                                                      value="${category.id}"></a>
                                        </div>
                                    </#list>
                                </div>
                                <div class="col2">
                                    <#list brands as brand>
                                        <div>
                                            <a>${brand.name}<input id="brand" type="radio" name="brand"
                                                                   value="${brand.id}"></a>
                                        </div>
                                    </#list>
                                </div>
                                <div class="col2">
                                    <#list colors as color>
                                        <div>
                                            <a>${color.name}<input id="color" type="radio" name="color"
                                                                   value="${color.id}"></a>
                                        </div>
                                    </#list>
                                </div>
                            </div>
                            <div class="row">
                                <input class="inp" type="number" name="price"/>
                                <label for="name">Цена:</label>
                            </div>
                            <div class="row">
                                Первая фотография: <input class="inp" type="file" name="fileProduct1"/><br><br>
                                Вторая фотография: <input class="inp" type="file" name="fileProduct2"/><br><br>
                                Третья фотография: <input class="inp" type="file" name="fileProduct3"/><br><br>
                            </div>
                            <div class="row">
                                <div id="dimensions-container">
                                    <div class="dimension-row">
                                        <label for="dimension">Размер</label>
                                        <input class="inp" type="text" id="dimension" name="dimension">
                                        <label for="quantity">Количество</label>
                                        <input class="inp" type="number" id="quantity" name="quantity">
                                    </div>
                                </div>
                                <button type="button" onclick="addDimensionRow()">Добавить размер</button>
                            </div>
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input class="inp" type="submit" value="Добавить">
                        </form>
                    </dd>
                    <#list products as product>
                        <dt>
                            <a href="#accordion1" aria-expanded="false" aria-controls="accordion1"
                               class="accordion-title accordionTitle js-accordionTrigger">Номер: ${product.id}
                                Название:${product.title}, Цена ${product.price}
                            </a>
                        </dt>
                        <dd class="accordion-content accordionItem is-collapsed" id="accordion1"
                            aria-hidden="true">
                            <form action="/admin/products/update/${product.id}" method="post"
                                  enctype="multipart/form-data">
                                <table>

                                    <thead>
                                    <tr>
                                        <th scope="col">Id</th>
                                        <th scope="col">Название</th>
                                        <th scope="col">Фото</th>
                                        <th scope="col">Описание</th>
                                        <th scope="col">Цена</th>
                                        <th scope="col">Категорий</th>
                                        <th scope="col">Бренд</th>
                                        <th scope="col">Цвет</th>
                                        <th scope="col">Ссылка на товар</th>
                                        <th scope="col">Обновить</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td data-label="Id">${product.id}</td>
                                        <td data-label="Название"><input class="inp" type="text" name="title"
                                                                         value="${product.title}">
                                        </td>
                                        <td data-label="Фото"><img src="/images/${product.previewImageId}"
                                                                   alt="не указана"
                                                                   id="product-main-image"
                                                                   width="100px"></td>
                                        <td data-label="Описание"><input class="inp" type="text" name="description"
                                                                         value=" ${product.description}"></td>
                                        <td data-label="Цена"><input class="inp" type="text" name="price"
                                                                     value=" ${product.price}"></td>
                                        <td data-label="Категорий">${product.category.name}</td>
                                        <td data-label="Бренд">${product.brand.name}</td>
                                        <td style="background: ${product.color.style}"
                                            data-label="Цвет">${product.color.style}</td>
                                        <td datatype="Ссылка на товар"><a href="/product/${product.id}"><input
                                                        class="inp" value="Подробнее..."></a></td>
                                        <td data-label="Обновить">
                                            <input type="hidden" name="_csrf"
                                                   value="${_csrf.token}">
                                            <button class="bttn" type="submit">Изменить</button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div style="display:flex;">
                                    <div class="row">
                                        <div class="col2">
                                            <#list category as category>
                                                <div>
                                                    <a>${category.name}
                                                        <input id="category" type="radio" name="category"
                                                               value="${category.id}"
                                                               <#if product.category.id == category.id>checked</#if>></a>

                                                </div>
                                            </#list>
                                        </div>
                                        <div class="col2">
                                            <#list brands as brand>
                                                <div>
                                                    <a>${brand.name}<input id="brand" type="radio" name="brand"
                                                                           value="${brand.id}"
                                                                           <#if product.brand.id == brand.id>checked</#if>></a>
                                                </div>
                                            </#list>
                                        </div>
                                        <div class="col2">
                                            <#list colors as color>
                                                <div>
                                                    <a>${color.name}<input id="color" type="radio" name="color"
                                                                           value="${color.id}"
                                                                           <#if product.color.id == color.id>checked</#if>></a>
                                                </div>
                                            </#list>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <input type="number" name="promotionalPrice" value="${product.promotionalPrice}"/>
                                    <label for="name">Скидочная цена:</label>
                                </div>
                                <div class="row">
                                    Первая фотография: <input type="file" name="fileProduct1"/><br><br>
                                    Вторая фотография: <input type="file" name="fileProduct2"/><br><br>
                                    Третья фотография: <input type="file" name="fileProduct3"/><br><br>
                                </div>
                                <#if product.dimensions?has_content>
                                    <div class="row" style="display:flex;">
                                        <div id="dimensions-container">
                                            <#list product.dimensions  as sizes,quantity>
                                                <div class="dimension-row">
                                                    <label for="dimension">Размер</label>
                                                    <input type="text" id="dimension" value="${sizes}" name="dimension">
                                                    <label for="quantity">Количество</label>
                                                    <input type="number" id="quantity" value="${quantity}" name="quantity">
                                                </div>
                                            </#list>
                                        </div>
                                    </div>
                                <#else>
                                    <div class="row">
                                        <div id="dimensions-container-pr">
                                            <div class="dimension-row-pr">
                                                <label for="dimension">Размер</label>
                                                <input type="text" id="dimension" name="dimension">
                                                <label for="quantity">Количество</label>
                                                <input type="number" id="quantity" name="quantity">
                                            </div>
                                        </div>
                                        <button type="button" onclick="addDimensionRowPr()">Добавить размер</button>
                                    </div>

                                </#if>
                            </form>
                            <form style="display: flex;justify-content: center;"
                                  action="/admin/products/delete/${product.id}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <button class="bttn" type="submit">Удалить</button>
                            </form>
                        </dd>
                    <#else>
                        <h3>Товаров нет </h3>
                    </#list>
                </dl>
            </div>
        </div>

        <script>
            function addDimensionRow() {
                const container = document.getElementById('dimensions-container');
                const newRow = document.createElement('div');
                newRow.className = 'dimension-row';
                newRow.innerHTML = `
        <label for="dimension">Размер</label>
        <input type="text" name="dimension">
        <label for="quantity">Количество</label>
        <input type="number" name="quantity">
        <button type="button" onclick="removeDimensionRow(this)">Удалить размер</button>
    `;
                container.appendChild(newRow);
            }

            function removeDimensionRow(button) {
                button.parentNode.remove();
            }
        </script>


        <script>
            function addDimensionRowPr() {
                const container = document.getElementById('dimensions-container-pr');
                const newRow = document.createElement('div');
                newRow.className = 'dimension-row-pr';
                newRow.innerHTML = `
        <label for="dimension">Размер</label>
        <input type="text" name="dimension">
        <label for="quantity">Количество</label>
        <input type="number" name="quantity">
        <button type="button" onclick="removeDimensionRow(this)">Удалить размер</button>
    `;
                container.appendChild(newRow);
            }

            function removeDimensionRow(button) {
                button.parentNode.remove();
            }
        </script>
        <script>
            (function () {
                var d = document,
                    accordionToggles = d.querySelectorAll('.js-accordionTrigger'),
                    setAria,
                    setAccordionAria,
                    switchAccordion,
                    touchSupported = ('ontouchstart' in window),
                    pointerSupported = ('pointerdown' in window);

                skipClickDelay = function (e) {
                    e.preventDefault();
                    e.target.click();
                }

                setAriaAttr = function (el, ariaType, newProperty) {
                    el.setAttribute(ariaType, newProperty);
                };
                setAccordionAria = function (el1, el2, expanded) {
                    switch (expanded) {
                        case "true":
                            setAriaAttr(el1, 'aria-expanded', 'true');
                            setAriaAttr(el2, 'aria-hidden', 'false');
                            break;
                        case "false":
                            setAriaAttr(el1, 'aria-expanded', 'false');
                            setAriaAttr(el2, 'aria-hidden', 'true');
                            break;
                        default:
                            break;
                    }
                };
//function
                switchAccordion = function (e) {
                    console.log("triggered");
                    e.preventDefault();
                    var thisAnswer = e.target.parentNode.nextElementSibling;
                    var thisQuestion = e.target;
                    if (thisAnswer.classList.contains('is-collapsed')) {
                        setAccordionAria(thisQuestion, thisAnswer, 'true');
                    } else {
                        setAccordionAria(thisQuestion, thisAnswer, 'false');
                    }
                    thisQuestion.classList.toggle('is-collapsed');
                    thisQuestion.classList.toggle('is-expanded');
                    thisAnswer.classList.toggle('is-collapsed');
                    thisAnswer.classList.toggle('is-expanded');

                    thisAnswer.classList.toggle('animateIn');
                };
                for (var i = 0, len = accordionToggles.length; i < len; i++) {
                    if (touchSupported) {
                        accordionToggles[i].addEventListener('touchstart', skipClickDelay, false);
                    }
                    if (pointerSupported) {
                        accordionToggles[i].addEventListener('pointerdown', skipClickDelay, false);
                    }
                    accordionToggles[i].addEventListener('click', switchAccordion, false);
                }
            })();
        </script>
    </main>
    <!-- MAIN -->
</section>
<!-- CONTENT -->
<script>

    const allSideMenu = document.querySelectorAll('#sidebar .side-menu.top li a');

    allSideMenu.forEach(item => {
        const li = item.parentElement;

        item.addEventListener('click', function () {
            allSideMenu.forEach(i => {
                i.parentElement.classList.remove('active');
            })
            li.classList.add('active');
        })
    });


    // TOGGLE SIDEBAR
    const menuBar = document.querySelector('#content nav .bx.bx-menu');
    const sidebar = document.getElementById('sidebar');

    menuBar.addEventListener('click', function () {
        sidebar.classList.toggle('hide');
    })


    const searchButton = document.querySelector('#content nav form .form-input button');
    const searchButtonIcon = document.querySelector('#content nav form .form-input button .bx');
    const searchForm = document.querySelector('#content nav form');


    const switchMode = document.getElementById('switch-mode');

    switchMode.addEventListener('change', function () {
        if (this.checked) {
            document.body.classList.add('dark');
        } else {
            document.body.classList.remove('dark');
        }
    })
</script>
</body>
</html>
