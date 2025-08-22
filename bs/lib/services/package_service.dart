import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/package.dart';

// FIX: Added 'with ChangeNotifier' to make this class compatible with ChangeNotifierProxyProvider
class PackageService with ChangeNotifier {
  final String? authToken;
  final String? userId;

  PackageService(this.authToken, this.userId);

  final String _baseUrl = 'http://localhost:8080/api';

  Future<Map<String, dynamic>> createPackage(Package package) async {
    if (authToken == null) throw Exception('Not authenticated');
    final url = Uri.parse('$_baseUrl/seller/packages');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: json.encode(package.toJson()),
    );
    final responseData = json.decode(response.body);
    if (response.statusCode != 201) {
      throw Exception(responseData['message'] ?? 'Failed to create package');
    }
    return responseData;
  }

  // Placeholder for tracking
  Future<Package> trackPackage(String packageId) async {
    // This would fetch package details from the backend
    await Future.delayed(const Duration(seconds: 1)); // Simulate network call
    return Package(
      id: packageId,
      weightKg: 5,
      sizeWidthCm: 20,
      sizeHeightCm: 20,
      sizeDepthCm: 20,
      clientName: "Jane Doe",
      clientAddress: "123 Main St",
      clientPhone: "555-1234",
      pickupDate: DateTime.now(),
      price: 25.50,
      status: 'IN_TRANSIT',
    );
  }

  // Placeholder for employee fetching orders
  Future<List<Package>> fetchPendingOrders() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Package(
        id: 'pkg123',
        weightKg: 2,
        sizeWidthCm: 10,
        sizeHeightCm: 10,
        sizeDepthCm: 10,
        clientName: "John Smith",
        clientAddress: "456 Oak Ave",
        clientPhone: "555-5678",
        pickupDate: DateTime.now().add(const Duration(days: 1)),
        price: 15.00,
        status: 'PENDING',
      ),
      Package(
        id: 'pkg456',
        weightKg: 10,
        sizeWidthCm: 30,
        sizeHeightCm: 30,
        sizeDepthCm: 30,
        clientName: "Emily White",
        clientAddress: "789 Pine Ln",
        clientPhone: "555-9012",
        pickupDate: DateTime.now().add(const Duration(days: 2)),
        price: 45.75,
        status: 'PENDING',
      ),
    ];
  }
}
