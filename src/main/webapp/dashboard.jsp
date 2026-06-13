<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.sql.*" %>
<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("admin.html");
        return;
    }
    final String rootUrl="jdbc:mysql://interchange.proxy.rlwy.net:21460/railway";
   final String dbUser = "root";
    final String dbPassword = "YaZaZiQeNKDmWSXsKsQUlpTHVEXfWAex";

    Class.forName("com.mysql.cj.jdbc.Driver");


%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            background-color: #12002a;
            color: #ffffff;
            font-family: Arial, sans-serif;
            margin: 0;
            min-height: 100vh;
        }

        .page {
            max-width: 1100px;
            margin: 0 auto;
            padding: 36px 20px;
        }

        .topbar {
            align-items: center;
            display: flex;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 24px;
        }

        h1 {
            color: #f3c4ff;
            font-size: 30px;
            margin: 0;
        }

        .logout {
            border: 1px solid #ce93d8;
            border-radius: 8px;
            color: #f3c4ff;
            padding: 10px 14px;
            text-decoration: none;
        }

        .logout:hover {
            background-color: rgba(255, 255, 255, 0.08);
        }

        .table-box {
            background-color: rgba(255, 255, 255, 0.06);
            border: 1px solid #ce93d8;
            border-radius: 12px;
            overflow: hidden;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border-bottom: 1px solid rgba(206, 147, 216, 0.28);
            padding: 14px 16px;
            text-align: left;
        }

        th {
            background-color: rgba(224, 64, 251, 0.18);
            color: #f3c4ff;
            font-size: 13px;
            text-transform: uppercase;
        }

        td {
            color: #f8eaff;
            font-size: 14px;
        }

        tr:hover td {
            background-color: rgba(255, 255, 255, 0.05);
        }

        .empty {
            color: #ce93d8;
            padding: 24px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="page">
    <div class="topbar">
        <h1>Admin Dashboard</h1>
        <a class="logout" href="logout.jsp">Logout</a>
    </div>

    <div class="table-box">
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Course</th>
                <th>Reference</th>
            </tr>

            <%
                boolean hasRows = false;

                try (Connection con = DriverManager.getConnection(rootUrl, dbUser, dbPassword);
                     Statement st = con.createStatement()) {
                    st.executeUpdate(
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

                    try (ResultSet rs = st.executeQuery("SELECT * FROM enquiries ORDER BY id DESC")) {
                        while (rs.next()) {
                            hasRows = true;
            %>
            <tr>
                <td><%= rs.getString("id") %></td>
                <td><%= rs.getString("fullName") %></td>
                <td><%= rs.getString("phone") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("course") %></td>
                <td><%= rs.getString("reference") == null ? "" : rs.getString("reference") %></td>
            </tr>
            <%
                        }
                    }
                }

                if (!hasRows) {
            %>
            <tr>
                <td class="empty" colspan="6">No enquiries found.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</div>
</body>
</html>
