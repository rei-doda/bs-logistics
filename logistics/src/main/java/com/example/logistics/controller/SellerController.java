package com.example.logistics.controller;

import com.example.logistics.dto.*;
import com.example.logistics.model.*;
import com.example.logistics.repository.UserRepository;
import com.example.logistics.security.JwtUtil;
import com.example.logistics.service.EmployeeService;
import com.example.logistics.service.SellerService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/seller")
public class SellerController {
    private final SellerService sellerService;
    public SellerController(SellerService sellerService) { this.sellerService = sellerService; }

    @PostMapping("/packages")
    public ResponseEntity<PackageResponseDto> createPackage(@Valid @RequestBody PackageRequestDto packageDto, Authentication authentication) {
        Package createdPackage = sellerService.createPackage(packageDto, authentication.getName());
        PackageResponseDto response = new PackageResponseDto(createdPackage.getId(), createdPackage.getSeller().getId(), createdPackage.getPrice(), createdPackage.getStatus().name());
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @GetMapping("/packages/{id}/location")
    public ResponseEntity<?> getPackageLocation(@PathVariable String id) {
        return ResponseEntity.ok(java.util.Map.of("lat", 40.7128, "lng", -74.0060, "lastUpdate", "2025-08-22T23:27:00Z"));
    }
}