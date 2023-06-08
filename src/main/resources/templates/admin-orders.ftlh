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

    <title>Панель администратора(Заказы)</title>
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
                    <#list orders as order>
                        <dt>
                            <a href="#accordion1" aria-expanded="false" aria-controls="accordion1"
                               class="accordion-title accordionTitle js-accordionTrigger">Номер: ${order.id}
                                Статус:${order.status}
                                Пользователь: ${order.user.username}</a>
                        </dt>
                        <dd class="accordion-content accordionItem is-collapsed" id="accordion1" aria-hidden="true">
                            <div class="row">
                                <div class="col2">
                                    <input class="inp" type="text" value="${order.postalData.lastName}" name="lastName">
                                    <label for="lastName">Фамилия
                                    </label>
                                </div>
                                <div class="col2">
                                    <input class="inp" type="text" value="${order.postalData.name}" name="name">
                                    <label for="name">Имя
                                    </label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col2">
                                    <input class="inp" type="text" value="${order.postalData.surname}" name="surname">
                                    <label for="surname">Отчество
                                    </label>
                                </div>
                                <div class="col2">
                                    <input class="inp" type="text" value="${order.postalData.postalIndex}"
                                           name="postalIndex">
                                    <label for="postalIndex">Почтовый индекс
                                    </label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col2">
                                    <input class="inp" type="text" value="${order.postalData.phoneNumber}"
                                           name="phoneNumber"
                                           id="phone">
                                    <label for="phone">Номер телефона
                                    </label>
                                </div>
                                <div class="col2">
                                    <input class="inp" type="text" value="${order.postalData.city}" name="city"
                                           id="city">
                                    <label for="city">Город
                                    </label>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col2">
                                    <input class="inp" type="text" value="${order.postalData.street}" name="street"
                                           id="street">
                                    <label for="street">Улица
                                    </label>
                                </div>
                                <div class="col2">
                                    <input class="inp" type="text" value="${order.postalData.houseNumber}"
                                           name="houseNumber"
                                           id="houseNumber">
                                    <label for="houseNumber">Номер подъезда или дома
                                    </label>
                                </div>
                            </div>
                            <div class="row">
                                <label for="">Заказанные товары
                                    <div class="panel">
                                        <div class="start">
                                            <div class="shopping-cart" bis_skin_checked="1">
                                                <#list order.productsIdAndSize as productId, size>
                                                    <div class="item">
                                                        <div class="image">
                                                            <img class="image-p"
                                                                 src="/images/${productService.getProductById(productId).previewImageId}"
                                                                 alt="">
                                                        </div>
                                                        <div class="description">
                                                            <span>${productService.getProductById(productId).category.name}</span>
                                                            <span>${productService.getProductById(productId).title}</span>
                                                            <span>Размер: ${size}</span>
                                                            <div class="badge-under-text"></div>
                                                            <span>Количество отсавшихся товаров, по заказанному размеру:</span>
                                                            <h3>
                                                                <#list  productService.getProductById(productId).dimensions as sizes,quantity>
                                                                    <#if size == sizes>
                                                                        ${productService.getProductById(productId).dimensions[sizes]}
                                                                    </#if>
                                                                </#list>
                                                        </div>
                                                    </div>
                                                </#list>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <#if order.status != 'ДОСТАВЛЕН'>
                                            <#if order.status != 'ОТМЕНЁН'>
                                                <label><h3>Изменить статус</h3></label>

                                                <form class="form-update-status"
                                                      action="/admin/orders/update/${order.id}"
                                                      method="post">
                                                    <#list status as status>
                                                        <div><input id="category" type="radio" name="status"
                                                                    value="${status}"
                                                                    <#if order.status == status>checked</#if>>${status}
                                                        </div>
                                                    </#list>
                                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                                    <input class="inp" type="submit" value="Изменить">
                                                </form>
                                            </#if>
                                        </#if>
                                    </div>
                            </div>
                        </dd>
                    <#else>
                        <h3>Заказов нет нет</h3>
                    </#list>
                </dl>
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
