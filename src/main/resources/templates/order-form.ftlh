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
    <link rel="stylesheet" href="../static/css/ca.css">

    <title>Оформление заказа</title>
</head>
<body>
<#if user.activationCode??>
    <div style="font-weight: 600;
    font-family: var(--lato);
    top: 40%;
    text-align: center;
    position: absolute;
    left: 30%;">
        Подтвердите регистрацию аккаунта.<br>
        Вам на почту которую вы указали при регистрации было выслано сообщение с подтверждением.
        <form action="/email/message/${user.id}" method="post" style="margin: 10px;">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <div style=" display: flex;justify-content: center;">
                <button type="submit" style="
    display: flex;
    align-items: center;
    justify-content: center;
    /* gap: 1240px; */
    padding: 10px 24px;
    font-size: 16px;
    font-weight: 500;
    width: auto;
    background-color: var(--blue);
    color: #fff;
    border: 1px solid var(--blue-dark);
    border-radius: 10px;
    cursor: pointer;
    height: 50px;
">Выслать повторное подтверждение.
                </button>
            </div>
            <div style="color:red; font-weight: 800; margin: 20px">
                <#if messageMail??>
                    ${messageMail}
                </#if>
            </div>
        </form>
    </div>
<#else>

    <!-- SIDEBAR -->
    <section id="sidebar">
        <a href="#" class="brand">
            <i class='bx bxs-smile'></i>
            <span class="text">BELLSELL</span>
        </a>
        <ul class="side-menu top">
            <li>
                <a href="/">
                    <i class='bx bxs-dashboard'></i>
                    <span class="text">Главная</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class='bx bxs-shopping-bag-alt'></i>
                    <span class="text">Категории</span>
                </a>
            </li>
            <li>
                <a href="/products">
                    <i class='bx bxs-doughnut-chart'></i>
                    <span class="text">Товары</span>
                </a>
            </li>
            <li>
                <a href="/contact">
                    <i class='bx bxs-message-dots'></i>
                    <span class="text">Контакты</span>
                </a>
            </li>
            <li>
                <a href="/faq">
                    <i class='bx bxs-group'></i>
                    <span class="text">О нас</span>
                </a>
            </li>
        </ul>
        <#--    <ul class="side-menu">-->
        <#--        <li>-->
        <#--            <a href="#">-->
        <#--                <i class='bx bxs-cog'></i>-->
        <#--                <span class="text">Настройки</span>-->
        <#--            </a>-->
        <#--        </li>-->
        <#--        <li>-->
        <#--            <#if user.email??>-->
        <#--            <a class="logout">-->

        <#--                <i class='bx bxs-log-out-circle'></i>-->
        <#--                <form class="logout-main" action="/logout" method="post">-->
        <#--                    <span class="text"><input type="hidden" name="_csrf" value="${_csrf.token}">-->
        <#--                    <input class="logout-out" type="submit" value="Выйти"/>Выйти-->
        <#--                </span>-->
        <#--                </form>-->
        <#--            </a>-->
        <#--            <#else>-->
        <#--            <a href="/login">-->
        <#--                <i class='bx bx-log-in'></i>-->
        <#--                <span class="text">Войти-->
        <#--                    </span>-->
        <#--                </#if>-->
        <#--            </a>-->
        <#--        </li>-->
        </ul>
    </section>

    <section id="content">
        <!-- NAVBAR -->
        <nav>
            <i class='bx bx-menu'></i>
            <a href="#" class="nav-link">Оформлеие заказа</a>

            <input type="checkbox" id="switch-mode" style="visibility: hidden">
            <label for="switch-mode" class="switch-mode"></label>
            <#if user.email??>
                <a href="/user/${user.id}" class="profile">
                    <i class='bx bxs-user'></i>
                </a>
            </#if>
            <a href="#" class="profile">
                <#--<img src="img/people.png">-->
            </a>
        </nav>
        <!-- NAVBAR -->

        <!-- MAIN -->
        <main>
            <div class="container">
                <div class="contain-two-form">
                    <form id="myform" action="/order/new" method="post">
                        <header>Форма оформления заказа</header>
                        <div class="badge-under-text"></div>

                        <div class="area">
                            <div id="formbacket-in-myform">
                                <div class="panel" style="display: flex; justify-content: center">
                                    <div class="start">
                                        <div class="shopping-cart" bis_skin_checked="1">
                                            <!-- Title -->
                                            <div class="title" bis_skin_checked="1">
                                                Корзина
                                            </div>
                                            <#if cart?has_content>
                                                <#list cart as product>
                                                    <div class="item">
                                                        <div class="buttons">
                                                            <div class="badge">
                                                                <#assign discountPercentage = (product.price-product.promotionalPrice)/product.price * 100>
                                                                -${discountPercentage?int}%
                                                            </div>
                                                        </div>
                                                        <div class="image">
                                                            <img class="image-p" src="/images/${product.previewImage}"
                                                                 alt="">
                                                        </div>
                                                        <div class="description">
                                                            <span>${product.title}</span>
                                                            <#--                                                    <span>${product.a}</span>-->
                                                            <span>White</span>
                                                        </div>
                                                        <div class="total">
                                                            <span>${product.price} р.</span></div>
                                                    </div>
                                                </#list>
                                            </#if>
                                        </div>
                                        <div>
                                            <div class="panel-end">
                                                <span class="text-total-price">Итоговая цена</span>
                                                <div class="badge-under-text"></div>
                                                <#--                                            <span style="font-weight: 800; padding: 10px 0 ">${.vars['total-price']} р.</span>-->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <#if emptyFields?has_content>
                                <span style="display: flex; justify-content: center;max-width: 720px;flex-wrap: wrap;"><p
                                            style="color: var(--dark); font-weight: 600">Поля: </p>
                                <#list emptyFields as field>
                                    <p style="color: var(--red); font-weight: 700">${field}</p>
                                </#list>  <p style="color: var(--dark); font-weight: 600"> обязательны к заполнению.</p></span>
                            </#if>
                            <div class="row">
                                <div class="col2">
                                    <#if postalDataNotEmpty.lastName?has_content>
                                        <input type="text" value="${postalDataNotEmpty.lastName}" name="lastName">
                                    <#else>
                                        <input type="text" name="lastName">
                                    </#if>
                                    <label for="lastName">Фамилия
                                    </label>
                                </div>
                                <div class="col2">
                                    <#if postalDataNotEmpty.name?has_content>
                                        <input type="text" value="${postalDataNotEmpty.name}" name="name">
                                    <#else>
                                        <input type="text" name="name">
                                    </#if>
                                    <label for="name">Имя
                                    </label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col2">
                                    <#if postalDataNotEmpty.surname?has_content>
                                        <input type="text" value="${postalDataNotEmpty.surname}" name="surname">
                                    <#else>
                                        <input type="text" name="surname">
                                    </#if>

                                    <label for="surname">Отчество

                                    </label>
                                </div>
                                <div class="col2">
                                    <#if postalDataNotEmpty.postalIndex?has_content>
                                        <input type="number" value="${postalDataNotEmpty.postalIndex}"
                                               name="postalIndex">
                                    <#else>
                                        <input type="number" name="postalIndex">
                                    </#if>
                                    <label for="postalIndex">Почтовый индекс
                                    </label>
                                </div>
                            </div>
                            <div class="row">
                                <#if postalDataNotEmpty.phoneNumber?has_content>
                                    <input type="number" value="${postalDataNotEmpty.phoneNumber}" name="phoneNumber"
                                           id="phone">
                                <#else>
                                    <input type="number" name="phoneNumber" id="phone">
                                </#if>
                                <label for="phone">Номер телефона
                                </label>
                            </div>
                            <div class="row">
                                <#if postalDataNotEmpty.city?has_content>
                                    <input type="text" value="${postalDataNotEmpty.city}" name="city" id="city">
                                <#else>
                                    <input type="text" name="city" id="city">
                                </#if>
                                <label for="city">Город
                                </label>
                            </div>
                            <div class="row">
                                <#if postalDataNotEmpty.street?has_content>
                                    <input type="text" value="${postalDataNotEmpty.street}" name="street" id="street">
                                <#else>
                                    <input type="text" name="street" id="street">
                                </#if>
                                <label for="street">Улица
                                </label>
                            </div>
                            <div class="row">
                                <#if postalDataNotEmpty.houseNumber??>
                                    <input type="text" value="${postalDataNotEmpty.houseNumber}" name="houseNumber"
                                           id="houseNumber">
                                <#else>
                                    <input type="text" name="houseNumber" id="houseNumber">
                                </#if>
                                <label for="houseNumber">Номер подъезда или дома
                                </label>
                            </div>
                            <div class="row-btn">
                                <#if user.activationCode??>
                                    <div class="popup">
                                        <div class="head">
                                            <div class="icon">
                                                <div class="box">
                                                    <i class='bx bx-x-circle bx-tada bx-rotate-270'></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="body">
                                            <h1>Активируйте ваш аккаунт!</h1>
                                            <p>После регистрации вам было выслано сообщение с сылкой для
                                                подътверждения.</p>
                                            <button class="close-btn">&times; Закрыть</button>
                                        </div>
                                    </div>
                                    <div>
                                        <button id="open-popup" class="btn-submit">Оформить заказ</button>
                                    </div>
                                    <script>
                                        document.querySelector("#open-popup").addEventListener("click", function (event) {
                                            event.preventDefault();
                                            document.querySelector(".popup").classList.add("active");
                                        });
                                        document.querySelector(".popup .close-btn").addEventListener("click", function (event) {
                                            event.preventDefault();
                                            document.querySelector(".popup").classList.remove("active");
                                        });
                                    </script>

                                <#elseif cart?has_content >
                                    <div>
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        <button type="submit" class="btn-submit">Оформить заказ</button>
                                    </div>
                                <#else>
                                    <div class="popup">
                                        <div class="head" style="color: red">
                                            <div class="icon">
                                                <div class="box" style="color: red">
                                                    <i class='bx bx-x-circle bx-tada bx-rotate-270'></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="body">
                                            <h1>Ваша корзина покупок пуста.</h1>
                                            <p>Вы не можете оформить заказ, не имея ничего в корзине.</p>
                                            <button class="close-btn">&times; Закрыть</button>
                                        </div>
                                    </div>
                                    <div>
                                        <button id="open-popup" class="btn-submit">Оформить заказ</button>
                                    </div>
                                    <script>
                                        document.querySelector("#open-popup").addEventListener("click", function (event) {
                                            event.preventDefault();
                                            document.querySelector(".popup").classList.add("active");
                                        });
                                        document.querySelector(".popup .close-btn").addEventListener("click", function (event) {
                                            event.preventDefault();
                                            document.querySelector(".popup").classList.remove("active");
                                        });
                                    </script>
                                </#if>

                                <#if message??>
                                    <div class="popupr">
                                        <div class="headr">
                                            <div class="iconr">
                                                <div class="boxr">
                                                    <i class='bx bx-x-circle bx-tada bx-rotate-270'></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="bodyr">
                                            <div><h1>Готово!</h1></div>
                                            <div><p>${message}</p></div>
                                            <div style="display: flex;justify-content: center;margin: -13px;">
                                                <a href="/products">
                                                    <div class="close-btnr"> Вернуться в магазин</div>
                                                </a></div>
                                        </div>
                                    </div>
                                </#if>
                                <div>
                                    <a href="/products">
                                        <div class="btn">Вернутся к просмотру</div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div id="formbacket">
                        <div class="panel">
                            <div class="start">
                                <div class="shopping-cart" bis_skin_checked="1">
                                    <!-- Title -->
                                    <div class="title" bis_skin_checked="1">
                                        Корзина
                                    </div>
                                    <#if cart?has_content>
                                        <#list cart as product>
                                            <div class="item">
                                                <div class="buttons">
                                                    <form class="delete-btn" action="/cart/delete/${product_index}"
                                                          method="post"
                                                          enctype="multipart/form-data">
                                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                                        <button type="submit" class="button-delete-card">-</button>
                                                    </form>
                                                </div>
                                                <div class="image">
                                                    <img class="image-p" src="/images/${product.previewImage}" alt="">
                                                </div>
                                                <div class="description">
                                                    <span>${product.title}</span>
                                                    <span>${product.size}</span>
                                                </div>
                                                <div class="total">
                                                    <span>${product.price} р.</span></div>
                                            </div>
                                        </#list>
                                    </#if>
                                </div>
                            </div>
                            <div>
                                <div class="panel-end">
                                    <span class="text-total-price">Итоговая цена</span>
                                    <div class="badge-under-text"></div>
                                    <#--                                <span style="font-weight: 800; padding: 10px 0 ">${.vars['total-price']}  р.</span>-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <style>
                        @media screen and (min-width: 1560px) {
                            #formbacket-in-myform {
                                height: 0px;
                                visibility: hidden;
                            }
                        }

                        @media screen and (max-width: 1560px) {
                            #formbacket {
                                visibility: hidden;
                            }

                            #formbacket-in-myform {
                                visibility: visible;
                            }
                        }
                    </style>
                </div>
            </div>
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
</#if>
</body>
</html>
