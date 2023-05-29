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
        <div style="display: flex">
            <div>
                <div class="an-pop-pr" style="text-align: center">
                    <h2>Популярные товары</h2>
                </div>

                <table>
                    <thead>
                    <tr>
                        <th scope="col">Покупаемый товар</th>
                        <th scope="col">Количество покупок</th>
                        <th scope="col">Покупаемый размер</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list mostPopularProducts as popProduct>
                        <tr>
                            <td data-label="Покупаемый товар"><a
                                        href="/product/${popProduct.productId}">${productService.getProductById(popProduct.productId).title}</a>
                            </td>
                            <td data-label="Количество покупок">${popProduct.purchaseCount}</td>
                            <td data-label="Покупаемый размер">${popProduct.size}</td>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>

            <div>
                <div class="an-pop-pr" style="text-align: center">
                    <h2>Популярные размеры продуктов</h2>
                </div>

                <table>
                    <thead>
                    <tr>
                        <th scope="col">Название продукта</th>
                        <th scope="col">Размер</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list popularProductSizes as productId, size>
                        <tr>
                            <td data-label="Название продукта"><a
                                        href="/product/${productId}">${productService.getProductById(productId).title}</a>
                            </td>
                            </td>
                            <td data-label="Размер">
                                <#list size as sizes>
                                    ${sizes} ;
                                </#list>
                            </td>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        </div>

        <ul class="box-category" style="grid-template-columns: repeat(auto-fit, minmax(76px, 1fr));">
            <li>
                <span class="text">Общий доход:</span>
                <span><h3>${totalRevenue}р.</h3></span>
            </li>
            <li>
                <span class="text">Средняя стоимость заказа:</span>
                <span><h3>${averageOrderValue}р.</h3></span>
            </li>
            <li>
                <span class="text">Общее количество заказов:</span>
                <span><h3> ${totalNumberOfOrders}</h3></span>
            </li>
            <li>
                <span class="text">Общее количество пользователей:</span>
                <span><h3>${totalNumberOfUsers}</h3></span>
            </li>
            <li>
                <span class="text">Средний заказ на пользователя:</span>
                <span><h3>${averageOrderPerUser}</h3></span>
            </li>
        </ul>

        <div style="display:flex; margin: 30px">
            <div style="text-align: center; margin: 10px">
                <h2>Статусы и количество заказов по статусу</h2>
                <table>
                    <thead>
                    <tr>
                        <th scope="col">Статус</th>
                        <th scope="col">Количество</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list orderStatusBreakdown?keys as status>
                        <tr>
                            <td data-label="Статус">${status}</td>
                            <td data-label="Количество">${orderStatusBreakdown[status]}</td>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
            <div style="text-align: center; margin: 10px">
                <h2>Распределение стоимости заказа</h2>
                <table>
                    <thead>
                    <tr>
                        <th scope="col">Диапазон</th>
                        <th scope="col">Количество</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list orderValueDistribution?keys as range>
                        <tr>
                            <td data-label="Диапазон">${range}</td>
                            <td data-label="Количество">${orderValueDistribution[range]}</td>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        </div>
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
