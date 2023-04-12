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
    <link rel="stylesheet" href="../static/css/homep.css">

    <title>Главная</title>
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
        <li class="active">
            <a href="/products">
                <i class='bx bxs-doughnut-chart'></i>
                <span class="text">Товары</span>
            </a>
        </li>
        <li>
            <a href="#">
                <i class='bx bxs-message-dots'></i>
                <span class="text">Контакты</span>
            </a>
        </li>
        <li>
            <a href="#">
                <i class='bx bxs-group'></i>
                <span class="text">О нас</span>
            </a>
        </li>
    </ul>
    <ul class="side-menu">
        <li>
            <a href="#">
                <i class='bx bxs-cog'></i>
                <span class="text">Настройки</span>
            </a>
        </li>
        <li>
            <#if user.email??>
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
        <a href="#" class="nav-link">Главная</a>
        <form action="#">
            <div class="form-input">
                <#--                <input type="search" placeholder="Search...">-->
                <#--                <button type="submit" class="search-btn"><i class='bx bx-search'></i></button>-->
            </div>
        </form>
        <input type="checkbox" id="switch-mode" hidden>
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
        <form action="/products" method="get">
            <div class="form-input">
                <input type="text" id="title" name="title" placeholder="Поиск...">
                <button type="submit" class="search-btn"><i class='bx bx-search'></i></button>
            </div>
        </form>
        <div class="filters-dropdown">
            <div class="checkbox-dropdown">
                Категория
                <ul class="checkbox-dropdown-list">
                    <#list category as category>
                    <li>
                        <label>
                            <input type="checkbox" value="Vejle" name="city"/>${category.name}</label>
                    </li>
                    </#list>
                </ul>
            </div>
            <div class="checkbox-dropdown">
                Бренд
                <ul class="checkbox-dropdown-list">
                    <li>
                        <label>
                            <input type="checkbox" value="Vejle" name="city"/>Milwaukee</label>
                    </li>
                </ul>
            </div>
            <div class="checkbox-dropdown">
                Размер
                <ul class="checkbox-dropdown-list">
                    <li>
                        <label>
                            <input type="checkbox" value="Vejle" name="city"/>Milwaukee</label>
                    </li>
                </ul>
            </div>
            <div class="checkbox-dropdown">
                Цвет
                <ul class="checkbox-dropdown-list">
                    <li>
                        <label>
                            <input type="checkbox" value="Vejle" name="city"/>Milwaukee</label>
                    </li>
                </ul>
            </div>
            <div class="checkbox-dropdown">
                Цена
                <ul class="checkbox-dropdown-list">
                    <li>
                        <label>
                            <input type="checkbox" value="Vejle" name="city"/>Milwaukee</label>
                    </li>
                </ul>
            </div>
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
                    cursor: pointer; /* добавляем курсор-указатель при наведении */
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
                .checkbox-dropdown:hover:after { /* меняем псевдокласс на hover, чтобы выпадающее меню открывалось при наведении */
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
                    top: 100%; /* align the dropdown right below the dropdown text */
                    border: inherit;
                    border-top: none;
                    left: -1px; /* align the dropdown to the left */
                    right: -1px; /* align the dropdown to the right */
                    opacity: 0; /* hide the dropdown */
                    transition: opacity 0.4s ease-in-out;
                    height: auto;
                    overflow-x: hidden;
                    pointer-events: none; /* avoid mouse click events inside the dropdown */
                    background: var(--light);
                    border-radius: 10px;
                }

                .checkbox-dropdown:hover .checkbox-dropdown-list { /* меняем псевдокласс на hover, чтобы выпадающее меню открывалось при наведении */
                    opacity: 1; /* display the dropdown */
                    pointer-events: auto; /* make sure that the user still can select checkboxes */
                }

                .checkbox-dropdown-list li label {
                    color: black;
                    display: block;
                    border-bottom: 1px solid #000000;
                    padding: 10px;
                    transition: all 0.2s ease-out;
                }

                .checkbox-dropdown-list li label:hover {
                    background-color: #618ef6;
                    color: white;
                }
                .filters-dropdown{
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
            </style>
        </div>
        </div>

        <ul class="box-popular-products">
            <#list products as product>
                <a href="/product/${product.id}">
                    <li>
                        <#if product.promotionalPrice != 0 >
                        <div class="badge">
                            <#assign discountPercentage = (product.price-product.promotionalPrice)/product.price * 100>
                            -${discountPercentage?int}%
                        </div>
                        <div class="p-c">
                            </#if>
                            <i> <img class="img-cat" src="/images/${product.previewImageId}" height="150px"/></i>
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
                                <button type="submit" class="button-delete-card">-</button>
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
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
            <div class="price">Итоговая цена:</div>
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
                <button class="checkout">Оформить заказ</button>
                <br>

            </div>
            <!-- Product #1 -->
        </div>
    </div>

    <#--        <div class="bottom-panel">-->
    <#--            <div id="price">The price of the whole basket: <span id="total"> ${.vars['totalPrice']} р.</span>-->
    <#--                <span class="divider"></span>-->

    <#--        </div>-->


    <div class="button-wrap">
        <label class="button-1" for="checkbox">
            <div class="btn open"><img src="https://i.ibb.co/brq1tJj/shopping-cart.png" height="27px" alt=""/></div>
        </label></div>
    <script>
        $(".checkbox-dropdown").click(function () {
            $(this).toggleClass("is-active");
        });

        $(".checkbox-dropdown ul").click(function (e) {
            e.stopPropagation();
        });
    </script>
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

    searchButton.addEventListener('click', function (e) {
        if (window.innerWidth < 576) {
            e.preventDefault();
            searchForm.classList.toggle('show');
            if (searchForm.classList.contains('show')) {
                searchButtonIcon.classList.replace('bx-search', 'bx-x');
            } else {
                searchButtonIcon.classList.replace('bx-x', 'bx-search');
            }
        }
    })


    if (window.innerWidth < 768) {
        sidebar.classList.add('hide');
    } else if (window.innerWidth > 576) {
        searchButtonIcon.classList.replace('bx-x', 'bx-search');
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
</script>

</body>
</html>