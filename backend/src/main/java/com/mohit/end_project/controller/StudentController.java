package com.mohit.end_project.controller;

import com.mohit.end_project.dto.StudentRequest;
import com.mohit.end_project.dto.StudentResponse;
import com.mohit.end_project.dto.StudentSpecializationDTO;
import com.mohit.end_project.dto.EnrollmentResponse;
import com.mohit.end_project.service.StudentService;
import com.mohit.end_project.service.SpecializationService;
import com.mohit.end_project.service.EnrollmentService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/students")
public class StudentController {

    private final StudentService studentService;
    private final SpecializationService specializationService;
    private final EnrollmentService enrollmentService;

    public StudentController(StudentService studentService,
            SpecializationService specializationService,
            EnrollmentService enrollmentService) {
        this.studentService = studentService;
        this.specializationService = specializationService;
        this.enrollmentService = enrollmentService;
    }

    @PostMapping
    public ResponseEntity<StudentResponse> createStudent(@Valid @RequestBody StudentRequest request) {
        StudentResponse response = studentService.createStudent(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping
    public ResponseEntity<List<StudentResponse>> getAllStudents() {
        List<StudentResponse> students = studentService.getAllStudents();
        return ResponseEntity.ok(students);
    }

    @GetMapping("/{id}")
    public ResponseEntity<StudentResponse> getStudentById(@PathVariable Long id) {
        StudentResponse student = studentService.getStudentById(id);
        return ResponseEntity.ok(student);
    }

    @GetMapping("/roll/{rollNumber}")
    public ResponseEntity<StudentResponse> getStudentByRollNumber(@PathVariable String rollNumber) {
        StudentResponse student = studentService.getStudentByRollNumber(rollNumber);
        return ResponseEntity.ok(student);
    }

    @PutMapping("/{id}")
    public ResponseEntity<StudentResponse> updateStudent(@PathVariable Long id,
            @Valid @RequestBody StudentRequest request) {
        StudentResponse response = studentService.updateStudent(id, request);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteStudent(@PathVariable Long id) {
        studentService.deleteStudent(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}/courses")
    public ResponseEntity<List<EnrollmentResponse>> getStudentCourses(@PathVariable Long id) {
        List<EnrollmentResponse> enrollments = enrollmentService.getStudentEnrollments(id);
        return ResponseEntity.ok(enrollments);
    }

    @GetMapping("/{id}/specializations")
    public ResponseEntity<List<StudentSpecializationDTO>> getStudentSpecializations(@PathVariable Long id) {
        List<StudentSpecializationDTO> specializations = specializationService.getStudentSpecializations(id);
        return ResponseEntity.ok(specializations);
    }
}
