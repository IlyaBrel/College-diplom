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
        <li class="active">
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
            <a href="#">
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
        <div class="filters">

            <div class="dropdown">
                <button class="filter-button">Фильтры</button>
                <div class="dropdown-content">
                    <form class="form-filter">
                        <div>
                            <h3>По категориям</h3>
                            <#list category as category_filter>
                                <div>
                                    <label class="lable-f-c"><input id="category" type="checkbox" name="category"
                                                                    value="${category_filter.id}">${category_filter.name}
                                    </label>
                                    <style>
                                        .lable-f-c {
                                            margin: 20px;
                                        }

                                        #category {
                                            margin-right: 10px;
                                        }
                                    </style>
                                </div>
                            </#list>
                        </div>
                        <div>
                            <label for="filter2"><input type="checkbox" id="filter2">Filter 2</label>
                        </div>
                        <div>
                            <label for="filter3"><input type="checkbox" id="filter3">Filter 3</label>
                        </div>
                    </form>
                    <button class="save-btn">Save HTML</button>
                </div>
            </div>
            <form action="/products" method="get">
                <div class="form-input">
                    <input type="text" id="title" name="title" placeholder="Поиск...">
                    <button type="submit" class="search-btn"><i class='bx bx-search'></i></button>
                </div>
            </form>
        </div>

        <ul class="box-popular-products">

            <#--            <label for="title">Title:</label>-->
            <#--            <input type="text" id="title" name="title">-->
            <#--            <br>-->
            <#--            <label for="city">City:</label>-->
            <#--            <input type="text" id="city" name="city">-->
            <#--            <br>-->
            <#--            <label for="category">Category:</label>-->
            <#--            <select id="category" name="category">-->
            <#--                <option value="">All</option>-->
            <#--                <#list category as category>-->
            <#--                    <option value="${category.id}">${category.name}</option>-->
            <#--                </#list>-->
            <#--            </select>-->
            <#--            <br>-->


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
                            <span>42</span>
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

    </div>
    <#--        <div class="bottom-panel">-->
    <#--            <div id="price">The price of the whole basket: <span id="total"> ${.vars['totalPrice']} р.</span>-->
    <#--                <span class="divider"></span>-->

    <#--        </div>-->


    <div class="button-wrap">
        <label class="button-1" for="checkbox">
            <div class="btn open"><img src="https://i.ibb.co/brq1tJj/shopping-cart.png" height="27px" alt=""/></div>
        </label></div>

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