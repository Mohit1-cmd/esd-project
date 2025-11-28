package com.mohit.end_project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseResponse {
    private Long courseId;
    private String courseCode;
    private String courseName;
    private String description;
    private Integer credits;
}
