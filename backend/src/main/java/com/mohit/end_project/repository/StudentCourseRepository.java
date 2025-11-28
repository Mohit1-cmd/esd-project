package com.mohit.end_project.repository;

import com.mohit.end_project.entity.StudentCourse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentCourseRepository extends JpaRepository<StudentCourse, Long> {

    List<StudentCourse> findByStudent_StudentId(Long studentId);

    @Query("SELECT sc FROM StudentCourse sc WHERE sc.student.studentId = :studentId")
    List<StudentCourse> findStudentCoursesByStudentId(@Param("studentId") Long studentId);
}
