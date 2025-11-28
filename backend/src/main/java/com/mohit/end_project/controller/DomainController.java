package com.mohit.end_project.controller;

import com.mohit.end_project.dto.DomainRequest;
import com.mohit.end_project.entity.Domain;
import com.mohit.end_project.entity.Specialization;
import com.mohit.end_project.repository.SpecializationRepository;
import com.mohit.end_project.service.DomainService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/domains")
public class DomainController {

    private final DomainService domainService;
    private final SpecializationRepository specializationRepository;

    public DomainController(DomainService domainService,
            SpecializationRepository specializationRepository) {
        this.domainService = domainService;
        this.specializationRepository = specializationRepository;
    }

    @PostMapping
    public ResponseEntity<Domain> createDomain(@Valid @RequestBody DomainRequest request) {
        Domain domain = domainService.createDomain(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(domain);
    }

    @GetMapping
    public ResponseEntity<List<Domain>> getAllDomains() {
        List<Domain> domains = domainService.getAllDomains();
        return ResponseEntity.ok(domains);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Domain> getDomainById(@PathVariable Long id) {
        Domain domain = domainService.getDomainById(id);
        return ResponseEntity.ok(domain);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Domain> updateDomain(@PathVariable Long id,
            @Valid @RequestBody DomainRequest request) {
        Domain domain = domainService.updateDomain(id, request);
        return ResponseEntity.ok(domain);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDomain(@PathVariable Long id) {
        domainService.deleteDomain(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}/specializations")
    public ResponseEntity<List<Specialization>> getDomainSpecializations(@PathVariable Long id) {
        List<Specialization> specializations = specializationRepository.findByDomain_DomainId(id);
        return ResponseEntity.ok(specializations);
    }
}
