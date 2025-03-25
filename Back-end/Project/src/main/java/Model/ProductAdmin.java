package Model;

public class ProductAdmin {
    private int productID;
    private int categoryID;
    private String productName;
    private String description;
    private double price;
    private int stock;
    private String productImage;
    private int productStatus;

    public ProductAdmin() {}

    public ProductAdmin(int productID, int categoryID, String productName, String description, double price, int stock, String productImage, int productStatus) {
        this.productID = productID;
        this.categoryID = categoryID;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.productImage = productImage;
        this.productStatus = productStatus;
    }

    public int getProductID() { return productID; }
    public int getCategoryID() { return categoryID; }
    public String getProductName() { return productName; }
    public String getDescription() { return description; }
    public double getPrice() { return price; }
    public int getStock() { return stock; }
    public String getProductImage() { return productImage; }
    public int getProductStatus() { return productStatus; }

    public void setProductID(int productID) { this.productID = productID; }
    public void setCategoryID(int categoryID) { this.categoryID = categoryID; }
    public void setProductName(String productName) { this.productName = productName; }
    public void setDescription(String description) { this.description = description; }
    public void setPrice(double price) { this.price = price; }
    public void setStock(int stock) { this.stock = stock; }
    public void setProductImage(String productImage) { this.productImage = productImage; }
    public void setProductStatus(int productStatus) { this.productStatus = productStatus; }

    // Phương thức ánh xạ categoryID sang tên danh mục
    public String getCategoryName() {
        switch (this.categoryID) {
            case 1: return "Thức ăn cho chó";
            case 2: return "Thức ăn cho mèo";
            case 3: return "Thức ăn cho bò sát";
            case 4: return "Bát ăn, khay ăn";
            case 5: return "Sữa tắm, dầu gội";
            case 6: return "Cát vệ sinh cho mèo";
            case 7: return "Phụ kiện thời trang";
            case 8: return "Ba lô, túi vận chuyển";
            case 9: return "Dây dắt, vòng cổ, rọ mõm";
            case 10: return "Đồ chơi tương tác";
            case 11: return "Đồ chơi nhai";
            case 12: return "Bỉm, lót vệ sinh, túi phân";
            case 13: return "Dụng cụ sưởi ấm và đèn UV";
            case 14: return "Sản phẩm chăm sóc bò sát";
            case 15: return "Thức ăn cho chuột";
            default: return "Không xác định";
        }
    }
}