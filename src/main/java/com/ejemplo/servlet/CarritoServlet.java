package com.ejemplo.servlet;

import com.ejemplo.model.CarritoItem;
import com.ejemplo.model.Producto;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;

@WebServlet("/carrito")
public class CarritoServlet extends HttpServlet {

    // 👇 MISMO CATÁLOGO (para tener datos reales)
    private List<Producto> catalogo = List.of(
            new Producto(1,"Laptop Dell","Computadores",2500000,5),
            new Producto(2,"Mouse Logitech","Periféricos",85000,20),
            new Producto(3,"Teclado Mecánico","Periféricos",220000,10),
            new Producto(4,"Monitor 24","Computadores",650000,8),
            new Producto(5,"Audífonos Sony","Audio",180000,15),
            new Producto(6,"Webcam HD","Periféricos",95000,12)
    );

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();

        // 👉 acción (para limpiar carrito)
        String accion = req.getParameter("accion");

        if ("limpiar".equals(accion)) {
            session.removeAttribute("carrito");
            resp.sendRedirect("carrito");
            return;
        }

        Map<Integer, CarritoItem> carrito =
                (Map<Integer, CarritoItem>) session.getAttribute("carrito");

        if (carrito == null) {
            carrito = new HashMap<>();
            session.setAttribute("carrito", carrito);
        }

        int id = Integer.parseInt(req.getParameter("idProducto"));

        // 👉 buscar producto REAL en el catálogo
        Producto producto = catalogo.stream()
                .filter(p -> p.getId() == id)
                .findFirst()
                .orElse(null);

        if (producto == null) {
            resp.sendRedirect("catalogo");
            return;
        }

        carrito.merge(id,
                new CarritoItem(producto, 1),
                (oldVal, newVal) -> {
                    oldVal.setCantidad(oldVal.getCantidad() + 1);
                    return oldVal;
                });

        resp.sendRedirect("catalogo");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, jakarta.servlet.ServletException {

        HttpSession session = req.getSession(false);

        Map<Integer, CarritoItem> carrito =
                session != null ? (Map<Integer, CarritoItem>) session.getAttribute("carrito") : null;

        req.setAttribute("items", carrito != null ? carrito.values() : List.of());

        req.getRequestDispatcher("/WEB-INF/views/carrito.jsp")
                .forward(req, resp);
    }
}