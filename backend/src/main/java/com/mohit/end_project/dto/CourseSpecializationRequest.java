package com.mohit.end_project.dto;

import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseSpecializationRequest {

    @NotNull(message = "Course ID is required")
    private Long courseId;

    @NotNull(message = "Specialization ID is required")
    private Long specializationId;

    @NotNull(message = "Credits toward specialization is required")
    @Min(value = 1, message = "Credits must be at least 1")
    @Max(value = 10, message = "Credits must not exceed 10")
    private Integer creditsTowardSpecialization;
}
