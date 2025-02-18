<%@ page import="Model.User" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="Utils.PasswordHasher" %>
<%!
    public User getAuthenticatedUser(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("authToken")) {
                    try {
                        String decodedValue = PasswordHasher.decodeBase64(cookie.getValue());
                        String[] parts = decodedValue.split(":");
                        if (parts.length == 2) {
                            String email = parts[0];
                            UserDAO userDAO = new UserDAO();
                            return userDAO.getUserByEmail(email);
                        }
                    } catch (Exception e) {
                        // Handle any decoding errors
                        e.printStackTrace();
                    }
                    break;
                }
            }
        }
        return null;
    }
%>
