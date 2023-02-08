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
    <link rel="stylesheet" href="../static/css/homep.css">

    <title>AdminHub</title>
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
            <a href="#">
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
                <input type="search" placeholder="Search...">
                <button type="submit" class="search-btn"><i class='bx bx-search'></i></button>
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


        <div class="slider-container">
            <div class="slider">
                <div class="slide">
                    <div class="text-container">
                        <h3>Новость 1</h3>
                        <p>Внутренний текст</p>
                        <button class="more-btn">Подробнее...</button>
                    </div>
                    <div class="img-container">
                        <img class="img-sl" src="/images/29" alt="Image 2">
                    </div>
                </div>
                <div class="slide">
                    <div class="text-container">
                        <h3>Новость 2</h3>
                        <p>Внутренний текст</p>
                        <button class="more-btn">Подробнее...</button>
                    </div>
                    <div class="img-container">
                        <img class="img-sl" src="/images/29" alt="Image 2">
                    </div>
                </div>
                <div class="slide">
                    <div class="text-container">
                        <h3>Новость 3</h3>
                        <p>Внутренний текст</p>
                        <button class="more-btn">Подробнее...</button>
                    </div>
                    <div class="img-container">
                        <img class="img-sl" src="/images/29" alt="Image 2">
                    </div>
                </div>
            </div>
        </div>


        </div>
        <ul class="box-category">
            <#list categorys as category>
                <#if category_index < 6>
                    <li>
                        <img class="img-cat" src="/images/${category.previewImageId}" height="50px"/>
                        <span class="text">
						<h3>${category.name}</h3>
					</span>
                    </li>
                </#if>

            </#list>
        </ul>

        <div class="head-title">
            <div class="left">
                <h1>Популярные товары</h1>
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
                                </div>
                    <form action="/cart/${product.id}" method="post" enctype="multipart/form-data">
                        <button type="submit" class="btn-add-b">
                         <i>
                        <img type="submit" src="/images/33" height="27px" alt=""/>
                        <h4>В корзину</h4></i>
                             <input type="hidden" name="_csrf" value="${_csrf.token}">

                         </button>
                    </form>
<#--                        <input type="submit" value="Добавить в корзину"/>&ndash;&gt;-->
                        </div>

                        <#--                        <h4 class="pr-price">${product.price}.00 р-->
                        </h4>
                        </span>
                        </div>
                    </li>
                </a>
            </#list>
        </ul>
    </main>
    <table>
        <thead>
        <tr>
            <th>Product Name</th>
            <th>Price</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <#list cart as product>
            <tr>
                <td>${product.title}</td>
                <td>${product.price}</td>
                <td>
                    <form action="/cart/remove/${product_index}" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"><input type="submit"
                                                                                        value="Удалить из в корзину"/>
                    </form>
                </td>
            </tr>
        </#list>
        </tbody>
    </table>


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