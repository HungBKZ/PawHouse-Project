package Utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class PasswordHasher {
    public static String hashMD5(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(password.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
    
    public static String encodeBase64(String text) {
        return Base64.getEncoder().encodeToString(text.getBytes());
    }
    
    public static String decodeBase64(String encodedText) {
        try {
            byte[] decodedBytes = Base64.getDecoder().decode(encodedText);
            return new String(decodedBytes);
        } catch (IllegalArgumentException e) {
            return ""; // Return empty string if decoding fails
        }
    }
}
