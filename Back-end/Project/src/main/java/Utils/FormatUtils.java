package Utils;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FormatUtils {
    public static String formatDate(Date date) {
        if (date == null) return "";
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        return sdf.format(date);
    }
    
    public static String formatPrice(double price) {
        DecimalFormat df = new DecimalFormat("#,###");
        return df.format(price);
    }
    
    public static String getStatusText(String status) {
        if (status == null) return "";
        switch (status.toLowerCase()) {
            case "pending": return "Chờ xác nhận";
            case "confirmed": return "Đã xác nhận";
            case "completed": return "Hoàn thành";
            case "cancelled": return "Đã hủy";
            default: return status;
        }
    }
}
