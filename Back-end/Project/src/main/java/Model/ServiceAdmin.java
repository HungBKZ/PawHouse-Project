package Model;

public class ServiceAdmin {
    private int serviceID;
    private int categoryID;
    private String serviceName;
    private String description;
    private double price;
    private String serviceImage;
    private int serviceStatus;

    public ServiceAdmin(int serviceID, int categoryID, String serviceName, String description, double price, String serviceImage, int serviceStatus) {
        this.serviceID = serviceID;
        this.categoryID = categoryID;
        this.serviceName = serviceName;
        this.description = description;
        this.price = price;
        this.serviceImage = serviceImage;
        this.serviceStatus = serviceStatus;
    }

    public int getServiceID() { return serviceID; }
    public void setServiceID(int serviceID) { this.serviceID = serviceID; }
    public int getCategoryID() { return categoryID; }
    public void setCategoryID(int categoryID) { this.categoryID = categoryID; }
    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getServiceImage() { return serviceImage; }
    public void setServiceImage(String serviceImage) { this.serviceImage = serviceImage; }
    public int getServiceStatus() { return serviceStatus; }
    public void setServiceStatus(int serviceStatus) { this.serviceStatus = serviceStatus; }

    // Phương thức ánh xạ categoryID sang tên danh mục (tùy chọn)
    public String getCategoryName() {
        switch (this.categoryID) {
            case 1: return "Chăm sóc lông";
            case 2: return "Vệ sinh";
            case 3: return "Huấn luyện";
            case 4: return "Giữ thú cưng";
            case 5: return "Massage & Thư giãn";
            case 6: return "Vận chuyển";
            case 7: return "Khám tổng quát";
            case 8: return "Tiêm phòng";
            case 9: return "Chữa bệnh";
            case 10: return "Phẫu thuật";
            case 11: return "Xét nghiệm";
            case 12: return "Nha khoa";
            default: return "Không xác định";
        }
    }
}