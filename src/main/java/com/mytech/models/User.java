package com.mytech.models;

public class User {
  private int id;
  private String username;
  private String password;
  private String image;
  private String role;

  // Constructor
  public User(int id, String username, String password, String image, String role) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.image = image;
    this.role = role;
  }

  public User(int id, String username, String image, String role) {
    this.id = id;
    this.username = username;
    this.image = image;
    this.role = role;
  }

  // Getter
  public int getId() { return id; }
  public String getUsername() { return username; }
  public String getPassword() { return password; }
  public String getImage() { return image; }
  public String getRole() { return role; }

  // Setter
  public void setId(int id) { this.id = id; }
  public void setUsername(String username) { this.username = username; }
  public void setPassword(String password) { this.password = password; }
  public void setImage(String image) { this.image = image; }
  public void setRole(String role) { this.role = role; }
}
