/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Timestamp;

/**
 *
 * @author admin
 */
public class ProductComment {

    private int commentID;
    private User user;
    private Product product;
    private int star;
    private String content;
    private Timestamp dateComment;
    private String image;
    private boolean productCommentStatus;

    public ProductComment() {
    }

    public ProductComment(int commentID, User user, Product product, int star, String content, Timestamp dateComment, String image, boolean productCommentStatus) {
        this.commentID = commentID;
        this.user = user;
        this.product = product;
        this.star = star;
        this.content = content;
        this.dateComment = dateComment;
        this.image = image;
        this.productCommentStatus = productCommentStatus;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getDateComment() {
        return dateComment;
    }

    public void setDateComment(Timestamp dateComment) {
        this.dateComment = dateComment;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public boolean isProductCommentStatus() {
        return productCommentStatus;
    }

    public void setProductCommentStatus(boolean productCommentStatus) {
        this.productCommentStatus = productCommentStatus;
    }

}
