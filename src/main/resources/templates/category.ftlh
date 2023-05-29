<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html"
      xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Boxicons -->

    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <!-- My CSS -->

    <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
    <script src="/js/google-translate.js"></script>
    <script src="//translate.google.com/translate_a/element.js?cb=TranslateInit"></script>

    <link rel="stylesheet" href="../static/css/homep.css">
    <title>Категории</title>
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
            <li class="active">
                <a href="/category">
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
        <ul class="side-menu">
            <li>
                <#if user.email??>
                <a href="/user/${user.id}">
                    <i class='bx bxs-cog'></i>
                    <span class="text">Мой аккаунт</span>
                </a>
            </li>
            <li>
                <a class="logout">
                    <i class='bx bxs-log-out-circle'></i>
                    <form class="logout-main" action="/logout" method="post">
                    <span class="text"><input type="hidden" name="_csrf" value="${_csrf.token}">
                    <input class="logout-out" type="submit" value="Выйти"/>Выйти
                </span>
                    </form>
                </a>

                <#if user.isAdmin()>
                    <a href="/admin">Панель администратора</a>
                </#if>
                <#else>
                <a href="/login">
                    <i class='bx bx-log-in'></i>
                    <span class="text">Войти
                    </span>
                    </#if>
                </a>
            </li>
        </ul>
    </section>
    <!-- SIDEBAR -->


    <!-- CONTENT -->
    <section id="content">
        <!-- NAVBAR -->
        <nav>
            <i class='bx bx-menu'></i>
            <a href="#" class="nav-link">Категории</a>
            <form action="#">
                <div class="form-input">
                    <#--                <input type="search" placeholder="Search...">-->
                    <#--                <button type="submit" class="search-btn"><i class='bx bx-search'></i></button>-->
                </div>
            </form>
            <input type="checkbox" id="switch-mode" hidden>
            <label for="switch-mode" class="switch-mode"></label>
            <#if user.email??>
                <a href="/user/${user.id}" class="profile">
                    <i class='bx bxs-user'></i>
                </a>
            </#if>
            <a href="#" class="profile">
            </a>
        </nav>
        <!-- NAVBAR -->

        <!-- MAIN -->
        <main>
            <div class="head-title">
                <div class="left">
                    <h1>Категории
                        <div class="badge-under-text"></div>
                    </h1>
                </div>
            </div>
            <ul class="box-category" style="grid-template-columns: repeat(auto-fit, minmax(76px, 1fr));">
                <#list categorys as category>
                    <#if category_index < 10>
                        <li>
                            <form action="/products/one/filter/${category.name}" method="post">
                                <button class="button-post-category">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    <img class="img-cat" src="/images/${category.previewImageId}" height="50px"/>
                                    <span class="text"><h3>${category.name}</h3></span>
                                </button type="submit">
                            </form>
                        </li>
                    </#if>
                </#list>
            </ul>
            <div class="head-title">
                <div class="left">
                    <h1>Бренды
                        <div class="badge-under-text"></div>
                    </h1>
                </div>
            </div>
            <ul class="box-category">
                <#list brands as brand>
                    <#if brand_index < 6>
                        <li>
                            <form action="/products/one/filter/brand/${brand.name}" method="post">
                                <button class="button-post-category">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    <span class="text"><h3>${brand.name}</h3></span>
                                </button type="submit">
                            </form>
                        </li>
                    </#if>
                </#list>
            </ul>
            <div class="head-title">
                <div class="left">
                    <h1>Цвета
                        <div class="badge-under-text"></div>
                    </h1>
                </div>
            </div>
            <ul class="box-category">
                <#list colors as color>
                    <#if color_index < 9>
                        <li style="background: ${color.style} ">
                            <form action="/products/one/filter/brand/${color.name}" method="post">
                                <button class="button-post-category">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                </button type="submit">
                            </form>
                        </li>
                    </#if>
                </#list>
            </ul>
        </main>
        <#if user.email??>
            <input type="checkbox" id="checkbox"/>
            <div class="panel">
                <div class="start">
                    <div class="shopping-cart" bis_skin_checked="1">
                        <!-- Title -->
                        <div class="title" bis_skin_checked="1">
                            Корзина
                        </div>
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
                    </div>
                </div>

                <div class="shopping-cart-end" bis_skin_checked="1">
                    <!-- Title -->
                    <div class="badge-under-text"></div>
                    <div class="price"
                         style="font-weight: 600;
                 font-size: 20px;
                 display: flex;
                 justify-content: flex-end;">
                        Итоговая цена: ${cartInfo}
                    </div>
                    <div class="buttons">
                        <div class="back">
                            <label class="panel-btn-close" for="checkbox"><i class='bx bx-chevrons-left'></i>
                                <style>
                                    .bx bx-chevrons-left {
                                        min-width: calc(60px - ((4px + 6px) * 2));
                                        display: flex;
                                        justify-content: center;
                                    }
                                </style>
                            </label>
                        </div>
                        <a href="/order">
                            <button class="checkout" type="submit">Оформить заказ</button>
                        </a>

                    </div>
                </div>
            </div>


            <div class="button-wrap">
                <label class="button-1" for="checkbox">
                    <div class="btn open"><img src="https://i.ibb.co/brq1tJj/shopping-cart.png" height="27px" alt=""/>
                    </div>
                </label>
            </div>
        <#else>
            <style>
                .panel {
                    visibility: hidden;
                }

                .button-wrap {
                    visibility: hidden;
                }
            </style>
        </#if>


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


        if (window.innerWidth < 768) {
            sidebar.classList.add('hide');
        } else if (window.innerWidth > 576) {
            searchForm.classList.remove('show');
        }


        window.addEventListener('resize', function () {
            if (this.innerWidth > 576) {
                searchButtonIcon.classList.replace('bx-x', 'bx-search');
                searchForm.classList.remove('show');
            }
        })


        const switchMode = document.getElementById('switch-mode');

        switchMode.addEventListener('change', function () {
            if (this.checked) {
                document.body.classList.add('dark');
            } else {
                document.body.classList.remove('dark');
            }
        })


        const dropdowns = document.querySelectorAll('.checkbox-dropdown');

        // Добавляем обработчик события на каждый элемент
        dropdowns.forEach(dropdown => {
            const dropdownList = dropdown.querySelector('.checkbox-dropdown-list');
            dropdown.addEventListener('click', () => {
                dropdownList.classList.toggle('visible');
            });
        });
    </script>
</#if>
</body>
</html>