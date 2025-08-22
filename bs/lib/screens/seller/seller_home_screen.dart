import 'package:flutter/material.dart';
import 'order_logistics_screen.dart';
import 'package_tracking_screen.dart';
import '../profile_screen.dart';

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Dashboard'),
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
              icon: const Icon(Icons.add_box),
              label: const Text('Order Logistics'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const OrderLogisticsScreen()),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.track_changes),
              label: const Text('Track Package'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PackageTrackingScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
