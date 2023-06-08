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
    <link rel="stylesheet" href="../static/css/admin.css">

    <title>Панель администратора(Пользователи)</title>
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
            <a href="/admin">
                <i class='bx bxs-dashboard'></i>
                <span class="text">Пользователи</span>
            </a>
        </li>
        <li>
            <a href="/admin/products">
                <i class='bx bxs-shopping-bag-alt'></i>
                <span class="text">Товары</span>
            </a>
        </li>
        <li>
            <a href="/admin/categorys">
                <i class='bx bxs-doughnut-chart'></i>
                <span class="text">Категории</span>
            </a>
        </li>
        <li>
            <a href="/admin/orders">
                <i class='bx bxs-message-dots'></i>
                <span class="text">Заказы</span>
            </a>
        </li>
        <li>
            <a href="/admin/news">
                <i class='bx bxs-group'></i>
                <span class="text">Новости</span>
            </a>
        </li>
        <li>
            <a href="/admin/analytics">
                <i class='bx bxs-group'></i>
                <span class="text">Аналитика</span>
            </a>
        </li>
    </ul>
    <ul class="side-menu">
        <li>
            <a href="/">
                <i class='bx bxs-cog'></i>
                <span class="text">На главную</span>
            </a>
        </li>
    </ul>
</section>

<section id="content">
    <!-- NAVBAR -->
    <nav>
        <i class='bx bx-menu'></i>
        <a href="#" class="nav-link">Админ</a>

        <input type="checkbox" id="switch-mode" style="visibility: hidden">
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
        <div style="
        display: flex;
        justify-content: center;
        background: white;
        text-align: center;">
            <div><h3>Создать рассылку</h3>
                <form action="/admin/tg/messages" method="post">
                    <input class="inp" placeholder="Введите текс" name="messageText">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <button class="msgB" type="submit">Отправить</button>
                </form>
                <style>
                    .msgB {
                        font-family: 'Montserrat', sans-serif;
                        border-radius: 10px;
                        position: relative;
                        padding: 10px;
                        z-index: 9994;
                        background: var(--blue);
                        color: var(--dark);
                        margin: 10px;
                        user-select: none;
                        cursor: pointer;
                    }
                </style>
            </div>
        </div>
        <table border="1">
            <tr>
                <th>Email</th>
                <th>Номер телефона</th>
                <th>Активность</th>
                <th>Роли</th>
                <th>Бан</th>
                <th>Редактирование</th>
                <th>Подробная информация</th>
            </tr>
            <#list users as user>
                <tr>
                    <th>${user.email}</th>
                    <th>${user.phoneNumber}</th>
                    <th><#if user.active>true<#else>false</#if></th>
                    <th><#list user.roles as role>${role}</#list></th>
                    <th>
                        <form action="/admin/user/ban/${user.id}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input type="submit" value="Бан">
                        </form>
                    </th>
                    <th><a href="/user/edit/${user.id}">Редактировние</a></th>
                    <th><a href="/user/${user.id}">Подробная информация</a></th>
                </tr>
            <#else>
                <h3>Пользователей нет</h3>
            </#list>
        </table>
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
