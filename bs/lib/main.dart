import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/package_service.dart';
import 'screens/login_screen.dart';
import 'screens/seller/seller_home_screen.dart';
import 'screens/employee/employee_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        // PackageService depends on AuthService for the token
        ChangeNotifierProxyProvider<AuthService, PackageService>(
          create: (_) => PackageService(null, null),
          update: (ctx, auth, previousPackageService) =>
              PackageService(auth.token, auth.userId),
        ),
      ],
      child: MaterialApp(
        title: 'BS App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return FutureBuilder(
      future: authService.tryAutoLogin(),
      builder: (ctx, authResultSnapshot) {
        if (authResultSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (authService.isAuth) {
          if (authService.userRole == 'SELLER') {
            return const SellerHomeScreen();
          } else if (authService.userRole == 'EMPLOYEE') {
            return const EmployeeHomeScreen();
          }
        }
        return const LoginScreen();
      },
    );
  }
}
