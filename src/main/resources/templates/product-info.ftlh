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

    <title>${product.title}</title>
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
    <style>
        body {
            color: var(--dark);
        }
    </style>
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
                                <#if product.promotionalPrice != 0 >
                                    <div class="badge">
                                        <#assign discountPercentage = (product.price-product.promotionalPrice)/product.price * 100>
                                        -${discountPercentage?int}%
                                    </div>
                                </#if>
                                <div class="product-image-slider">
                                    <#list images as img>
                                        <img src="/images/${img.id}" alt="" class="image-list">
                                    </#list>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="breadcrumb">
                                <span><a href="/">Главная</a></span>
                                <span><a href="/products">Товары</a></span>
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
                                    <span class="review">(Оценка магазина)</span>
                                </div>
                                <div class="product-price">
                                    <#if product.promotionalPrice != 0 >
                                        <span class="offer-price">${product.promotionalPrice} р.</span>
                                        <span class="sale-price">${product.price} р.</span>
                                    <#else>
                                        <span class="offer-price">${product.price} р.</span>
                                    </#if>
                                </div>

                                <div class="product-details">
                                    <h3>Описание</h3>
                                    <p>${product.description}</p>
                                </div>

                                <div class="product-size">
                                    <h4>Размеры</h4>
                                    <#list product.dimensions?keys as size>
                                        <#if product.dimensions[size] != 0>
                                            <div class="size-layout">
                                                <input type="radio" name="size" value="${size}" id="${size_index}"
                                                       class="size-input">
                                                <label for="${size_index}" class="size">${size}</label>
                                            </div>
                                        </#if>
                                    </#list>
                                </div>
                                <div class="product-color">
                                    <h4>Цвет</h4>
                                    <div class="color-layout">
                                        <input type="radio" name="color" style="background: ${product.color.style}"
                                               class="color-input">
                                        <label for="black" style="background: ${product.color.style}"
                                               class="black"></label>
                                    </div>
                                </div>
                                <span class="divider"></span>

                                <div class="product-btn-group">
                                    <form action="/cart/buy/${product.id}" method="post" enctype="multipart/form-data">
                                        <button type="submit" onclick="checkSizeSelection(event)">
                                            <input type="hidden" name="selectedSize" id="selectedSize" value="">
                                            <div class="button buy-now" type="submit"><i class='bx bxs-zap'>
                                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                                </i> Купить сейчас
                                            </div>
                                        </button>
                                    </form>

                                    <form action="/cart/add/${product.id}" method="post" enctype="multipart/form-data">
                                        <button type="submit" onclick="checkSizeSelection(event)">
                                            <input type="hidden" name="selectedSizeCart" id="selectedSizeCart" value="">
                                            <div class="button add-cart" type="submit"><i class='bx bxs-cart'>
                                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                                </i> В корзину
                                            </div>
                                        </button>
                                    </form>
                                </div>

                                <script>
                                    function checkSizeSelection(event) {
                                        var selectedSize = document.querySelector('input[name="size"]:checked');
                                        if (!selectedSize) {
                                            event.preventDefault(); // Предотвращаем отправку формы
                                            alert("Пожалуйста, выберите размер!"); // Отображаем сообщение
                                        } else {
                                            // Если размер выбран, можно продолжать с отправкой формы
                                            // или выполнить другие действия по вашему выбору
                                        }
                                    }
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var sizeInputs = document.getElementsByName('size'); // Получаем все элементы input с именем 'size'
                    for (var i = 0; i < sizeInputs.length; i++) {
                        sizeInputs[i].addEventListener('change', function () { // Добавляем обработчик события change
                            var selectedSize = this.value; // Получаем выбранный размер
                            document.getElementById('selectedSize').value = selectedSize; // Устанавливаем значение в скрытое поле формы
                        });
                    }
                });
            </script>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var sizeInputs = document.getElementsByName('size'); // Получаем все элементы input с именем 'size'
                    for (var i = 0; i < sizeInputs.length; i++) {
                        sizeInputs[i].addEventListener('change', function () { // Добавляем обработчик события change
                            var selectedSizeCart = this.value; // Получаем выбранный размер
                            document.getElementById('selectedSizeCart').value = selectedSizeCart; // Устанавливаем значение в скрытое поле формы
                        });
                    }
                });
            </script>
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
                <div class="btn open"><img src="https://i.ibb.co/brq1tJj/shopping-cart.png" height="27px" alt=""/></div>
            </label>
        </div>
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
