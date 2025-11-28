package com.mohit.end_project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StudentResponse {
    private Long studentId;
    private String rollNumber;
    private String firstName;
    private String lastName;
    private String email;
    private BigDecimal cgpa;
    private Integer totalCredits;
    private Integer graduationYear;
}
