import 'package:flutter/material.dart';
import 'receive_orders_screen.dart';
import '../profile_screen.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.inventory_2),
              label: const Text('View Pending Orders'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ReceiveOrdersScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
