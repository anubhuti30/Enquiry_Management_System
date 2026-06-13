<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String dbUrl = "jdbc:mysql://interchange.proxy.rlwy.net:21460/railway";
    String dbUser = "root";
    String dbPassword = "YaZaZiQeNKDmWSXsKsQUlpTHVEXfWAex";

    try {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String course = request.getParameter("course");
        String reference = request.getParameter("reference");

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(
                dbUrl,
                dbUser,
                dbPassword
        );

        Statement st = con.createStatement();

        st.executeUpdate(
                "CREATE TABLE IF NOT EXISTS enquiries (" +
                        "id INT AUTO_INCREMENT PRIMARY KEY," +
                        "fullName VARCHAR(100) NOT NULL," +
                        "phone VARCHAR(20) NOT NULL," +
                        "email VARCHAR(100) NOT NULL," +
                        "course VARCHAR(100) NOT NULL," +
                        "`reference` VARCHAR(100)," +
                        "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                        ")"
        );

        PreparedStatement ps = con.prepareStatement(
                "INSERT INTO enquiries(fullName, phone, email, course, `reference`) VALUES (?, ?, ?, ?, ?)"
        );

        ps.setString(1, name);
        ps.setString(2, phone);
        ps.setString(3, email);
        ps.setString(4, course);
        ps.setString(5, reference);

        int rows = ps.executeUpdate();

        ps.close();
        st.close();
        con.close();

        if(rows > 0){
            response.sendRedirect("index.html");
        } else {
            out.println("<h3>Failed to save enquiry.</h3>");
        }

    } catch (Exception e) {

        out.println("<h2>Error while submitting enquiry</h2>");
        out.println("<pre>");
        e.printStackTrace(new java.io.PrintWriter(out));
        out.println("</pre>");

    }
%>