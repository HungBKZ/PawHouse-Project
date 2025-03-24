package Model;

public class AdminPet {
    private int petID;
    private int categoryID;
    private String petName;
    private String species;
    private String breed;
    private int age;
    private String gender;
    private String petImage;
    private String adoptionStatus;
    /**
     * UserID: null đại diện cho trường hợp chưa có người nhận nuôi.
     * Chỉ có giá trị khác null khi AdoptionStatus là "Đã nhận nuôi".
     */
    private Integer userID; // Đổi từ int sang Integer để hỗ trợ null
    private String inUseService;

    public AdminPet() {}

    public AdminPet(int petID, int categoryID, String petName, String species, String breed,
                    int age, String gender, String petImage, String adoptionStatus, Integer userID, String inUseService) {
        this.petID = petID;
        this.categoryID = categoryID;
        this.petName = petName;
        this.species = species;
        this.breed = breed;
        this.age = age;
        this.gender = gender;
        this.petImage = petImage;
        this.adoptionStatus = adoptionStatus;
        this.userID = userID;
        this.inUseService = inUseService;
    }

    public int getPetID() { return petID; }
    public void setPetID(int petID) { this.petID = petID; }
    public int getCategoryID() { return categoryID; }
    public void setCategoryID(int categoryID) { this.categoryID = categoryID; }
    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }
    public String getSpecies() { return species; }
    public void setSpecies(String species) { this.species = species; }
    public String getBreed() { return breed; }
    public void setBreed(String breed) { this.breed = breed; }
    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public String getPetImage() { return petImage; }
    public void setPetImage(String petImage) { this.petImage = petImage; }
    public String getAdoptionStatus() { return adoptionStatus; }
    public void setAdoptionStatus(String adoptionStatus) { this.adoptionStatus = adoptionStatus; }
    public Integer getUserID() { return userID; }
    public void setUserID(Integer userID) { this.userID = userID; }
    public String getInUseService() { return inUseService; }
    public void setInUseService(String inUseService) { this.inUseService = inUseService; }
}