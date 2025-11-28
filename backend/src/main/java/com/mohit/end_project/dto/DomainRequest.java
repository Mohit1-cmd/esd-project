package com.mohit.end_project.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DomainRequest {

    @NotBlank(message = "Domain name is required")
    @Size(max = 100, message = "Domain name must not exceed 100 characters")
    private String domainName;

    private String description;
}
