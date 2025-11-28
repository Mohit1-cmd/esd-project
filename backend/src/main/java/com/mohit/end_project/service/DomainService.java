package com.mohit.end_project.service;

import com.mohit.end_project.dto.DomainRequest;
import com.mohit.end_project.entity.Domain;
import com.mohit.end_project.repository.DomainRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class DomainService {

    private final DomainRepository domainRepository;

    public DomainService(DomainRepository domainRepository) {
        this.domainRepository = domainRepository;
    }

    public Domain createDomain(DomainRequest request) {
        // Check for duplicate domain name
        if (domainRepository.findByDomainName(request.getDomainName()).isPresent()) {
            throw new RuntimeException("Domain with name " + request.getDomainName() + " already exists");
        }

        Domain domain = new Domain();
        domain.setDomainName(request.getDomainName());
        domain.setDescription(request.getDescription());

        return domainRepository.save(domain);
    }

    @Transactional(readOnly = true)
    public List<Domain> getAllDomains() {
        return domainRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Domain getDomainById(Long id) {
        return domainRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Domain not found with id: " + id));
    }

    public Domain updateDomain(Long id, DomainRequest request) {
        Domain domain = domainRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Domain not found with id: " + id));

        // Check for duplicate domain name (if changed)
        if (!domain.getDomainName().equals(request.getDomainName())) {
            if (domainRepository.findByDomainName(request.getDomainName()).isPresent()) {
                throw new RuntimeException("Domain with name " + request.getDomainName() + " already exists");
            }
        }

        domain.setDomainName(request.getDomainName());
        domain.setDescription(request.getDescription());

        return domainRepository.save(domain);
    }

    public void deleteDomain(Long id) {
        if (!domainRepository.existsById(id)) {
            throw new RuntimeException("Domain not found with id: " + id);
        }
        domainRepository.deleteById(id);
    }
}
