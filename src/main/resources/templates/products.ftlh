<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html"
      xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Boxicons -->

    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <!-- My CSS -->
    <link rel="stylesheet" href="../static/css/homep.css">

    <title>Товары</title>
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
                <a href="/category">
                    <i class='bx bxs-shopping-bag-alt'></i>
                    <span class="text">Категории</span>
                </a>
            </li>
            <li class="active">
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
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input class="logout-out" type="submit" value="Выйти"/>Выйти
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
            <a href="#" class="nav-link">Товары</a>
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
                <#--<img src="img/people.png">-->
            </a>
        </nav>
        <!-- NAVBAR -->

        <!-- MAIN -->
        <main>
            <form action="/products" method="get">
                <div class="form-input">
                    <input type="text" id="title" name="title" placeholder="Поиск...">
                    <button type="submit" class="search-btn"><i class='bx bx-search'></i></button>
                </div>
            </form>
            <div class="filters-dropdown">
                <#if user.email??>
                    <form id="filter-form" style="flex-wrap: wrap;" action="/products/filter/add" method="post"
                          enctype="multipart/form-data">
                        <!-- Категория -->
                        <div class="checkbox-dropdown" style="z-index: 9999;">
                            Категория
                            <ul class="checkbox-dropdown-list">
                                <#list  category as category>
                                    <li>
                                        <label>
                                            <input type="checkbox" value="${category.name}" id="filter1"
                                                   class="filter-checkbox"
                                                   name="category"/>${category.name}
                                        </label>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                        <div class="checkbox-dropdown" style="z-index: 9998;">
                            Бренд
                            <ul class="checkbox-dropdown-list">
                                <#list brands as brand>
                                    <li>
                                        <label>
                                            <input type="checkbox" value="${brand.name}" id="filter2"
                                                   name="brand"/>${brand.name}
                                        </label>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                        <div class="checkbox-dropdown" style="z-index: 9997;">
                            Размер
                            <ul class="checkbox-dropdown-list">
                                <#list allSizes as size>
                                    <li>
                                        <label>
                                            <input type="checkbox" value="${size}" name="dimension"/>${size}</label>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                        <div class="checkbox-dropdown" style="z-index: 9996;">
                            Цвет
                            <ul class="checkbox-dropdown-list">
                                <#list colors as color>
                                    <li>
                                        <label>
                                            <input type="checkbox" value="${color.name}" id="filter3"
                                                   name="color"/>${color.name}
                                        </label>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                        <div class="checkbox-dropdown" style="z-index: 9995;">
                            Цена
                            <ul class="checkbox-dropdown-list">
                                <li>
                                    <label>
                                        <input type="text" id="filter4" value="${minPrice}" name="minPrice"/>Минимальная
                                        цена
                                    </label>
                                </li>
                                <li>
                                    <label>
                                        <input type="text" id="filter5" value="${maxPrice}" name="maxPrice"/>Максимальная
                                        цена
                                    </label>
                                </li>
                            </ul>
                        </div>

                        <button class="button-submit-filter" type="submit">Применить фильтры
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                        </button>
                    </form>
                <#else>
                    <a style="margin: 20px; cursor: pointer" href="/login"><label>Войдите чтобы откыть возможность
                            добавления фильтров</label></a>
                </#if>

                <style>
                    /* Стили для выбранных фильтров */
                    .selected-filter {
                        display: inline-block;
                        margin-right: 5px;
                        margin-bottom: 5px;
                        padding: 5px;
                        background-color: #eee;
                        border: 1px solid #ccc;
                        border-radius: 3px;
                    }

                    .remove-filter {
                        cursor: pointer;
                        margin-left: 5px;
                    }
                </style>
                <style>
                    /* CSS код */
                    .checkbox-dropdown {
                        font-family: 'Montserrat', sans-serif;
                        border-radius: 10px;
                        width: 200px;
                        border: 1px solid var(--blue);
                        padding: 10px;
                        position: relative;
                        z-index: 9999;
                        background: var(--blue);
                        color: var(--light);
                        margin: 10px;
                        user-select: none;
                        cursor: pointer;
                        flex-wrap: wrap;
                    }

                    /* Display CSS arrow to the right of the dropdown text */
                    .checkbox-dropdown:after {
                        content: '';
                        height: 0;
                        position: absolute;
                        width: 0;
                        border: 6px solid transparent;
                        border-top-color: #000;
                        top: 50%;
                        right: 10px;
                        margin-top: -3px;
                    }

                    /* Reverse the CSS arrow when the dropdown is active */
                    .checkbox-dropdown:hover:after {
                        border-bottom-color: #000;
                        border-top-color: #fff;
                        margin-top: -9px;
                        border-radius: 10px 10px 0 0;
                    }


                    .checkbox-dropdown-list {
                        list-style: none;
                        margin: 0;
                        padding: 0;
                        position: absolute;
                        top: 100%;
                        border: inherit;
                        border-top: none;
                        left: -1px;
                        right: -1px;
                        opacity: 0;
                        transition: opacity 0.4s ease-in-out;
                        height: auto;
                        overflow-x: hidden;
                        pointer-events: none;
                        background: var(--light);
                        border-radius: 10px;
                    }

                    .checkbox-dropdown:hover .checkbox-dropdown-list {
                        opacity: 1;
                        pointer-events: auto;
                    }

                    .checkbox-dropdown-list li label {
                        color: black;
                        display: block;
                        border-bottom: 1px solid #ccc;
                        padding: 5px;
                    }

                    .checkbox-dropdown-list li label:hover {
                        background-color: #618ef6;
                        color: white;
                    }

                    .button-submit-filter {
                        font-family: 'Montserrat', sans-serif;
                        border-radius: 10px;
                        width: 200px;
                        border: 5px solid var(--blue);
                        padding: 10px;
                        position: relative;
                        z-index: 9994;
                        background: var(--light);
                        color: var(--dark);
                        margin: 10px;
                        user-select: none;
                        cursor: pointer;
                    }


                    @media screen and (max-width: 768px) {
                        .checkbox-dropdown {
                            width: 100%;
                            margin: 10px 0;
                        }
                    }

                    @media screen and (max-width: 576px) {
                        .filters-dropdown {
                            display: flex;
                            flex-wrap: wrap;
                        }

                        .checkbox-dropdown {
                            width: calc(50% - 20px);
                            margin: 10px;
                        }
                    }

                    .filters-dropdown {
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }
                </style>
            </div>
            <div class="selectedFiltersContainer">
                <#if selectedFilterParam?has_content>
                    <span class="filter-text"><h3>Выбранные фильтры</h3></span>
                    <div class="all-find-filters">
                        <#list selectedFilterParam as filter>
                            <form action="/products/filter/delete/${filter}" method="post">
                                <div class="find-filter">
                                    <label>${filter}
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        <button class="button-delete-filter" value="${filter_index}"><i
                                                    class='bx bx-x'></i>
                                        </button>
                                    </label>
                                </div>
                            </form>
                        </#list>
                        <form action="/products/filter/remove" method="post">
                            <div class="remove-filters">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <button class="button-removeAll-filters" type="submit">Сбросить фильтры</button>
                                </label>
                            </div>
                        </form>
                    </div>
                <#else>
                    <style>
                        .selectedFiltersContainer {
                            visibility: hidden;
                        }
                    </style>
                </#if>
            </div>

            <ul class="box-popular-products">
                <#list products as product>
                    <#if product.popular>
                        <a href="/product/${product.id}">
                            <li>
                                <#if product.promotionalPrice != 0 >
                                <div class="badge">
                                    <#assign discountPercentage = (product.price-product.promotionalPrice)/product.price * 100>
                                    -${discountPercentage?int}%
                                </div>
                                <div class="p-c">
                                    </#if>
                                    <i> <img class="img-cat" src="/images/${product.previewImageId}"
                                             height="150px"/></i>
                                    <span class="text-pr">
						<h3>${product.title} </p></h3>
                        <p>${product.description}</p>
                            <div class="product-price">
                            <#if product.promotionalPrice != 0 >
                                <span class="offer-price">${product.promotionalPrice} р.</span>
                                <span class="sale-price">${product.price} р.</span>
                                <#else>
                                <span class="offer-price">${product.price} р.</span>
                            </#if>
                            </span>
                                </div>
                                </div>

                                </h4>
                                </span>
                                </div>
                            </li>
                        </a>
                        <style>
                            #content main .box-popular-products {
                                margin: 0 200px 0 200px;
                                display: grid;
                                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                                grid-gap: 24px;
                                /* margin-top: 36px; */
                            }

                            @media screen and (max-width: 1400px) {
                                #content main .box-popular-products {
                                    margin: 0 0 0 0;
                                }
                            }
                        </style>
                    </#if>
                </#list>
            </ul>
        </main>
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
                                <form class="delete-btn" action="/cart/delete/${product_index}" method="post"
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
                                <span>White</span>
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
                <div class="btn open"><img src="https://i.ibb.co/brq1tJj/shopping-cart.png" height="27px" alt=""/></div>
            </label>
        </div>
        <!-- MAIN -->

    </section>

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