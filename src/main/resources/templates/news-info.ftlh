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

    <title>${news.title}</title>
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
        <a href="#" class="nav-link">Новость</a>
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
        <div class="news">
            <div class="news-block">
                <h2 class="procet-text">
                    ${news.title}
                </h2>
                <span class="under-title-text">${news.underTitleText}</span>
            </div>
            <div style="background: var(--blue)" class="image-container-news">
                <img src="/images/${news.previewImageId}" alt="Snow" style="width:100%;">
            </div>
        </div>
        <div style="font-size: 22px;
    padding: 0 300px 0 300px;
    text-align: center;">
            ${news.description}
        </div>
        <ul class="box-popular-products">
            <#list news.productsId as product>
                <#if productService.getProductById(product).popular>
            <a href="/product/${productService.getProductById(product).id}">
                <li>
                    <#if productService.getProductById(product).promotionalPrice != 0 >
                    <div class="badge">
                        <#assign discountPercentage = (productService.getProductById(product).price-productService.getProductById(product).promotionalPrice)/productService.getProductById(product).price * 100>
                        -${discountPercentage?int}%
                    </div>
                    <div class="p-c">
                        </#if>
                        <i> <img class="img-cat"
                                 src="/images/${productService.getProductById(product).previewImageId}"
                                 height="150px"/></i>
                        <span class="text-pr">
						<h3>${productService.getProductById(product).title} </p></h3>
                        <p>${productService.getProductById(product).description}</p>
                            <div class="product-price">
                            <#if productService.getProductById(product).promotionalPrice != 0 >
                                <span class="offer-price">${productService.getProductById(product).promotionalPrice} р.</span>
                                <span class="sale-price">${productService.getProductById(product).price} р.</span>
                                <#else>
                                <span class="offer-price">${productService.getProductById(product).price} р.</span>
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
</#if>
</body>
</html>
