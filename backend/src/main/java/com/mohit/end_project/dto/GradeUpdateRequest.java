package com.mohit.end_project.dto;

import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GradeUpdateRequest {

    @Pattern(regexp = "[ABCDF][+-]?", message = "Grade must be valid (A, A-, B+, B, etc.)")
    private String grade;
}
