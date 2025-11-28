package com.mohit.end_project.service;

import com.mohit.end_project.dto.CourseSpecializationRequest;
import com.mohit.end_project.entity.Course;
import com.mohit.end_project.entity.CourseSpecialization;
import com.mohit.end_project.entity.Specialization;
import com.mohit.end_project.repository.CourseRepository;
import com.mohit.end_project.repository.CourseSpecializationRepository;
import com.mohit.end_project.repository.SpecializationRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CourseSpecializationService {

    private final CourseSpecializationRepository courseSpecializationRepository;
    private final CourseRepository courseRepository;
    private final SpecializationRepository specializationRepository;

    public CourseSpecializationService(CourseSpecializationRepository courseSpecializationRepository,
            CourseRepository courseRepository,
            SpecializationRepository specializationRepository) {
        this.courseSpecializationRepository = courseSpecializationRepository;
        this.courseRepository = courseRepository;
        this.specializationRepository = specializationRepository;
    }

    public CourseSpecialization mapCourseToSpecialization(CourseSpecializationRequest request) {
        Course course = courseRepository.findById(request.getCourseId())
                .orElseThrow(() -> new RuntimeException("Course not found with id: " + request.getCourseId()));

        Specialization specialization = specializationRepository.findById(request.getSpecializationId())
                .orElseThrow(() -> new RuntimeException(
                        "Specialization not found with id: " + request.getSpecializationId()));

        CourseSpecialization mapping = new CourseSpecialization();
        mapping.setCourse(course);
        mapping.setSpecialization(specialization);
        mapping.setCreditsTowardSpecialization(request.getCreditsTowardSpecialization());

        return courseSpecializationRepository.save(mapping);
    }

    @Transactional(readOnly = true)
    public List<CourseSpecialization> getCourseSpecializations(Long courseId) {
        return courseSpecializationRepository.findByCourseId(courseId);
    }

    public void removeCourseSpecializationMapping(Long courseId, Long specializationId) {
        List<CourseSpecialization> mappings = courseSpecializationRepository.findAll().stream()
                .filter(cs -> cs.getCourse().getCourseId().equals(courseId)
                        && cs.getSpecialization().getSpecializationId().equals(specializationId))
                .toList();

        if (mappings.isEmpty()) {
            throw new RuntimeException(
                    "Mapping not found for course " + courseId + " and specialization " + specializationId);
        }

        courseSpecializationRepository.deleteAll(mappings);
    }
}
