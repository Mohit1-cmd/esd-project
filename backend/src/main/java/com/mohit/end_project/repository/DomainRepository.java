package com.mohit.end_project.repository;

import com.mohit.end_project.entity.Domain;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface DomainRepository extends JpaRepository<Domain, Long> {
    Optional<Domain> findByDomainName(String domainName);
}
