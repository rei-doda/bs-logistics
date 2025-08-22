package com.example.logistics.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "packages")
@Data
@NoArgsConstructor
public class Package {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "seller_id", nullable = false)
    private User seller;

    @Column(nullable = false)
    private Double weightKg;
    @Column(nullable = false)
    private Double sizeWidthCm;
    @Column(nullable = false)
    private Double sizeHeightCm;
    @Column(nullable = false)
    private Double sizeDepthCm;

    @Column(nullable = false)
    private String clientName;
    @Column(nullable = false)
    private String clientAddress;
    @Column(nullable = false)
    private String clientPhone;

    @Column(nullable = false)
    private LocalDate pickupDate;
    
    @Column(nullable = false)
    private Double price;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PackageStatus status;

    @Column(updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}

enum PackageStatus {
    PENDING, IN_TRANSIT, DELIVERED, CANCELED
}