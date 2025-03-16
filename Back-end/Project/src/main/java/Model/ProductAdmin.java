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
}
