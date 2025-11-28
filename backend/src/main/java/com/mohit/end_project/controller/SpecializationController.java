package com.mohit.end_project.controller;

import com.mohit.end_project.dto.SpecializationRequest;
import com.mohit.end_project.dto.StudentSpecializationDTO;
import com.mohit.end_project.entity.CourseSpecialization;
import com.mohit.end_project.entity.Domain;
import com.mohit.end_project.entity.Specialization;
import com.mohit.end_project.repository.CourseSpecializationRepository;
import com.mohit.end_project.repository.DomainRepository;
import com.mohit.end_project.repository.SpecializationRepository;
import com.mohit.end_project.service.SpecializationService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/specializations")
public class SpecializationController {

    private final SpecializationRepository specializationRepository;
    private final DomainRepository domainRepository;
    private final SpecializationService specializationService;
    private final CourseSpecializationRepository courseSpecializationRepository;

    public SpecializationController(SpecializationRepository specializationRepository,
            DomainRepository domainRepository,
            SpecializationService specializationService,
            CourseSpecializationRepository courseSpecializationRepository) {
        this.specializationRepository = specializationRepository;
        this.domainRepository = domainRepository;
        this.specializationService = specializationService;
        this.courseSpecializationRepository = courseSpecializationRepository;
    }

    @PostMapping
    public ResponseEntity<Specialization> createSpecialization(@Valid @RequestBody SpecializationRequest request) {
        Domain domain = domainRepository.findById(request.getDomainId())
                .orElseThrow(() -> new RuntimeException("Domain not found with id: " + request.getDomainId()));

        Specialization specialization = new Specialization();
        specialization.setDomain(domain);
        specialization.setSpecializationName(request.getSpecializationName());
        specialization.setDescription(request.getDescription());

        Specialization saved = specializationRepository.save(specialization);
        return ResponseEntity.status(HttpStatus.CREATED).body(saved);
    }

    @GetMapping
    public ResponseEntity<List<Specialization>> getAllSpecializations(
            @RequestParam(required = false) Long domainId) {
        List<Specialization> specializations;
        if (domainId != null) {
            specializations = specializationRepository.findByDomain_DomainId(domainId);
        } else {
            specializations = specializationRepository.findAll();
        }
        return ResponseEntity.ok(specializations);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Specialization> getSpecializationById(@PathVariable Long id) {
        Specialization specialization = specializationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Specialization not found with id: " + id));
        return ResponseEntity.ok(specialization);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Specialization> updateSpecialization(@PathVariable Long id,
            @Valid @RequestBody SpecializationRequest request) {
        Specialization specialization = specializationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Specialization not found with id: " + id));

        Domain domain = domainRepository.findById(request.getDomainId())
                .orElseThrow(() -> new RuntimeException("Domain not found with id: " + request.getDomainId()));

        specialization.setDomain(domain);
        specialization.setSpecializationName(request.getSpecializationName());
        specialization.setDescription(request.getDescription());

        Specialization updated = specializationRepository.save(specialization);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSpecialization(@PathVariable Long id) {
        if (!specializationRepository.existsById(id)) {
            throw new RuntimeException("Specialization not found with id: " + id);
        }
        specializationRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}/students")
    public ResponseEntity<List<StudentSpecializationDTO>> getStudentsWithSpecialization(@PathVariable Long id) {
        List<StudentSpecializationDTO> students = specializationService.getStudentsBySpecialization(id);
        return ResponseEntity.ok(students);
    }

    @GetMapping("/{id}/courses")
    public ResponseEntity<List<CourseSpecialization>> getSpecializationCourses(@PathVariable Long id) {
        List<CourseSpecialization> courses = courseSpecializationRepository
                .findBySpecialization_SpecializationId(id);
        return ResponseEntity.ok(courses);
    }
}
