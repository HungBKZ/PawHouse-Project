package DAO;

import Model.Pet;
import Model.PetCategories;
import Model.User;
import Utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PetDAO extends DBContext {

    public List<Pet> getAll() {
        List<Pet> petList = new ArrayList<>();
        String query = "SELECT p.*, "
                + "CASE "
                + "    WHEN p.AdoptionStatus = 'Available' THEN 'Chưa nhận nuôi' "
                + "    WHEN p.AdoptionStatus = 'Pending' THEN 'Đang chờ duyệt' "
                + "    WHEN p.AdoptionStatus = 'Adopted' THEN 'Đã nhận nuôi' "
                + "    ELSE p.AdoptionStatus "
                + "END AS AdoptionStatusVN "
                + "FROM Pets p";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));
                pet.setPetName(rs.getString("PetName"));
                pet.setSpecies(rs.getString("Species"));
                pet.setBreed(rs.getString("Breed"));
                pet.setAge(rs.getInt("Age"));
                pet.setGender(rs.getString("Gender"));
                pet.setPetImage(rs.getString("PetImage"));
                pet.setAdoptionStatus(rs.getString("AdoptionStatus")); // Lấy giá trị đã chuyển đổi
                petList.add(pet);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return petList;
    }

    public boolean insertPet(Pet pet) {
        String query = "INSERT INTO Pets (CategoryID, PetName, Species, Breed, Age, Gender, PetImage, AdoptionStatus, UserID, InUseService) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            // Set required fields
            ps.setInt(1, pet.getCategory().getCategoryID());
            ps.setString(2, pet.getPetName());
            ps.setString(3, pet.getSpecies());
            ps.setString(4, pet.getBreed());
            ps.setInt(5, pet.getAge());
            ps.setString(6, pet.getGender());
            ps.setString(7, pet.getPetImage());
            
            // Handle AdoptionStatus
            String status = pet.getAdoptionStatus();
            if (status == null || status.trim().isEmpty()) {
                status = "Available"; // Default status
            }
            ps.setString(8, status);
            
            // Handle nullable fields
            if (pet.getOwner() != null && pet.getOwner().getUserID() > 0) {
                ps.setInt(9, pet.getOwner().getUserID());
            } else {
                ps.setNull(9, java.sql.Types.INTEGER);
            }
            
            if (pet.getInUseService() != null && !pet.getInUseService().trim().isEmpty()) {
                ps.setString(10, pet.getInUseService());
            } else {
                ps.setNull(10, java.sql.Types.VARCHAR);
            }

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error inserting pet: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public Pet getById(int petID) {
        String query = "SELECT p.*, pc.CategoryName FROM Pets p LEFT JOIN PetCategories pc ON p.CategoryID = pc.CategoryID WHERE p.PetID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, petID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPet(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching pet by ID: " + e.getMessage());
        }
        return null;
    }

    public boolean updatePet(Pet pet) {
        String query = "UPDATE Pets SET CategoryID=?, PetName=?, Species=?, Breed=?, Age=?, Gender=?, PetImage=?, AdoptionStatus=? WHERE PetID=?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, pet.getCategory().getCategoryID());
            ps.setString(2, pet.getPetName());
            ps.setString(3, pet.getSpecies());
            ps.setString(4, pet.getBreed());
            ps.setInt(5, pet.getAge());
            ps.setString(6, pet.getGender());
            ps.setString(7, pet.getPetImage());
            ps.setString(8, pet.getAdoptionStatus());
            ps.setInt(9, pet.getPetID());

            int rowsUpdated = ps.executeUpdate();
            ps.close();
            return rowsUpdated > 0; // Nếu có dòng bị ảnh hưởng thì trả về true
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Pet> searchPetByName(String petName) {
        List<Pet> petList = new ArrayList<>();
        String query = "SELECT p.*, pc.CategoryName FROM Pets p LEFT JOIN PetCategories pc ON p.CategoryID = pc.CategoryID WHERE p.PetName LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, "%" + petName + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    petList.add(mapResultSetToPet(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error searching pet by name: " + e.getMessage());
        }
        return petList;
    }

    public List<Pet> getPetsByUserId(int userId) {
        List<Pet> pets = new ArrayList<>();
        String query = "SELECT * FROM Pets WHERE UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    pets.add(mapResultSetToPet(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching pets by user ID: " + e.getMessage());
        }
        return pets;
    }

    public List<Pet> getAllPetsForAdoption() {
        List<Pet> pets = new ArrayList<>();
        String query = "SELECT * FROM Pets WHERE AdoptionStatus = 'Available'";
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                pets.add(mapResultSetToPet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching pets for adoption: " + e.getMessage());
        }
        return pets;
    }

    private Pet mapResultSetToPet(ResultSet rs) throws SQLException {
        Pet pet = new Pet();
        pet.setPetID(rs.getInt("PetID"));

        PetCategories category = new PetCategories();
        category.setCategoryID(rs.getInt("CategoryID"));
        category.setCategoryName(rs.getString("CategoryName"));
        pet.setCategory(category);

        pet.setPetName(rs.getString("PetName"));
        pet.setSpecies(rs.getString("Species"));
        pet.setBreed(rs.getString("Breed"));
        pet.setAge(rs.getInt("Age"));
        pet.setGender(rs.getString("Gender"));
        pet.setPetImage(rs.getString("PetImage"));
        pet.setAdoptionStatus(rs.getString("AdoptionStatus"));
        pet.setInUseService(rs.getString("InUseService"));

        User user = new User();
        user.setUserID(rs.getInt("UserID"));
        pet.setOwner(user);

        return pet;
    }

    private void setPreparedStatementForPet(PreparedStatement ps, Pet pet, boolean isUpdate) throws SQLException {
        ps.setInt(1, pet.getCategory().getCategoryID());
        ps.setString(2, pet.getPetName());
        ps.setString(3, pet.getSpecies());
        ps.setString(4, pet.getBreed());
        ps.setInt(5, pet.getAge());
        ps.setString(6, pet.getGender());
        ps.setString(7, pet.getPetImage());
        ps.setString(8, pet.getAdoptionStatus());
        ps.setInt(9, pet.getOwner().getUserID());
        ps.setString(10, pet.getInUseService() != null ? pet.getInUseService() : "N");

        if (isUpdate) {
            ps.setInt(11, pet.getPetID());
        }
    }

    public List<Pet> searchPets(String keyword, Integer categoryID, String status) {
        List<Pet> petList = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT p.*, pc.CategoryName FROM Pets p LEFT JOIN PetCategories pc ON p.CategoryID = pc.CategoryID WHERE 1=1");

        // Xây dựng truy vấn động dựa trên tiêu chí tìm kiếm
        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append(" AND (p.PetName LIKE ? OR p.Species LIKE ? OR p.Breed LIKE ?)");
        }
        if (categoryID != null) {
            query.append(" AND p.CategoryID = ?");
        }
        if (status != null && !status.isEmpty()) {
            query.append(" AND p.AdoptionStatus = ?");
        }

        try {
            PreparedStatement ps = connection.prepareStatement(query.toString());
            int paramIndex = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + keyword + "%");
                ps.setString(paramIndex++, "%" + keyword + "%");
                ps.setString(paramIndex++, "%" + keyword + "%");
            }
            if (categoryID != null) {
                ps.setInt(paramIndex++, categoryID);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));

                PetCategories category = new PetCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                pet.setCategory(category);

                pet.setPetName(rs.getString("PetName"));
                pet.setSpecies(rs.getString("Species"));
                pet.setBreed(rs.getString("Breed"));
                pet.setAge(rs.getInt("Age"));
                pet.setGender(rs.getString("Gender"));
                pet.setPetImage(rs.getString("PetImage"));
                pet.setAdoptionStatus(rs.getString("AdoptionStatus"));
                pet.setInUseService(rs.getString("InUseService"));

                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                pet.setOwner(user);

                petList.add(pet);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return petList;
    }

    public List<PetCategories> getAllCategories() {
        List<PetCategories> categories = new ArrayList<>();
        String query = "SELECT * FROM PetCategories";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PetCategories category = new PetCategories(
                        rs.getInt("CategoryID"),
                        rs.getString("CategoryName"),
                        rs.getString("Description")
                );
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public boolean deletePet(int petID) {
        String query = "DELETE FROM Pets WHERE PetID=?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, petID);
            int rowsDeleted = ps.executeUpdate();
            ps.close();
            return rowsDeleted > 0; // Nếu có dòng bị xóa thì trả về true
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
