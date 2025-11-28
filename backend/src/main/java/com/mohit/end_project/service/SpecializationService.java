package com.mohit.end_project.service;

import com.mohit.end_project.dto.StudentSpecializationDTO;
import com.mohit.end_project.entity.*;
import com.mohit.end_project.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
public class SpecializationService {

    private final StudentRepository studentRepository;
    private final SpecializationRepository specializationRepository;
    private final StudentCourseRepository studentCourseRepository;
    private final CourseSpecializationRepository courseSpecializationRepository;
    private final DomainRepository domainRepository;

    public SpecializationService(StudentRepository studentRepository,
            SpecializationRepository specializationRepository,
            StudentCourseRepository studentCourseRepository,
            CourseSpecializationRepository courseSpecializationRepository,
            DomainRepository domainRepository) {
        this.studentRepository = studentRepository;
        this.specializationRepository = specializationRepository;
        this.studentCourseRepository = studentCourseRepository;
        this.courseSpecializationRepository = courseSpecializationRepository;
        this.domainRepository = domainRepository;
    }

    /**
     * Compute all student specializations across all students
     * A student has a specialization if cumulative credits > 20
     */
    public List<StudentSpecializationDTO> getAllStudentSpecializations() {
        List<Student> students = studentRepository.findAll();
        List<Specialization> specializations = specializationRepository.findAll();

        List<StudentSpecializationDTO> results = new ArrayList<>();

        for (Student student : students) {
            for (Specialization specialization : specializations) {
                int credits = computeCreditsForStudentInSpecialization(student.getStudentId(),
                        specialization.getSpecializationId());

                if (credits >= 20) {
                    StudentSpecializationDTO dto = new StudentSpecializationDTO();
                    dto.setStudentId(student.getStudentId());
                    dto.setRollNumber(student.getRollNumber());
                    dto.setFirstName(student.getFirstName());
                    dto.setLastName(student.getLastName());
                    dto.setEmail(student.getEmail());
                    dto.setSpecializationId(specialization.getSpecializationId());
                    dto.setSpecializationName(specialization.getSpecializationName());
                    dto.setDomainName(specialization.getDomain().getDomainName());
                    dto.setTotalCredits(credits);
                    dto.setHasSpecialization(true);

                    results.add(dto);
                }
            }
        }

        return results;
    }

    /**
     * Get specializations for a specific student
     */
    public List<StudentSpecializationDTO> getStudentSpecializations(Long studentId) {
        Student student = studentRepository.findById(studentId)
                .orElseThrow(() -> new RuntimeException("Student not found"));

        List<Specialization> specializations = specializationRepository.findAll();
        List<StudentSpecializationDTO> results = new ArrayList<>();

        for (Specialization specialization : specializations) {
            int credits = computeCreditsForStudentInSpecialization(studentId,
                    specialization.getSpecializationId());

            StudentSpecializationDTO dto = new StudentSpecializationDTO();
            dto.setStudentId(student.getStudentId());
            dto.setRollNumber(student.getRollNumber());
            dto.setFirstName(student.getFirstName());
            dto.setLastName(student.getLastName());
            dto.setEmail(student.getEmail());
            dto.setSpecializationId(specialization.getSpecializationId());
            dto.setSpecializationName(specialization.getSpecializationName());
            dto.setDomainName(specialization.getDomain().getDomainName());
            dto.setTotalCredits(credits);
            dto.setHasSpecialization(credits >= 20);

            results.add(dto);
        }

        return results.stream()
                .filter(StudentSpecializationDTO::getHasSpecialization)
                .collect(Collectors.toList());
    }

    /**
     * Filter specializations by domain
     */
    public List<StudentSpecializationDTO> getSpecializationsByDomain(String domainName) {
        Domain domain = domainRepository.findByDomainName(domainName)
                .orElseThrow(() -> new RuntimeException("Domain not found"));

        List<Specialization> specializations = specializationRepository
                .findByDomain_DomainId(domain.getDomainId());

        List<Student> students = studentRepository.findAll();
        List<StudentSpecializationDTO> results = new ArrayList<>();

        for (Student student : students) {
            for (Specialization specialization : specializations) {
                int credits = computeCreditsForStudentInSpecialization(student.getStudentId(),
                        specialization.getSpecializationId());

                if (credits >= 20) {
                    StudentSpecializationDTO dto = new StudentSpecializationDTO();
                    dto.setStudentId(student.getStudentId());
                    dto.setRollNumber(student.getRollNumber());
                    dto.setFirstName(student.getFirstName());
                    dto.setLastName(student.getLastName());
                    dto.setEmail(student.getEmail());
                    dto.setSpecializationId(specialization.getSpecializationId());
                    dto.setSpecializationName(specialization.getSpecializationName());
                    dto.setDomainName(specialization.getDomain().getDomainName());
                    dto.setTotalCredits(credits);
                    dto.setHasSpecialization(true);

                    results.add(dto);
                }
            }
        }

        return results;
    }

    /**
     * Filter by specific specialization
     */
    public List<StudentSpecializationDTO> getStudentsBySpecialization(Long specializationId) {
        Specialization specialization = specializationRepository.findById(specializationId)
                .orElseThrow(() -> new RuntimeException("Specialization not found"));

        List<Student> students = studentRepository.findAll();
        List<StudentSpecializationDTO> results = new ArrayList<>();

        for (Student student : students) {
            int credits = computeCreditsForStudentInSpecialization(student.getStudentId(),
                    specializationId);

            if (credits >= 20) {
                StudentSpecializationDTO dto = new StudentSpecializationDTO();
                dto.setStudentId(student.getStudentId());
                dto.setRollNumber(student.getRollNumber());
                dto.setFirstName(student.getFirstName());
                dto.setLastName(student.getLastName());
                dto.setEmail(student.getEmail());
                dto.setSpecializationId(specialization.getSpecializationId());
                dto.setSpecializationName(specialization.getSpecializationName());
                dto.setDomainName(specialization.getDomain().getDomainName());
                dto.setTotalCredits(credits);
                dto.setHasSpecialization(true);

                results.add(dto);
            }
        }

        return results;
    }

    /**
     * Core computation: Calculate total credits for a student in a specific
     * specialization
     */
    private int computeCreditsForStudentInSpecialization(Long studentId, Long specializationId) {
        // Get all courses the student has taken
        List<StudentCourse> studentCourses = studentCourseRepository
                .findByStudent_StudentId(studentId);

        int totalCredits = 0;

        for (StudentCourse sc : studentCourses) {
            // Get course-specialization mappings for this course
            List<CourseSpecialization> courseSpecs = courseSpecializationRepository
                    .findByCourseId(sc.getCourse().getCourseId());

            // Check if any mapping matches our specialization
            for (CourseSpecialization cs : courseSpecs) {
                if (cs.getSpecialization().getSpecializationId().equals(specializationId)) {
                    totalCredits += cs.getCreditsTowardSpecialization();
                    break;
                }
            }
        }

        return totalCredits;
    }
}
