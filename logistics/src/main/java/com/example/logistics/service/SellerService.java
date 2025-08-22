package com.example.logistics.service;

import com.example.logistics.dto.*;
import com.example.logistics.model.*;
import com.example.logistics.repository.*;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class SellerService {
    private final PackageRepository packageRepository;
    private final UserRepository userRepository;

    public SellerService(PackageRepository packageRepository, UserRepository userRepository) {
        this.packageRepository = packageRepository;
        this.userRepository = userRepository;
    }

    @Transactional
    public Package createPackage(PackageRequestDto dto, String sellerEmail) {
        User seller = userRepository.findByEmail(sellerEmail).orElseThrow(() -> new UsernameNotFoundException("Seller not found"));
        Package newPackage = new Package();
        newPackage.setSeller(seller);
        newPackage.setWeightKg(dto.weightKg());
        newPackage.setSizeWidthCm(dto.sizeWidthCm());
        newPackage.setSizeHeightCm(dto.sizeHeightCm());
        newPackage.setSizeDepthCm(dto.sizeDepthCm());
        newPackage.setClientName(dto.clientName());
        newPackage.setClientAddress(dto.clientAddress());
        newPackage.setClientPhone(dto.clientPhone());
        newPackage.setPickupDate(dto.pickupDate());
        newPackage.setPrice(calculatePrice(dto.weightKg(), dto.sizeWidthCm(), dto.sizeHeightCm(), dto.sizeDepthCm()));
        newPackage.setStatus(PackageStatus.PENDING);
        return packageRepository.save(newPackage);
    }
    private double calculatePrice(double weight, double width, double height, double depth) {
        double volume = width * height * depth;
        return 5.0 + (weight * 2.0) + (volume * 0.01);
    }
}
