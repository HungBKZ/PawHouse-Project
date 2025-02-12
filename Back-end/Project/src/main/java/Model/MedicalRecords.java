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
public class MedicalRecords {

    private int recordID;
    private Appointment appointment;
    private User doctor;
    private Pet pet;
    private String diagnosis;
    private String treatment;
    private String prescription;
    private String vaccinationDetails;
    private Date nextVaccinationDate;
    private double weight;
    private double temperature;
    private String notes;
    private Date recordDate;

    public MedicalRecords() {
    }

    public MedicalRecords(int recordID, Appointment appointment, User doctor, Pet pet, String diagnosis, String treatment, String prescription, String vaccinationDetails, Date nextVaccinationDate, double weight, double temperature, String notes, Date recordDate) {
        this.recordID = recordID;
        this.appointment = appointment;
        this.doctor = doctor;
        this.pet = pet;
        this.diagnosis = diagnosis;
        this.treatment = treatment;
        this.prescription = prescription;
        this.vaccinationDetails = vaccinationDetails;
        this.nextVaccinationDate = nextVaccinationDate;
        this.weight = weight;
        this.temperature = temperature;
        this.notes = notes;
        this.recordDate = recordDate;
    }

    public int getRecordID() {
        return recordID;
    }

    public void setRecordID(int recordID) {
        this.recordID = recordID;
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
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

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getTreatment() {
        return treatment;
    }

    public void setTreatment(String treatment) {
        this.treatment = treatment;
    }

    public String getPrescription() {
        return prescription;
    }

    public void setPrescription(String prescription) {
        this.prescription = prescription;
    }

    public String getVaccinationDetails() {
        return vaccinationDetails;
    }

    public void setVaccinationDetails(String vaccinationDetails) {
        this.vaccinationDetails = vaccinationDetails;
    }

    public Date getNextVaccinationDate() {
        return nextVaccinationDate;
    }

    public void setNextVaccinationDate(Date nextVaccinationDate) {
        this.nextVaccinationDate = nextVaccinationDate;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public double getTemperature() {
        return temperature;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Date getRecordDate() {
        return recordDate;
    }

    public void setRecordDate(Date recordDate) {
        this.recordDate = recordDate;
    }

}
