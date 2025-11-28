package com.mohit.end_project.controller;

import com.mohit.end_project.dto.StudentSpecializationDTO;
import com.mohit.end_project.entity.Domain;
import com.mohit.end_project.entity.Specialization;
import com.mohit.end_project.repository.DomainRepository;
import com.mohit.end_project.repository.SpecializationRepository;
import com.mohit.end_project.service.SpecializationService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    private final SpecializationService specializationService;
    private final DomainRepository domainRepository;
    private final SpecializationRepository specializationRepository;

    public AdminController(SpecializationService specializationService,
            DomainRepository domainRepository,
            SpecializationRepository specializationRepository) {
        this.specializationService = specializationService;
        this.domainRepository = domainRepository;
        this.specializationRepository = specializationRepository;
    }

    /**
     * GET /api/admin/students/specializations
     * Get all students with their specializations (credits > 20)
     * Query params: domain (optional), specializationId (optional)
     */
    @GetMapping("/students/specializations")
    public ResponseEntity<List<StudentSpecializationDTO>> getStudentSpecializations(
            @RequestParam(required = false) String domain,
            @RequestParam(required = false) Long specializationId) {

        if (specializationId != null) {
            return ResponseEntity.ok(specializationService.getStudentsBySpecialization(specializationId));
        } else if (domain != null) {
            return ResponseEntity.ok(specializationService.getSpecializationsByDomain(domain));
        } else {
            return ResponseEntity.ok(specializationService.getAllStudentSpecializations());
        }
    }

    /**
     * GET /api/admin/students/{id}/specializations
     * Get specializations for a specific student
     */
    @GetMapping("/students/{id}/specializations")
    public ResponseEntity<List<StudentSpecializationDTO>> getStudentSpecializationsById(@PathVariable Long id) {
        return ResponseEntity.ok(specializationService.getStudentSpecializations(id));
    }

    /**
     * GET /api/admin/domains
     * Get all domains
     */
    @GetMapping("/domains")
    public ResponseEntity<List<Domain>> getAllDomains() {
        return ResponseEntity.ok(domainRepository.findAll());
    }

    /**
     * GET /api/admin/specializations
     * Get all specializations, optionally filtered by domain
     */
    @GetMapping("/specializations")
    public ResponseEntity<List<Specialization>> getAllSpecializations(
            @RequestParam(required = false) Long domainId) {

        if (domainId != null) {
            return ResponseEntity.ok(specializationRepository.findByDomain_DomainId(domainId));
        } else {
            return ResponseEntity.ok(specializationRepository.findAll());
        }
    }
}
