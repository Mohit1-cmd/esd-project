package com.mohit.end_project.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SpecializationRequest {

    @NotNull(message = "Domain ID is required")
    private Long domainId;

    @NotBlank(message = "Specialization name is required")
    @Size(max = 100, message = "Specialization name must not exceed 100 characters")
    private String specializationName;

    private String description;
}
