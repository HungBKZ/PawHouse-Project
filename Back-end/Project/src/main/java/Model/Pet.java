/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class Pet {

    private int petID;
    private PetCategories category;
    private String petName;
    private String species;
    private String breed;
    private int age;
    private String gender;
    private String petImage;
    private String adoptionStatus;
    private User owner;
    private String inUseService;

    public Pet() {
    }

    public Pet(int petID, PetCategories category, String petName, String species, String breed, int age, String gender, String petImage, String adoptionStatus, User owner) {
        this.petID = petID;
        this.category = category;
        this.petName = petName;
        this.species = species;
        this.breed = breed;
        this.age = age;
        this.gender = gender;
        this.petImage = petImage;
        this.adoptionStatus = adoptionStatus;
        this.owner = owner;
        this.inUseService = null; // Default value
    }

    public Pet(int petID, PetCategories category, String petName, String species, String breed, int age, String gender, String petImage, String adoptionStatus, User owner, String inUseService) {
        this.petID = petID;
        this.category = category;
        this.petName = petName;
        this.species = species;
        this.breed = breed;
        this.age = age;
        this.gender = gender;
        this.petImage = petImage;
        this.adoptionStatus = adoptionStatus;
        this.owner = owner;
        this.inUseService = inUseService;
    }

    public String getInUseService() {
        return inUseService;
    }

    public void setInUseService(String inUseService) {
        this.inUseService = inUseService;
    }

    public int getPetID() {
        return petID;
    }

    public void setPetID(int petID) {
        this.petID = petID;
    }

    public PetCategories getCategory() {
        return category;
    }

    public void setCategory(PetCategories category) {
        this.category = category;
    }

    public String getPetName() {
        return petName;
    }

    public void setPetName(String petName) {
        this.petName = petName;
    }

    public String getSpecies() {
        return species;
    }

    public void setSpecies(String species) {
        this.species = species;
    }

    public String getBreed() {
        return breed;
    }

    public void setBreed(String breed) {
        this.breed = breed;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPetImage() {
        return petImage;
    }

    public void setPetImage(String petImage) {
        this.petImage = petImage;
    }

    public String getAdoptionStatus() {
        return adoptionStatus;
    }

    public void setAdoptionStatus(String adoptionStatus) {
        this.adoptionStatus = adoptionStatus;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }
}
