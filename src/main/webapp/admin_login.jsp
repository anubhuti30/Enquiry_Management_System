<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if ("admin".equals(username) && "admin123".equals(password)) {
        session.setAttribute("adminUser", username);
        response.sendRedirect("dashboard.jsp");
    } else {
        response.sendRedirect("admin.html?error=invalid");
    }
%>
