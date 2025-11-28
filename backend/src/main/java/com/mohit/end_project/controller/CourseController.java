package com.mohit.end_project.controller;

import com.mohit.end_project.dto.CourseRequest;
import com.mohit.end_project.dto.CourseResponse;
import com.mohit.end_project.dto.CourseSpecializationRequest;
import com.mohit.end_project.dto.EnrollmentResponse;
import com.mohit.end_project.entity.CourseSpecialization;
import com.mohit.end_project.service.CourseService;
import com.mohit.end_project.service.CourseSpecializationService;
import com.mohit.end_project.service.EnrollmentService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/courses")
public class CourseController {

    private final CourseService courseService;
    private final CourseSpecializationService courseSpecializationService;
    private final EnrollmentService enrollmentService;

    public CourseController(CourseService courseService,
            CourseSpecializationService courseSpecializationService,
            EnrollmentService enrollmentService) {
        this.courseService = courseService;
        this.courseSpecializationService = courseSpecializationService;
        this.enrollmentService = enrollmentService;
    }

    @PostMapping
    public ResponseEntity<CourseResponse> createCourse(@Valid @RequestBody CourseRequest request) {
        CourseResponse response = courseService.createCourse(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping
    public ResponseEntity<List<CourseResponse>> getAllCourses() {
        List<CourseResponse> courses = courseService.getAllCourses();
        return ResponseEntity.ok(courses);
    }

    @GetMapping("/{id}")
    public ResponseEntity<CourseResponse> getCourseById(@PathVariable Long id) {
        CourseResponse course = courseService.getCourseById(id);
        return ResponseEntity.ok(course);
    }

    @GetMapping("/code/{code}")
    public ResponseEntity<CourseResponse> getCourseByCourseCode(@PathVariable String code) {
        CourseResponse course = courseService.getCourseByCourseCode(code);
        return ResponseEntity.ok(course);
    }

    @PutMapping("/{id}")
    public ResponseEntity<CourseResponse> updateCourse(@PathVariable Long id,
            @Valid @RequestBody CourseRequest request) {
        CourseResponse response = courseService.updateCourse(id, request);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCourse(@PathVariable Long id) {
        courseService.deleteCourse(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}/students")
    public ResponseEntity<List<EnrollmentResponse>> getCourseStudents(@PathVariable Long id) {
        List<EnrollmentResponse> enrollments = enrollmentService.getCourseEnrollments(id);
        return ResponseEntity.ok(enrollments);
    }

    @GetMapping("/{id}/specializations")
    public ResponseEntity<List<CourseSpecialization>> getCourseSpecializations(@PathVariable Long id) {
        List<CourseSpecialization> specializations = courseSpecializationService.getCourseSpecializations(id);
        return ResponseEntity.ok(specializations);
    }

    @PostMapping("/{id}/specializations")
    public ResponseEntity<CourseSpecialization> mapCourseToSpecialization(
            @PathVariable Long id,
            @Valid @RequestBody CourseSpecializationRequest request) {
        request.setCourseId(id); // Ensure course ID matches path variable
        CourseSpecialization mapping = courseSpecializationService.mapCourseToSpecialization(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(mapping);
    }

    @DeleteMapping("/{id}/specializations/{specId}")
    public ResponseEntity<Void> removeCourseSpecializationMapping(@PathVariable Long id,
            @PathVariable Long specId) {
        courseSpecializationService.removeCourseSpecializationMapping(id, specId);
        return ResponseEntity.noContent().build();
    }
}
