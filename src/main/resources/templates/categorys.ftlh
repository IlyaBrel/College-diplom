<#--<!DOCTYPE html>-->
<#--<html>-->
<#--<head>-->
<#--    <link rel="stylesheet" href="../static/css/style.css">-->
<#--    <title>Чемпионат </title>-->
<#--</head>-->
<#--<body>-->
<#--<div>-->

<#--    <#list category as category>-->

<#--            <div>-->
<#--                <p><b>${category.name}</b>|<a href="/category/${category.id}">Подробнее...</a></p>-->
<#--            </div-->

<#--    </#list>-->

<#--&lt;#&ndash;    <form action="/category/create" method="post" enctype="multipart/form-data">&ndash;&gt;-->
<#--&lt;#&ndash;        Название категории: <input type="text" name="name"/><br><br>&ndash;&gt;-->

<#--&lt;#&ndash;        фотография: <input type="file" name="file1"/><br><br>&ndash;&gt;-->
<#--&lt;#&ndash;        <input type="submit" value="Добавить категорию"/>&ndash;&gt;-->
<#--&lt;#&ndash;    </form>&ndash;&gt;-->
<#--    &lt;#&ndash;        <h3>Создать новый Матч</h3>&ndash;&gt;-->
<#--    &lt;#&ndash; <form action="/championship/${championship.id}/match/create" method="post" enctype="multipart/form-data">-->
<#--         Имя<input type="text" name="name"/><br><br>-->

<#--         Команды 1-->
<#--         <#list teams as teamOne>-->
<#--             <div>-->
<#--                 <label><input id="teamOne" type="radio" name="teamOne" value="${teamOne.id}">${teamOne.name}</label>-->
<#--             </div>-->
<#--         </#list>-->

<#--         Команды 2-->
<#--         <#list teams as teamTwo>-->
<#--             <div>-->
<#--                 <label><input id="teamTwo" type="radio" name="teamTwo" value="${teamTwo.id}">${teamTwo.name}</label>-->
<#--             </div>-->
<#--         </#list>-->
<#--         <input type="submit" value="Добавить матч"/>-->

<#--     </form>&ndash;&gt;-->
<#--</div>-->
<#--</div>-->

<#--&lt;#&ndash;<b>Автор: </b><a href="/user/${product.user.id}">${product.user.name}</a><br>&ndash;&gt;-->
<#--</body>-->
<#--</html>-->