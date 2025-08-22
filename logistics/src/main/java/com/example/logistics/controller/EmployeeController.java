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
@RequestMapping("/api/employee")
public class EmployeeController {
    private final EmployeeService employeeService;
    public EmployeeController(EmployeeService employeeService) { this.employeeService = employeeService; }

    @GetMapping("/packages/pending")
    public ResponseEntity<List<PackageResponseDto>> getPendingPackages() {
        List<Package> packages = employeeService.getPendingPackages();
        List<PackageResponseDto> response = packages.stream()
            .map(p -> new PackageResponseDto(p.getId(), p.getSeller().getId(), p.getPrice(), p.getStatus().name()))
            .collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }

    @PostMapping("/invoices")
    public ResponseEntity<InvoiceResponseDto> createInvoice(@Valid @RequestBody InvoiceRequestDto invoiceDto, Authentication authentication) {
        Invoice createdInvoice = employeeService.createInvoice(invoiceDto.packageId(), authentication.getName());
        InvoiceResponseDto response = new InvoiceResponseDto(createdInvoice.getId(), createdInvoice.getInvoiceNumber(), createdInvoice.getIssueDate(), createdInvoice.getTotalAmount(), createdInvoice.getAPackage().getId());
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }
}
