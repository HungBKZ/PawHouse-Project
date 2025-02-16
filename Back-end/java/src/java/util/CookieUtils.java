package util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieUtils {
    private static final String USER_COOKIE_NAME = "user_data";
    private static final int COOKIE_MAX_AGE = 24 * 60 * 60; // 24 hours

    public static void storeCookie(HttpServletResponse response, String value) {
        Cookie cookie = new Cookie(USER_COOKIE_NAME, value);
        cookie.setMaxAge(COOKIE_MAX_AGE);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    public static String getCookieValue(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (USER_COOKIE_NAME.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    public static void removeCookie(HttpServletResponse response) {
        Cookie cookie = new Cookie(USER_COOKIE_NAME, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}
