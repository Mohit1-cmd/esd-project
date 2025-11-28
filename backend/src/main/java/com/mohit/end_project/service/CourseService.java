package com.mohit.end_project.service;

import com.mohit.end_project.dto.CourseRequest;
import com.mohit.end_project.dto.CourseResponse;
import com.mohit.end_project.entity.Course;
import com.mohit.end_project.repository.CourseRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class CourseService {

    private final CourseRepository courseRepository;

    public CourseService(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    public CourseResponse createCourse(CourseRequest request) {
        // Check for duplicate course code
        if (courseRepository.findByCourseCode(request.getCourseCode()).isPresent()) {
            throw new RuntimeException("Course with code " + request.getCourseCode() + " already exists");
        }

        Course course = new Course();
        course.setCourseCode(request.getCourseCode());
        course.setCourseName(request.getCourseName());
        course.setDescription(request.getDescription());
        course.setCredits(request.getCredits());

        Course saved = courseRepository.save(course);
        return mapToResponse(saved);
    }

    @Transactional(readOnly = true)
    public List<CourseResponse> getAllCourses() {
        return courseRepository.findAll().stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public CourseResponse getCourseById(Long id) {
        Course course = courseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Course not found with id: " + id));
        return mapToResponse(course);
    }

    @Transactional(readOnly = true)
    public CourseResponse getCourseByCourseCode(String courseCode) {
        Course course = courseRepository.findByCourseCode(courseCode)
                .orElseThrow(() -> new RuntimeException("Course not found with code: " + courseCode));
        return mapToResponse(course);
    }

    public CourseResponse updateCourse(Long id, CourseRequest request) {
        Course course = courseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Course not found with id: " + id));

        // Check for duplicate course code (if changed)
        if (!course.getCourseCode().equals(request.getCourseCode())) {
            if (courseRepository.findByCourseCode(request.getCourseCode()).isPresent()) {
                throw new RuntimeException("Course with code " + request.getCourseCode() + " already exists");
            }
        }

        course.setCourseCode(request.getCourseCode());
        course.setCourseName(request.getCourseName());
        course.setDescription(request.getDescription());
        course.setCredits(request.getCredits());

        Course updated = courseRepository.save(course);
        return mapToResponse(updated);
    }

    public void deleteCourse(Long id) {
        if (!courseRepository.existsById(id)) {
            throw new RuntimeException("Course not found with id: " + id);
        }
        courseRepository.deleteById(id);
    }

    private CourseResponse mapToResponse(Course course) {
        CourseResponse response = new CourseResponse();
        response.setCourseId(course.getCourseId());
        response.setCourseCode(course.getCourseCode());
        response.setCourseName(course.getCourseName());
        response.setDescription(course.getDescription());
        response.setCredits(course.getCredits());
        return response;
    }
}
