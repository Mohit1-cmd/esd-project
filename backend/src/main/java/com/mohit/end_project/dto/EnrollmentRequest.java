package com.mohit.end_project.dto;

import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EnrollmentRequest {

    @NotNull(message = "Student ID is required")
    private Long studentId;

    @NotNull(message = "Course ID is required")
    private Long courseId;

    @NotBlank(message = "Academic year is required")
    @Pattern(regexp = "\\d{4}-\\d{2}", message = "Academic year must be in format YYYY-YY")
    private String academicYear;

    @Size(max = 10, message = "Semester must not exceed 10 characters")
    private String semester;

    @Pattern(regexp = "[ABCDF][+-]?", message = "Grade must be valid (A, A-, B+, B, etc.)")
    private String grade;
}
