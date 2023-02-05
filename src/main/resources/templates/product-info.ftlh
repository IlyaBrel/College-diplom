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
    <link rel="stylesheet" href="../static/css/product-info-css.css">
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

<#--<#list images as img>-->
<#--    <img src="/images/${img.id}" height="60px"/><br><br>-->
<#--</#list>-->
<#--<b>Название товара: </b>${product.title}<br>-->
<#--<b>Описание товара: </b>${product.description}<br>-->
<#--<b>Цена: </b>${product.price}<br>-->
<#--<b>Город: </b>${product.city}<br>-->
<#--<b>Автор: </b><a href="/user/${product.user.id}">${product.user.name}</a><br>-->
<!-- CONTENT -->
<section id="content">
    <!-- NAVBAR -->
    <nav>
        <i class='bx bx-menu'></i>
        <a href="#" class="nav-link">Категории</a>
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
        <div class="container">
            <div class="single-product">
                <div class="row">
                    <div class="col-6">
                        <div class="product-image">
                            <div class="product-image-main">
                                <img src="/images/${product.previewImageId}" alt="" id="product-main-image">
                            </div>

                            <div class="product-image-slider">
                                <#list images as img>
                                    <img src="/images/${img.id}" alt="" class="image-list">
                                </#list>
                            </div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="breadcrumb">
                            <span><a href="/">Home</a></span>
                            <span><a href="#">Product</a></span>
                            <span class="active">${product.title}</span>
                        </div>

                        <div class="product">
                            <div class="product-title">
                                <h2>${product.title}</h2>
                            </div>
                            <div class="product-rating">
                                <span><i class="bx bxs-star"></i></span>
                                <span><i class="bx bxs-star"></i></span>
                                <span><i class="bx bxs-star"></i></span>
                                <span><i class="bx bxs-star"></i></span>
                                <span><i class="bx bxs-star"></i></span>
                                <span class="review">(47 Review)</span>
                            </div>
                            <div class="product-price">
                                <span class="offer-price">${product.price} р.</span>
<#--                                <span class="sale-price">$129.00</span>-->
                            </div>

                            <div class="product-details">
                                <h3>Description</h3>
                                <p>${product.description}</p>
                            </div>

                            <div class="product-size">
                                <h4>Size</h4>
                                 <#list .vars['product-size'] as size>
                                <div class="size-layout">
                                    <input type="radio" name="size" value="${size}" id="${size_index}" class="size-input">
                                    <label for="${size_index}" class="size">${size}</label>

<#--                                    <input type="radio" name="size" value="M" id="2" class="size-input">-->
<#--                                    <label for="2" class="size">M</label>-->

<#--                                    <input type="radio" name="size" value="L" id="3" class="size-input">-->
<#--                                    <label for="3" class="size">L</label>-->

<#--                                    <input type="radio" name="size" value="XL" id="4" class="size-input">-->
<#--                                    <label for="4" class="size">XL</label>-->

<#--                                    <input type="radio" name="size" value="XXL" id="5" class="size-input">-->
<#--                                    <label for="5" class="size">XXL</label>-->
                                </div>
                                </#list>
                            </div>
                            <div class="product-color">
                                <h4>Color</h4>
                                <div class="color-layout">
                                    <input type="radio" name="color" value="black" class="color-input">
                                    <label for="black" class="black"></label>
                                    <input type="radio" name="color" value="red" class="color-input">
                                    <label for="red" class="red"></label>

                                    <input type="radio" name="color" value="blue" class="color-input">
                                    <label for="blue" class="blue"></label>
                                </div>
                            </div>
                            <span class="divider"></span>

                            <div class="product-btn-group">
                                <div class="button buy-now"><i class='bx bxs-zap'></i> Купить сейчас</div>
                                <div class="button add-cart"><i class='bx bxs-cart'></i> В корзину</div>
                                <div class="button heart"><i class='bx bxs-heart'></i> Нравится</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--script-->
        <script>
            const sliderMainImage = document.getElementById("product-main-image"); //product container image
            const sliderImageList = document.getElementsByClassName("image-list"); // image thumblian group selection
            console.log(sliderImageList);

            sliderImageList[0].onclick = function () {
                sliderMainImage.src = sliderImageList[0].src;
                console.log(sliderMainImage.src);
            };

            sliderImageList[1].onclick = function () {
                sliderMainImage.src = sliderImageList[1].src;
                console.log(sliderMainImage.src);
            };

            sliderImageList[2].onclick = function () {
                sliderMainImage.src = sliderImageList[2].src;
                console.log(sliderMainImage.src);
            };

            sliderImageList[3].onclick = function () {
                sliderMainImage.src = sliderImageList[3].src;
                console.log(sliderMainImage.src);
            };
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
<#--<html>-->
<#--<head>-->
<#--    <title>BUYSELL</title>-->
<#--</head>-->
<#--<body>-->
<#--<h1>BUYSELL</h1><hr>-->
<#--<h4>Подробная информация о товаре</h4>-->
<#--<#list images as img>-->
<#--    <img src="/images/${img.id}" height="60px"/><br><br>-->
<#--</#list>-->
<#--<b>Название товара: </b>${product.title}<br>-->
<#--<b>Описание товара: </b>${product.description}<br>-->
<#--<b>Цена: </b>${product.price}<br>-->
<#--<b>Город: </b>${product.city}<br>-->
<#--<b>Автор: </b><a href="/user/${product.user.id}">${product.user.name}</a><br>-->
<#--</body>-->
<#--</html>-->