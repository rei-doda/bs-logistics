import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/package.dart';
import '../../services/package_service.dart';
import 'create_invoice_screen.dart';

class ReceiveOrdersScreen extends StatefulWidget {
  const ReceiveOrdersScreen({super.key});

  @override
  _ReceiveOrdersScreenState createState() => _ReceiveOrdersScreenState();
}

class _ReceiveOrdersScreenState extends State<ReceiveOrdersScreen> {
  late Future<List<Package>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = Provider.of<PackageService>(
      context,
      listen: false,
    ).fetchPendingOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pending Package Orders')),
      body: FutureBuilder<List<Package>>(
        future: _ordersFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No pending orders found.'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (ctx, i) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: ListTile(
                  title: Text('Package ID: ${orders[i].id}'),
                  subtitle: Text(
                    'To: ${orders[i].clientName}\nAddress: ${orders[i].clientAddress}',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CreateInvoiceScreen(package: orders[i]),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
