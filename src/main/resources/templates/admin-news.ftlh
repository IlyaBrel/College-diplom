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

    <title>Панель администратора(Новости)</title>
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
                           class="accordion-title accordionTitle js-accordionTrigger">Новая новость
                        </a>
                    </dt>
                    <dd class="accordion-content accordionItem is-collapsed" id="accordion1"
                        aria-hidden="true">
                        <form action="/admin/news/create" method="post"
                              enctype="multipart/form-data">
                            <div class="row">
                                <div class="col2">
                                    <input class="inp" type="text" name="title">
                                    <label for="name">Название новости:
                                    </label>
                                </div>
                                <div class="col2">
                                    <input class="inp" type="text" name="description"/>
                                    <label for="name">Описание объявления:</label>
                                </div>
                            </div>

                            <div class="row">
                                <input class="inp" type="text" name="underTitleText"/>
                                <label for="name">Текст под названием:</label>
                            </div>
                            <div class="row">
                                <div class="col2">
                                    <div style="display:flex;">
                                        <#list products as product>
                                            <div style="display: flex; margin: 10px">
                                                <label  style="display: flex;" >
                                                    ${product.title}
                                                    <input type="checkbox" name="productsId" value="${product.id}">
                                                </label>
                                            </div>
                                        </#list>
                                    </div>
                                </div>

                            </div>
                            <div class="row">
                                Фото: <input type="file" name="file"/><br><br>
                            </div>
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input class="inp" type="submit" value="Добавить">
                        </form>
                    </dd>
                    <#list news as news>
                        <dt>
                            <a href="#accordion1" aria-expanded="false" aria-controls="accordion1"
                               class="accordion-title accordionTitle js-accordionTrigger">Номер: ${news.id}
                                Название:${news.title}
                            </a>
                        </dt>
                        <dd class="accordion-content accordionItem is-collapsed" id="accordion1"
                            aria-hidden="true">
                            <form action="/admin/news/update/${news.id}" method="post"
                                  enctype="multipart/form-data">
                                <table>

                                    <thead>
                                    <tr>
                                        <th scope="col">Id</th>
                                        <th scope="col">Название</th>
                                        <th scope="col">Новость под гл.</th>
                                        <th scope="col">Фото</th>
                                        <th scope="col">Описание</th>
                                        <th scope="col">Новое изображение</th>
                                        <th scope="col" style="width: 300px;">Товары</th>
                                        <th scope="col">Обновить</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td data-label="Id">${news.id}</td>
                                        <td data-label="Название"><input class="inp" type="text" name="title"
                                                                         value="${news.title}">
                                        </td>
                                        <td data-label="Новость под гл."><input class="inp" type="text"
                                                                                name="underTitleText"
                                                                                value=" ${news.underTitleText}"></td>
                                        <td data-label="Фото"><img src="/images/${news.previewImageId}"
                                                                   alt="не указана"
                                                                   id="product-main-image"
                                                                   width="100px"></td>
                                        <td data-label="Описание"><input class="inp" type="text" name="description"
                                                                         value=" ${news.description}"></td>
                                        <td data-label="Новое изображение"><input type="file" name="file"></td>
                                        <td data-label="Товары">
                                        </td>
                                        <td data-label="Обновить">
                                            <input type="hidden" name="_csrf"
                                                   value="${_csrf.token}">
                                            <button class="bttn" type="submit">Изменить</button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div style="display:flex;">
                                    <#list products as product>
                                        <div style="display: flex; margin: 10px">
                                            <label  style="display: flex;" >
                                                ${product.title}
                                                <input type="checkbox" name="productsId" value="${product.id}" <#if news.productsId?seq_contains(product.id)>checked</#if>>
                                            </label>
                                        </div>
                                    </#list>
                                </div>
                            </form>
                            <form style="display: flex;justify-content: center;"
                                  action="/admin/news/delete/${news.id}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <button class="bttn" type="submit">Удалить</button>
                            </form>
                        </dd>
                    <#else>
                        <h3>Новостей нет </h3>
                    </#list>
                </dl>
            </div>
        </div>

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
