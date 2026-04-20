<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Carrito</title>
</head>
<body>

<h1>Carrito de Compras</h1>

<c:set var="total" value="0"/>

<c:if test="${empty items}">
    <p>El carrito está vacío</p>
</c:if>

<c:if test="${not empty items}">
    <table border="1">
        <tr>
            <th>Producto</th>
            <th>Cantidad</th>
            <th>Subtotal</th>
        </tr>

        <c:forEach var="item" items="${items}">
            <tr>
                <td>${item.producto.nombre}</td>
                <td>${item.cantidad}</td>
                <td>$${item.subtotal}</td>
            </tr>

            <c:set var="total" value="${total + item.subtotal}"/>
        </c:forEach>
    </table>

    <h3>Total: $${total}</h3>
</c:if>

<br>

<form method="post" action="carrito">
    <input type="hidden" name="accion" value="limpiar">
    <button>Limpiar carrito</button>
</form>

<br>

<a href="catalogo">← Volver al catálogo</a>

</body>
</html>