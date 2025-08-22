# Logistics Application

Currently developing a full-stack logistics management application with a Flutter frontend and a Java (Spring Boot) backend. The platform aims to let sellers create and track shipments, while enabling company employees to manage orders.

## 🏛️ Project Architecture

The application is built using a modern, scalable architecture designed for maintainability and performance.

-   **Frontend:** A cross-platform mobile application developed using **Flutter**. It provides a reactive and user-friendly interface for both sellers and employees.
    
-   **Backend:** A robust RESTful API server built with **Java** and the **Spring Boot** framework. It handles all business logic, data processing, and authentication.
    
-   **Database:** A **PostgreSQL** relational database is used for persistent data storage, managing users, packages, and invoices.
    
-   **Authentication:** The API is secured using **JSON Web Tokens (JWT)** to ensure that all endpoints are protected and that users can only access data relevant to their roles.
    

## 📁 Folder & File Structure

The project is organized into two main parts: the backend server and the frontend mobile application.

### **`logistics/` (Java Spring Boot)**

```
/logistics
└── src
    └── main
        ├── java
        │   └── com
        │       └── example
        │           └── logistics
        │               ├── controller/      # API Endpoints (Handles HTTP requests)
        │               │   ├── AuthController.java
        │               │   ├── SellerController.java
        │               │   └── EmployeeController.java
        │               ├── dto/             # Data Transfer Objects (Defines API request/response shapes)
        │               │   ├── PackageRequestDto.java
        │               │   └── PackageResponseDto.java
        │               ├── model/           # JPA Entities (Maps to database tables)
        │               │   ├── User.java
        │               │   ├── Package.java
        │               │   └── Invoice.java
        │               ├── repository/      # Data Access Layer (Interfaces with the database)
        │               │   ├── UserRepository.java
        │               │   └── PackageRepository.java
        │               ├── security/        # JWT & Spring Security Configuration
        │               │   ├── JwtUtil.java
        │               │   └── SecurityConfig.java
        │               └── service/         # Business Logic Layer
        │                   ├── MyUserDetailsService.java
        │                   ├── SellerService.java
        │                   └── EmployeeService.java
        └── resources
            └── application.properties       # Configuration for database, server, JWT secret

```

### **`bs/` (Flutter)**

```
/bs
├── android/                     # Android specific files
├── ios/                         # iOS specific files
├── lib/
│   ├── main.dart                # Main application entry point
│   ├── models/                  # Dart classes for data structures
│   │   ├── package.dart
│   │   └── user.dart
│   ├── screens/                 # UI Widgets for each screen
│   │   ├── common/
│   │   │   ├── login_screen.dart
│   │   │   └── profile_screen.dart
│   │   ├── employee/
│   │   │   ├── employee_home_screen.dart
│   │   │   ├── receive_orders_screen.dart
│   │   │   └── create_invoice_screen.dart
│   │   └── seller/
│   │       ├── seller_home_screen.dart
│   │       ├── order_logistics_screen.dart
│   │       └── package_tracking_screen.dart
│   └── services/                # Handles API calls and state management
│       ├── auth_service.dart
│       └── package_service.dart
├── assets/                      # For static assets like images
│   └── bs.JPG
└── pubspec.yaml                 # Project dependencies and asset registration

```

## ✨ Key Features

### **General**

-   Secure user login with role-based access.
    
-   User profile management.
    
-   Session persistence and logout functionality.
    

### **Seller Role**

-   **Order Logistics:** A detailed form to create a new package shipment with weight, size, and client details.
    
-   **Automated Pricing:** The shipping price is automatically calculated by the backend based on package dimensions and weight.
    
-   **Real-time Tracking:** Sellers can track the current status and location of their packages.
    

### **Employee Role**

-   **Receive Orders:** View a list of all pending package orders submitted by sellers.
    
-   **Invoice Generation:** Create and finalize invoices for shipments based on the seller's order details.