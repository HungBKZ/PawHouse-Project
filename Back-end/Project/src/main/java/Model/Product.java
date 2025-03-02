/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class Product {

    private int productID;
    private ProductCategories category;
    private String productName;
    private String description;
    private double price;
    private int stock;
    private String productImage;
    private boolean productStatus;

    public Product() {
    }

    public Product(int productID, ProductCategories category, String productName, String description, double price, int stock, String productImage, boolean productStatus) {
        this.productID = productID;
        this.category = category;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.productImage = productImage;
        this.productStatus = productStatus;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public ProductCategories getCategory() {
        return category;
    }

    public void setCategory(ProductCategories category) {
        this.category = category;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public boolean isProductStatus() {
        return productStatus;
    }

    public void setProductStatus(boolean prouctStatus) {
        this.productStatus = productStatus;
    }

}
