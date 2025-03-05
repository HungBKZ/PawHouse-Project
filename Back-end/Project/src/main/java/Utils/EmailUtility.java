package Utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtility {
    private static final String EMAIL_SENDER = "hungnhcce180150@fpt.edu.vn";
    private static final String PASSWORD = "hvwzszhyeeyifpaj"; // Mật khẩu ứng dụng của Google

    public static void sendEmail(String recipient, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_SENDER, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_SENDER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject(subject);

            // ⚡ Sửa lỗi hiển thị HTML trong email
            message.setContent(content, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("📩 Email đã gửi thành công đến: " + recipient);
        } catch (MessagingException e) {
            e.printStackTrace();
            System.err.println("❌ Lỗi gửi email: " + e.getMessage());
        }
    }
}
