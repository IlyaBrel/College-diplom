<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html"
      xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Boxicons -->
    <link rel="stylesheet" type="text/css"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <!-- My CSS -->
    <link rel="stylesheet" href="../static/css/user-profil.css">

    <title>Главная</title>
</head>
<body>
<!-- SIDEBAR -->
<#if user.email??>
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
            <!-- NAVBAR -->

            <!-- MAIN -->
            <main>
                <section class="py-5 my-5">
                    <div class="container">
                        <h1 class="mb-5">Мой аккаунт</h1>
                        <div class="bg-white shadow rounded-lg d-block d-sm-flex">
                            <div class="profile-tab-nav border-right">
                                <div class="p-4">
                                    <div class="img-circle text-center mb-3">
                                        <img src="https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector-No-Background.png"
                                             alt="Image" class="shadow">
                                    </div>
                                    <h4 class="text-center">${user.name}</h4>
                                </div>
                                <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist"
                                     aria-orientation="vertical">
                                    <a class="nav-link active" id="account-tab" data-toggle="pill" href="#account"
                                       role="tab"
                                       aria-controls="account" aria-selected="true">
                                        <i class="fa fa-home text-center mr-1"></i>
                                        Аккаунт
                                    </a>
                                    <a class="nav-link" id="password-tab" data-toggle="pill" href="#password" role="tab"
                                       aria-controls="password" aria-selected="false">
                                        <i class="fa fa-key text-center mr-1"></i>
                                        Пароль
                                    </a>
                                    <a class="nav-link" id="security-tab" data-toggle="pill" href="#security" role="tab"
                                       aria-controls="security" aria-selected="false">
                                        <i class="fa fa-user text-center mr-1"></i>
                                        Мои заказы
                                    </a>
                                    <a class="nav-link" id="tgbot-tab" data-toggle="pill" href="#tgbot" role="tab"
                                       aria-controls="tgbot" aria-selected="false">
                                        <i class="fa fa-tgbot text-center mr-1"></i>
                                        Телеграмм бот
                                    </a>
                                </div>
                            </div>
                            <div class="tab-content p-4 p-md-5" id="v-pills-tabContent">
                                <div class="tab-pane fade show active" id="account" role="tabpanel"
                                     aria-labelledby="account-tab">
                                    <h3 class="mb-4">Настройки аккаунта</h3>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Имя</label>
                                                <input type="text" class="form-control" value="${user.name}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Номер телефона</label>
                                                <input type="text" class="form-control" value="${user.phoneNumber}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Email</label>
                                                <input type="text" class="form-control" value="${user.email}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                        </div>
                                        <div class="col-md-6">
                                            <form id="myform" action="/telegram/user/${user.id}" method="post">
                                                <h3 class="mb-4">Телеграмм бот</h3>
                                                <div class="form-group">
                                                    <label>Код</label>
                                                    <input type="text" class="code" name="code">
                                                    <div>
                                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                                        <button class="btn btn-primary" type="submit">Соеденить</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>

                                <div class="tab-pane fade" id="password" role="tabpanel" aria-labelledby="password-tab">
                                    <form id="myform" action="/user/updatePassword/${user.id}" method="post">
                                        <h3 class="mb-4">Настройки пароля</h3>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Старый пароль</label>
                                                    <input type="password" name="oldPassword" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Новый пароль</label>
                                                    <input type="password" name="newPassword" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Подтвеждение пароля</label>
                                                    <input type="password" name="twoOldPassword" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                        <div>
                                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                                            <button class="btn btn-primary" type="submit">Обновить</button>
                                        </div>
                                        <#if successMessage??>
                                            <div class="success-message">Пароль успешно обновлен</div>
                                        </#if>

                                        <#if errorMessage??>
                                            <div class="error-message">Ошибка при обновлении пароля</div>
                                        </#if>
                                    </form>
                                </div>
                                <div class="tab-pane fade" id="security" role="tabpanel" aria-labelledby="security-tab">
                                    <h3 class="mb-4">Мои заказы</h3>
                                    <div class="row">
                                        <#list orders as order>
                                        <h4>Заказ номер #${order_index+1}</h4>
                                        <br>
                                        <div class="col-md-6">

                                        </div>
                                        <div class="col-md-6">
                                            Статус: <h3 style="color:#ff0000;">${order.status}</h3>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Имя</label>
                                                <input type="text" class="form-control"
                                                       value="${order.postalData.name}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Фамилия</label>
                                                <input type="text" class="form-control"
                                                       value="${order.postalData.lastName}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Отчество</label>
                                                <input type="text" class="form-control"
                                                       value="${order.postalData.surname}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Номер телефона</label>
                                                <input type="text" class="form-control"
                                                       value="${order.postalData.phoneNumber}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Индекс</label>
                                                <input type="text" class="form-control"
                                                       value="${order.postalData.postalIndex}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Адресс</label>
                                                <input style="margin: 10px" type="text" class="form-control"
                                                       value="Город: ${order.postalData.city}">
                                                <input style="margin: 10px" type="text" class="form-control"
                                                       value="Улица: ${order.postalData.street}">
                                                <input style="margin: 10px" type="text" class="form-control"
                                                       value="Номер дома: ${order.postalData.houseNumber}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Итоговая цена в р.:</label>
                                                <input type="text" class="form-control"
                                                       value="${order.totalPrice} р.">
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Товары:</label>
                                                <div class="panel">
                                                    <div class="start">
                                                        <div class="shopping-cart" bis_skin_checked="1">
                                                            <#list order.productsIdAndSize as productId,size>
                                                                <div class="item">
                                                                    <div class="image">
                                                                        <img class="image-p"
                                                                             src="/images/${productService.getProductById(productId).previewImageId}"
                                                                             alt="">
                                                                    </div>
                                                                    <div class="description">
                                                                        <span>${productService.getProductById(productId).category.name}</span>
                                                                        <span>${productService.getProductById(productId).title}</span>
                                                                        <span>Размер: ${size}</span>
                                                                    </div>
                                                                </div>
                                                            </#list>
                                                        </div>
                                                    </div>
                                                </div>
                                                </#list>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                </section>
                <#if successMessage??>
                    <div class="popupr">
                        <div class="headr">
                            <div class="iconr">
                                <div class="boxr">
                                    <i class='bx bx-x-circle bx-tada bx-rotate-270'></i>
                                </div>
                            </div>
                        </div>
                        <div class="bodyr">
                            <div><h1>Готово!</h1></div>
                            <div><p>${successMessage}</p></div>
                            <div style="display: flex;justify-content: center;margin: -13px;">
                                <a href="/products">
                                    <div class="close-btnr"> Вернуться в магазин</div>
                                </a></div>
                        </div>
                    </div>
                </#if>
                <#if errorMessage??>
                    <div class="popupr">
                        <div class="headr" style="background: red">
                            <div class="iconr">
                                <div class="boxr" style="color: red">
                                    <i class='bx bx-x-circle bx-tada bx-rotate-270'></i>
                                </div>
                            </div>
                        </div>
                        <div class="bodyr">
                            <div><h1>Ошибка!</h1></div>
                            <div><p>${errorMessage}</p></div>
                            <div style="display: flex;justify-content: center;margin: -13px;">
                                <a href="/products">
                                    <div class="close-btnrs" style="border-color: red"> Вернуться в магазин</div>
                                </a></div>
                        </div>
                    </div>
                </#if>

                <#if messageTg??>
                    <div class="popupr">
                        <div class="headr">
                            <div class="iconr">
                                <div class="boxr">
                                    <i class='bx bx-x-circle bx-tada bx-rotate-270'></i>
                                </div>
                            </div>
                        </div>
                        <div class="bodyr">
                            <div><h1>Готово!</h1></div>
                            <div><p>${messageTg}</p></div>
                            <div style="display: flex;justify-content: center;margin: -13px;">
                                <a href="/products">
                                    <div class="close-btnr"> Вернуться в магазин</div>
                                </a></div>
                        </div>
                    </div>
                </#if>
                <#if errorMessageTg??>
                    <div class="popupr">
                        <div class="headr" style="background: red">
                            <div class="iconr">
                                <div class="boxr" style="color: red">
                                    <i class='bx bx-x-circle bx-tada bx-rotate-270'></i>
                                </div>
                            </div>
                        </div>
                        <div class="bodyr">
                            <div><h1>Ошибка!</h1></div>
                            <div><p>${errorMessageTg}</p></div>
                            <div style="display: flex;justify-content: center;margin: -13px;">
                                <a href="/products">
                                    <div class="close-btnrs" style="border-color: red"> Вернуться в магазин</div>
                                </a></div>
                        </div>
                    </div>
                </#if>
            </main>
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
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </#if>
</#if>
</body>
</html>