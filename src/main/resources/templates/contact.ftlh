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

    <link rel="stylesheet" href="../static/css/contact.css">


    <title>Главная</title>
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
        <li class="active">
            <a href="/contact">
                <i class='bx bxs-message-dots'></i>
                <span class="text">Контакты</span>
            </a>
        </li>
        <li>
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
        <a href="#" class="nav-link">Главная</a>
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
        <div class="container">
            <!-- content содержит содержимое формы -->
            <div class="content">
                <!-- Левая колонка: адрес, телефоны, email. Можете добавить свое -->
                <div class="left-side">
                    <div class="address details">
                        <!-- Вместо классов: название шрифтовых иконок (fontawesome.com) -->
                        <i class="fas fa-map-marker-alt"></i>

                        <!-- topic - заголовок, text-one, text-two - текст -->
                        <div class="topic">Адрес</div>
                        <div class="text-one">г. Гомель/div></div>
                        <div class="text-two">Крестьянская 22</div>
                    </div>
                    <div class="phone details">
                        <i class="fas fa-phone-alt"></i>
                        <div class="topic">Телефон</div>
                        <div class="text-one">+375-33-860-83-13</div>
                        <div class="text-two">+375-33-860-83-13</div>
                    </div>
                    <div class="email details">
                        <i class="fas fa-envelope"></i>
                        <div class="topic">Email</div>
                        <div class="text-one">bellsellby@gmail.com</div>
                        <div class="text-two">bellsellby@gmail.com<</div>
                    </div>
                </div>

                <!-- Правая колонка: сама форма -->
                <div class="right-side">

                    <!-- Заголовок для формы -->
                    <div class="topic-text">Отправьте нам сообщение</div>

                    <!-- Какой-то дополнительный текст -->
                    <p>
                        Если у вас есть какие-то вопросы или предложения по сотрудничеству -
                        заполните форму ниже
                    </p>

                    <!-- Форма обратной связи -->
                    <form action="/contact/message/${user.id}" method="post">
                        <!-- Каждый input для выравнивания вкладываем в блок input-box -->
                        <div class="input-box">
                            <input type="text" name="name" placeholder="Ваше имя" />
                        </div>
                        <div class="input-box message-box">
                            <textarea placeholder="Сообщение" name="message"></textarea>
                        </div>
                        <div class="button">
                            <input type="hidden" value="${_csrf.token}" name="_csrf">

                            <input type="submit" value="Отправить" />
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Подключение шрифтовых иконок, можно получить на fontawesome.com -->
        <script
                src="https://kit.fontawesome.com/fce9a50d02.js"
                crossorigin="anonymous"
        ></script>
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