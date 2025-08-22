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
public class EmployeeService {
    private final PackageRepository packageRepository;
    private final InvoiceRepository invoiceRepository;
    private final UserRepository userRepository;

    public EmployeeService(PackageRepository packageRepository, InvoiceRepository invoiceRepository, UserRepository userRepository) {
        this.packageRepository = packageRepository;
        this.invoiceRepository = invoiceRepository;
        this.userRepository = userRepository;
    }

    public List<Package> getPendingPackages() {
        return packageRepository.findByStatus(PackageStatus.PENDING);
    }

    @Transactional
    public Invoice createInvoice(UUID packageId, String employeeEmail) {
        User employee = userRepository.findByEmail(employeeEmail).orElseThrow(() -> new UsernameNotFoundException("Employee not found"));
        Package aPackage = packageRepository.findById(packageId).orElseThrow(() -> new RuntimeException("Package not found"));

        Invoice newInvoice = new Invoice();
        newInvoice.setAPackage(aPackage);
        newInvoice.setEmployee(employee);
        newInvoice.setTotalAmount(aPackage.getPrice());
        newInvoice.setInvoiceNumber("INV-" + aPackage.getId().toString().substring(0, 8).toUpperCase());
        
        return invoiceRepository.save(newInvoice);
    }
}
