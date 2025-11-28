package com.mohit.end_project.dto;

import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StudentRequest {

    @NotBlank(message = "Roll number is required")
    @Size(max = 20, message = "Roll number must not exceed 20 characters")
    private String rollNumber;

    @NotBlank(message = "First name is required")
    @Size(max = 50, message = "First name must not exceed 50 characters")
    private String firstName;

    @NotBlank(message = "Last name is required")
    @Size(max = 50, message = "Last name must not exceed 50 characters")
    private String lastName;

    @NotBlank(message = "Email is required")
    @Email(message = "Email must be valid")
    @Size(max = 100, message = "Email must not exceed 100 characters")
    private String email;

    @DecimalMin(value = "0.0", message = "CGPA must be at least 0.0")
    @DecimalMax(value = "4.0", message = "CGPA must not exceed 4.0")
    private BigDecimal cgpa;

    @Min(value = 0, message = "Total credits must be at least 0")
    private Integer totalCredits;

    @Min(value = 2020, message = "Graduation year must be at least 2020")
    @Max(value = 2030, message = "Graduation year must not exceed 2030")
    private Integer graduationYear;
}
