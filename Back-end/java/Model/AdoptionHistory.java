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
public class AdoptionHistory {

    private int adoptionID;
    private Pet pet;
    private Date adoptionDate;
    private String status;
    private String notes;

    public AdoptionHistory() {
    }

    public AdoptionHistory(int adoptionID, Pet pet, Date adoptionDate, String status, String notes) {
        this.adoptionID = adoptionID;
        this.pet = pet;
        this.adoptionDate = adoptionDate;
        this.status = status;
        this.notes = notes;
    }

    public int getAdoptionID() {
        return adoptionID;
    }

    public void setAdoptionID(int adoptionID) {
        this.adoptionID = adoptionID;
    }

    public Pet getPet() {
        return pet;
    }

    public void setPet(Pet pet) {
        this.pet = pet;
    }

    public Date getAdoptionDate() {
        return adoptionDate;
    }

    public void setAdoptionDate(Date adoptionDate) {
        this.adoptionDate = adoptionDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

}
