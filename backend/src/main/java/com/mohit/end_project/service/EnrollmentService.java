package com.mohit.end_project.service;

import com.mohit.end_project.dto.EnrollmentRequest;
import com.mohit.end_project.dto.EnrollmentResponse;
import com.mohit.end_project.entity.Course;
import com.mohit.end_project.entity.Student;
import com.mohit.end_project.entity.StudentCourse;
import com.mohit.end_project.repository.CourseRepository;
import com.mohit.end_project.repository.StudentCourseRepository;
import com.mohit.end_project.repository.StudentRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class EnrollmentService {

    private final StudentCourseRepository studentCourseRepository;
    private final StudentRepository studentRepository;
    private final CourseRepository courseRepository;

    public EnrollmentService(StudentCourseRepository studentCourseRepository,
            StudentRepository studentRepository,
            CourseRepository courseRepository) {
        this.studentCourseRepository = studentCourseRepository;
        this.studentRepository = studentRepository;
        this.courseRepository = courseRepository;
    }

    public EnrollmentResponse enrollStudent(EnrollmentRequest request) {
        Student student = studentRepository.findById(request.getStudentId())
                .orElseThrow(() -> new RuntimeException("Student not found with id: " + request.getStudentId()));

        Course course = courseRepository.findById(request.getCourseId())
                .orElseThrow(() -> new RuntimeException("Course not found with id: " + request.getCourseId()));

        StudentCourse enrollment = new StudentCourse();
        enrollment.setStudent(student);
        enrollment.setCourse(course);
        enrollment.setAcademicYear(request.getAcademicYear());
        enrollment.setSemester(request.getSemester());
        enrollment.setGrade(request.getGrade());

        StudentCourse saved = studentCourseRepository.save(enrollment);
        return mapToResponse(saved);
    }

    @Transactional(readOnly = true)
    public List<EnrollmentResponse> getAllEnrollments() {
        return studentCourseRepository.findAll().stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public EnrollmentResponse getEnrollmentById(Long id) {
        StudentCourse enrollment = studentCourseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Enrollment not found with id: " + id));
        return mapToResponse(enrollment);
    }

    @Transactional(readOnly = true)
    public List<EnrollmentResponse> getStudentEnrollments(Long studentId) {
        return studentCourseRepository.findByStudent_StudentId(studentId).stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<EnrollmentResponse> getCourseEnrollments(Long courseId) {
        List<StudentCourse> enrollments = studentCourseRepository.findAll().stream()
                .filter(sc -> sc.getCourse().getCourseId().equals(courseId))
                .collect(Collectors.toList());
        return enrollments.stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    public EnrollmentResponse updateGrade(Long enrollmentId, String grade) {
        StudentCourse enrollment = studentCourseRepository.findById(enrollmentId)
                .orElseThrow(() -> new RuntimeException("Enrollment not found with id: " + enrollmentId));

        enrollment.setGrade(grade);
        StudentCourse updated = studentCourseRepository.save(enrollment);
        return mapToResponse(updated);
    }

    public void dropCourse(Long enrollmentId) {
        if (!studentCourseRepository.existsById(enrollmentId)) {
            throw new RuntimeException("Enrollment not found with id: " + enrollmentId);
        }
        studentCourseRepository.deleteById(enrollmentId);
    }

    private EnrollmentResponse mapToResponse(StudentCourse sc) {
        EnrollmentResponse response = new EnrollmentResponse();
        response.setId(sc.getId());
        response.setStudentId(sc.getStudent().getStudentId());
        response.setStudentName(sc.getStudent().getFirstName() + " " + sc.getStudent().getLastName());
        response.setCourseId(sc.getCourse().getCourseId());
        response.setCourseName(sc.getCourse().getCourseName());
        response.setCourseCode(sc.getCourse().getCourseCode());
        response.setAcademicYear(sc.getAcademicYear());
        response.setSemester(sc.getSemester());
        response.setGrade(sc.getGrade());
        return response;
    }
}
