<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <html>
    <body>

    <h1>Lista de Tareas</h1>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/tareas">
    <input type="hidden" name="accion" value="agregar">
        <input type="text" name="titulo">
            <button>Agregar</button>
</form>

<hr>

    <c:forEach var="t" items="${tareas}">
        <p>
            ${t.titulo}
            <form method="post" action="${pageContext.request.contextPath}/tareas">
                <input type="hidden" name="accion" value="eliminar">
                    <input type="hidden" name="id" value="${t.id}">
                        <button>Eliminar</button>
            </form>
        </p>
    </c:forEach>

</body>
</html>