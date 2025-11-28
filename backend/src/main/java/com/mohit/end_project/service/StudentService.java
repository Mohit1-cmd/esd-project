package com.mohit.end_project.service;

import com.mohit.end_project.dto.StudentRequest;
import com.mohit.end_project.dto.StudentResponse;
import com.mohit.end_project.entity.Student;
import com.mohit.end_project.repository.StudentRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class StudentService {

    private final StudentRepository studentRepository;

    public StudentService(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    public StudentResponse createStudent(StudentRequest request) {
        // Check for duplicate roll number
        if (studentRepository.findByRollNumber(request.getRollNumber()).isPresent()) {
            throw new RuntimeException("Student with roll number " + request.getRollNumber() + " already exists");
        }

        // Check for duplicate email
        if (studentRepository.findByEmail(request.getEmail()).isPresent()) {
            throw new RuntimeException("Student with email " + request.getEmail() + " already exists");
        }

        Student student = new Student();
        student.setRollNumber(request.getRollNumber());
        student.setFirstName(request.getFirstName());
        student.setLastName(request.getLastName());
        student.setEmail(request.getEmail());
        student.setCgpa(request.getCgpa());
        student.setTotalCredits(request.getTotalCredits() != null ? request.getTotalCredits() : 0);
        student.setGraduationYear(request.getGraduationYear());

        Student saved = studentRepository.save(student);
        return mapToResponse(saved);
    }

    @Transactional(readOnly = true)
    public List<StudentResponse> getAllStudents() {
        return studentRepository.findAll().stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public StudentResponse getStudentById(Long id) {
        Student student = studentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Student not found with id: " + id));
        return mapToResponse(student);
    }

    @Transactional(readOnly = true)
    public StudentResponse getStudentByRollNumber(String rollNumber) {
        Student student = studentRepository.findByRollNumber(rollNumber)
                .orElseThrow(() -> new RuntimeException("Student not found with roll number: " + rollNumber));
        return mapToResponse(student);
    }

    public StudentResponse updateStudent(Long id, StudentRequest request) {
        Student student = studentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Student not found with id: " + id));

        // Check for duplicate roll number (if changed)
        if (!student.getRollNumber().equals(request.getRollNumber())) {
            if (studentRepository.findByRollNumber(request.getRollNumber()).isPresent()) {
                throw new RuntimeException("Student with roll number " + request.getRollNumber() + " already exists");
            }
        }

        // Check for duplicate email (if changed)
        if (!student.getEmail().equals(request.getEmail())) {
            if (studentRepository.findByEmail(request.getEmail()).isPresent()) {
                throw new RuntimeException("Student with email " + request.getEmail() + " already exists");
            }
        }

        student.setRollNumber(request.getRollNumber());
        student.setFirstName(request.getFirstName());
        student.setLastName(request.getLastName());
        student.setEmail(request.getEmail());
        student.setCgpa(request.getCgpa());
        student.setTotalCredits(
                request.getTotalCredits() != null ? request.getTotalCredits() : student.getTotalCredits());
        student.setGraduationYear(request.getGraduationYear());

        Student updated = studentRepository.save(student);
        return mapToResponse(updated);
    }

    public void deleteStudent(Long id) {
        if (!studentRepository.existsById(id)) {
            throw new RuntimeException("Student not found with id: " + id);
        }
        studentRepository.deleteById(id);
    }

    private StudentResponse mapToResponse(Student student) {
        StudentResponse response = new StudentResponse();
        response.setStudentId(student.getStudentId());
        response.setRollNumber(student.getRollNumber());
        response.setFirstName(student.getFirstName());
        response.setLastName(student.getLastName());
        response.setEmail(student.getEmail());
        response.setCgpa(student.getCgpa());
        response.setTotalCredits(student.getTotalCredits());
        response.setGraduationYear(student.getGraduationYear());
        return response;
    }
}
