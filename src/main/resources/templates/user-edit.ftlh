<!DOCTYPE html>
<html>
<head>
    <title>BELLSELL</title>
</head>
<body>
<h1>BELLSELL</h1><hr>
<h3>Редактирование пользователя ${user.name}</h3>
<form action="/admin/user/edit/${user.id}" method="post">
    <#list roles as role>
        <div>
            <label><input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</label>
        </div>
    </#list>
    <input type="hidden" value="${_csrf.token}" name="_csrf">
    <button type="submit">Сохранить</button>
</form>
</body>
</html>