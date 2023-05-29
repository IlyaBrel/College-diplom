<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html"
      xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Boxicons -->

    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <link href='https://netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css' rel="stylesheet">
    <!-- My CSS -->

    <link rel="stylesheet" href="../static/css/faq.css">
    <title>О нас</title>
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
        <li class="active">
            <a href="/faq">
                <i class='bx bxs-cog'></i>
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
        <a href="#" class="nav-link">О нас</a>
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

    <main>
        <h1>О нас</h1>

        <div class="faqs-container">
            <div class="faq active">
                <h3 class="faq-title">
                    Где мы находимся?
                </h3>
                <p class="faq-text">
                   Гланый офис находится в городе Гомель, по адресу ул.Крестьянская, дом 14.
                </p>
                <button class="faq-toggle">
                    <i class='bx bx-chevrons-down'></i>
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <div class="faq">
                <h3 class="faq-title">
                    Как работает "Оформление заказа"?
                </h3>
                <p class="faq-text">
                    После того как вы добавили товар(-ы) в корзину,
                    в окне корзины есть кнопка "К оформлению заказ",
                    по её нажатию вы перейдёте на страницу оформления заказа,
                    заполнив все поля и нажав кнопку "Оформить заказ" заказ попадёт в обработку и
                    вам на почту которую вы указали при регистрации вам придёт уведомление.
                </p>
                <button class="faq-toggle">
                    <i class='bx bx-chevrons-down'></i>
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <div class="faq">
                <h3 class="faq-title">
                    Какие бренды товаров вы продаете?
                </h3>
                <p class="faq-text">
                    Мы предлагаем широкий ассортимент товаров от различных популярных брендов,
                    таких как Nike, Adidas, Puma, Reebok, New Balance и многие другие.
                    Вы можете найти полный список брендов на нашем веб-сайте или посетить наши магазины для более подробной информации.
                </p>
                <button class="faq-toggle">
                    <i class='bx bx-chevrons-down'></i>
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <div class="faq">
                <h3 class="faq-title">
                    Есть ли у вас система возврата или обмена товаров?
                </h3>
                <p class="faq-text">
                    Да, мы предоставляем возможность
                    возврата или обмена товаров в течение определенного периода времени после покупки,
                    с учетом условий и ограничений.
                    Для получения подробной информации ознакомьтесь
                    с нашей политикой возврата и обмена на веб-сайте или обратитесь к нашей службе поддержки клиентов.
                </p>
                <button class="faq-toggle">
                    <i class='bx bx-chevrons-down'></i>
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <div class="faq">
                <h3 class="faq-title">
                    Каковы ваши условия доставки?
                </h3>
                <p class="faq-text">
                    Мы предлагаем доставку по всей стране.
                    Доставка производится почтой.
                    Мы также предлагаем услуги международной доставки для наших зарубежных клиентов.
                </p>
                <button class="faq-toggle">
                    <i class='bx bx-chevrons-down'></i>
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </div>
        <style>
            i{
                color: black;
            }
        </style>
    </main>
</section>
<!-- CONTENT -->

<script>
    const toggles = document.querySelectorAll('.faq-toggle');

    toggles.forEach(toggle => {
        toggle.addEventListener('click', () => {
            toggle.parentNode.classList.toggle('active');
        });
    });

    // SOCIAL PANEL JS
    const floating_btn = document.querySelector('.floating-btn');
    const close_btn = document.querySelector('.close-btn');
    const social_panel_container = document.querySelector('.social-panel-container');

    floating_btn.addEventListener('click', () => {
        social_panel_container.classList.toggle('visible')
    });

    close_btn.addEventListener('click', () => {
        social_panel_container.classList.remove('visible')
    });
</script>
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