package com.mohit.end_project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StudentSpecializationDTO {
    private Long studentId;
    private String rollNumber;
    private String firstName;
    private String lastName;
    private String email;
    private Long specializationId;
    private String specializationName;
    private String domainName;
    private Integer totalCredits;
    private Boolean hasSpecialization; // true if credits > 20
}
