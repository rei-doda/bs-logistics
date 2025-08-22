import 'package:flutter/material.dart';
import '../../models/package.dart';

class CreateInvoiceScreen extends StatelessWidget {
  final Package package;
  const CreateInvoiceScreen({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Invoice')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invoice for Package: ${package.id}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Client: ${package.clientName}'),
                    Text('Address: ${package.clientAddress}'),
                    Text('Phone: ${package.clientPhone}'),
                    const Divider(height: 20, thickness: 1),
                    Text('Weight: ${package.weightKg} kg'),
                    Text(
                      'Dimensions: ${package.sizeWidthCm}x${package.sizeHeightCm}x${package.sizeDepthCm} cm',
                    ),
                    const Divider(height: 20, thickness: 1),
                    Text(
                      'Shipping Cost: \$${package.price?.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Call backend to create invoice
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invoice created successfully!'),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Confirm and Generate Invoice'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
