package Model;

import java.sql.Timestamp;

public class Appointment {

    private int appointmentID;
    private User customer;
    private User staff;
    private User doctor;
    private Pet pet;
    private Service service;
    private Timestamp appointmentDate;
    private Timestamp bookingDate;
    private String appointmentStatus;  // 🆕 Thêm trạng thái cuộc hẹn
    private String notes;
    private double price;

    public Appointment() {
    }

    public Appointment(int appointmentID, User customer, User staff, User doctor, Pet pet, Service service,
            Timestamp appointmentDate, Timestamp bookingDate, String appointmentStatus, String notes, double price) {
        this.appointmentID = appointmentID;
        this.customer = customer;
        this.staff = staff;
        this.doctor = doctor;
        this.pet = pet;
        this.service = service;
        this.appointmentDate = appointmentDate;
        this.bookingDate = bookingDate;
        this.appointmentStatus = appointmentStatus;  // 🆕 Thêm vào constructor
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

    public Timestamp getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(Timestamp appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public Timestamp getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Timestamp bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getAppointmentStatus() {  // 🆕 Getter cho trạng thái cuộc hẹn
        return appointmentStatus;
    }

    public void setAppointmentStatus(String appointmentStatus) {  // 🆕 Setter cho trạng thái cuộc hẹn
        this.appointmentStatus = appointmentStatus;
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
