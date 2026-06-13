<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    final String rootUrl="jdbc:mysql://interchange.proxy.rlwy.net:21460/railway";
    final String dbUser = "root";
    final String dbPassword = "YaZaZiQeNKDmWSXsKsQUlpTHVEXfWAex";

    try {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String course = request.getParameter("course");
        String reference = request.getParameter("reference");

        Class.forName("com.mysql.cj.jdbc.Driver");



        try (Connection con = DriverManager.getConnection(rootUrl, dbUser, dbPassword);
             Statement tableSt = con.createStatement()) {
            tableSt.executeUpdate(
                    "CREATE TABLE IF NOT EXISTS enquiries (" +
                            "id INT AUTO_INCREMENT PRIMARY KEY, " +
                            "fullName VARCHAR(100) NOT NULL, " +
                            "phone VARCHAR(20) NOT NULL, " +
                            "email VARCHAR(100) NOT NULL, " +
                            "course VARCHAR(100) NOT NULL, " +
                            "`reference` VARCHAR(100), " +
                            "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                            ")"
            );

            try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO enquiries(fullName, phone, email, course, `reference`) VALUES (?, ?, ?, ?, ?)")) {
                ps.setString(1, name);
                ps.setString(2, phone);
                ps.setString(3, email);
                ps.setString(4, course);
                ps.setString(5, reference);

                ps.executeUpdate();
            }
        }

        response.sendRedirect("index.html");

    } catch(Exception e) {
        out.println("<h3>Error while submitting enquiry</h3>");
        out.println("<p>" + e.getMessage() + "</p>");
    }
%>