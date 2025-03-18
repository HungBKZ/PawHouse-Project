/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class Service {

    private int serviceID;
    private ServiceCategories category;
    private String serviceName;
    private String description;
    private double price;
    private String serviceImage;
    private boolean serviceStatus;

    public Service() {
    }
    // Constructor nhận một serviceID
    public Service(int serviceID) {
        this.serviceID = serviceID;
    }

    public Service(int serviceID, ServiceCategories category, String serviceName, String description, double price, String serviceImage, boolean serviceStatus) {
        this.serviceID = serviceID;
        this.category = category;
        this.serviceName = serviceName;
        this.description = description;
        this.price = price;
        this.serviceImage = serviceImage;
        this.serviceStatus = serviceStatus;
    }

    public Service(int serviceID, String serviceName, double price) {
        this.serviceID = serviceID;
        this.serviceName = serviceName;
        this.price = price;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }

    public ServiceCategories getCategory() {
        return category;
    }

    public void setCategory(ServiceCategories category) {
        this.category = category;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
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

    public String getServiceImage() {
        return serviceImage;
    }

    public void setServiceImage(String serviceImage) {
        this.serviceImage = serviceImage;
    }

    public boolean isServiceStatus() {
        return serviceStatus;
    }

    public void setServiceStatus(boolean serviceStatus) {
        this.serviceStatus = serviceStatus;
    }

}
