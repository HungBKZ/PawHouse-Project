/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 *
 * @author admin
 */
public class Appointment {

    private int appointmentID;
    private User customer;
    private User staff;
    private User doctor;
    private Pet pet;
    private Service service;
    private Date appointmentDate;
    private Date bookingDate;
    private String notes;
    private double price;

    public Appointment() {
    }

    public Appointment(int appointmentID, User customer, User staff, User doctor, Pet pet, Service service, Date appointmentDate, Date bookingDate, String notes, double price) {
        this.appointmentID = appointmentID;
        this.customer = customer;
        this.staff = staff;
        this.doctor = doctor;
        this.pet = pet;
        this.service = service;
        this.appointmentDate = appointmentDate;
        this.bookingDate = bookingDate;
        this.notes = notes;
        this.price = price;
    }

    public int getAppointmentID() {
        return appointmentID;
    }

    public void setAppointmentID(int appointmentID) {
        this.appointmentID = appointmentID;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public User getStaff() {
        return staff;
    }

    public void setStaff(User staff) {
        this.staff = staff;
    }

    public User getDoctor() {
        return doctor;
    }

    public void setDoctor(User doctor) {
        this.doctor = doctor;
    }

    public Pet getPet() {
        return pet;
    }

    public void setPet(Pet pet) {
        this.pet = pet;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public Date getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(Date appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

}
