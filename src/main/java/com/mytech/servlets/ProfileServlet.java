package com.mytech.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.mytech.models.User;
import com.mytech.utils.JDBCUtil;

@WebServlet("/profile")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024)
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("download".equals(action)) {
            downloadImage(request, response);
        } else {
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("upload".equals(action)) {
            uploadImage(request, response);
        }
    }

    private void uploadImage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        Part filePart = request.getPart("imageFile");

        if (filePart == null) {
            System.out.println("filePart is null");
            request.setAttribute("error", "Không nhận được file từ form!");
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        }
        
        if (filePart.getSize() == 0) {
            System.out.println("filePart size is 0");
            request.setAttribute("error", "Vui lòng chọn file để upload!");
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        }

        String originalFileName = extractFileName(filePart);
        String fileExtension = originalFileName != null && originalFileName.contains(".") 
                ? originalFileName.substring(originalFileName.lastIndexOf(".")) : ".jpg";
        String fileName = "avatar_" + System.currentTimeMillis() + fileExtension;
        System.out.println("Generated fileName: " + fileName);

        String appPath = request.getServletContext().getRealPath("");
        String uploadPath = appPath + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        System.out.println("Upload path: " + uploadPath);

        if (!uploadDir.exists()) {
            System.out.println("Creating upload directory: " + uploadPath);
            uploadDir.mkdirs(); // Dùng mkdirs() để tạo cả thư mục cha nếu cần
        }

        String filePath = uploadPath + File.separator + fileName;
        System.out.println("Saving file to: " + filePath);
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, new File(filePath).toPath());
            System.out.println("File saved successfully to: " + filePath);
        } catch (IOException e) {
            System.out.println("Error saving file: " + e.getMessage());
            throw new ServletException("Lỗi khi lưu file: " + e.getMessage(), e);
        }

        String dbFilePath = UPLOAD_DIR + "/" + fileName;
        System.out.println("DB file path: " + dbFilePath);
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("UPDATE users SET image = ? WHERE id = ?")) {
            ps.setString(1, dbFilePath);
            ps.setInt(2, user.getId());
            int rowsUpdated = ps.executeUpdate();
            System.out.println("Rows updated in DB: " + rowsUpdated);

            user.setImage(dbFilePath);
            request.getSession().setAttribute("user", user);
            response.sendRedirect("profile");
        } catch (Exception e) {
            System.out.println("Error updating DB: " + e.getMessage());
            throw new ServletException("Lỗi khi cập nhật database: " + e.getMessage(), e);
        }
    }

    private void downloadImage(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        String imagePath = user.getImage();

        if (imagePath != null && !imagePath.isEmpty()) {
            String fullPath = request.getServletContext().getRealPath("") + File.separator + imagePath;
            File downloadFile = new File(fullPath);

            if (downloadFile.exists()) {
                response.setContentType("image/jpeg");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + downloadFile.getName() + "\"");
                Files.copy(downloadFile.toPath(), response.getOutputStream());
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy ảnh");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không có ảnh để tải");
        }
    }

    private String extractFileName(Part part) {
        if (part == null) {
            return null;
        }
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) {
            return null;
        }
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                String fileName = s.substring(s.indexOf("=") + 2, s.length() - 1);
                return fileName.isEmpty() ? null : fileName;
            }
        }
        return null;
    }
}