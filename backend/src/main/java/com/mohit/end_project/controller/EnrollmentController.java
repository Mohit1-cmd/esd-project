package com.mohit.end_project.controller;

import com.mohit.end_project.dto.EnrollmentRequest;
import com.mohit.end_project.dto.EnrollmentResponse;
import com.mohit.end_project.dto.GradeUpdateRequest;
import com.mohit.end_project.service.EnrollmentService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/enrollments")
public class EnrollmentController {

    private final EnrollmentService enrollmentService;

    public EnrollmentController(EnrollmentService enrollmentService) {
        this.enrollmentService = enrollmentService;
    }

    @PostMapping
    public ResponseEntity<EnrollmentResponse> enrollStudent(@Valid @RequestBody EnrollmentRequest request) {
        EnrollmentResponse response = enrollmentService.enrollStudent(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping
    public ResponseEntity<List<EnrollmentResponse>> getAllEnrollments() {
        List<EnrollmentResponse> enrollments = enrollmentService.getAllEnrollments();
        return ResponseEntity.ok(enrollments);
    }

    @GetMapping("/{id}")
    public ResponseEntity<EnrollmentResponse> getEnrollmentById(@PathVariable Long id) {
        EnrollmentResponse enrollment = enrollmentService.getEnrollmentById(id);
        return ResponseEntity.ok(enrollment);
    }

    @GetMapping("/student/{studentId}")
    public ResponseEntity<List<EnrollmentResponse>> getStudentEnrollments(@PathVariable Long studentId) {
        List<EnrollmentResponse> enrollments = enrollmentService.getStudentEnrollments(studentId);
        return ResponseEntity.ok(enrollments);
    }

    @GetMapping("/course/{courseId}")
    public ResponseEntity<List<EnrollmentResponse>> getCourseEnrollments(@PathVariable Long courseId) {
        List<EnrollmentResponse> enrollments = enrollmentService.getCourseEnrollments(courseId);
        return ResponseEntity.ok(enrollments);
    }

    @PutMapping("/{id}/grade")
    public ResponseEntity<EnrollmentResponse> updateGrade(@PathVariable Long id,
            @Valid @RequestBody GradeUpdateRequest request) {
        EnrollmentResponse response = enrollmentService.updateGrade(id, request.getGrade());
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> dropCourse(@PathVariable Long id) {
        enrollmentService.dropCourse(id);
        return ResponseEntity.noContent().build();
    }
}
