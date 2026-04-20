<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Catálogo</title>
</head>
<body>

<h1>Catálogo de Productos</h1>

<form method="get">
    Buscar: <input type="text" name="q">

    Categoría:
    <select name="cat">
        <option value="">Todas</option>
        <c:forEach var="c" items="${categorias}">
            <option value="${c}">${c}</option>
        </c:forEach>
    </select>

    <button>Filtrar</button>
</form>

<hr>

<c:forEach var="p" items="${productos}">
    <div style="margin-bottom:10px;">
        <b>${p.nombre}</b><br>
        Categoría: ${p.categoria}<br>
        Precio: $${p.precio}<br>

        <form method="post" action="carrito">
            <input type="hidden" name="idProducto" value="${p.id}">
            <button>Agregar al carrito</button>
        </form>
    </div>
</c:forEach>

<hr>

<a href="carrito">🛒 Ver carrito</a>

</body>
</html>