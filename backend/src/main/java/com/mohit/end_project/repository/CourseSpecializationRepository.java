package com.mohit.end_project.repository;

import com.mohit.end_project.entity.CourseSpecialization;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CourseSpecializationRepository extends JpaRepository<CourseSpecialization, Long> {

    List<CourseSpecialization> findBySpecialization_SpecializationId(Long specializationId);

    @Query("SELECT cs FROM CourseSpecialization cs WHERE cs.course.courseId = :courseId")
    List<CourseSpecialization> findByCourseId(@Param("courseId") Long courseId);
}
