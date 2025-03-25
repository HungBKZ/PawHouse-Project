package Model;

public class ServiceAdmin {
    private int serviceID;
    private int categoryID;
    private String serviceName;
    private String description;
    private double price;
    private String serviceImage;
    private int serviceStatus;
    private String categoryName; // Thêm thuộc tính này

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
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
}