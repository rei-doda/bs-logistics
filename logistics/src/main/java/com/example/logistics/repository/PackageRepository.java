package com.example.logistics.repository;

import com.example.logistics.model.*;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface PackageRepository extends JpaRepository<Package, UUID> {
    List<Package> findByStatus(PackageStatus status);
}