import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/package.dart';
import '../../services/package_service.dart';

class PackageTrackingScreen extends StatefulWidget {
  const PackageTrackingScreen({super.key});

  @override
  _PackageTrackingScreenState createState() => _PackageTrackingScreenState();
}

class _PackageTrackingScreenState extends State<PackageTrackingScreen> {
  final _trackingIdController = TextEditingController();
  Package? _trackedPackage;
  var _isLoading = false;
  String? _error;

  Future<void> _track() async {
    if (_trackingIdController.text.isEmpty) return;
    setState(() {
      _isLoading = true;
      _error = null;
      _trackedPackage = null;
    });
    try {
      final result = await Provider.of<PackageService>(
        context,
        listen: false,
      ).trackPackage(_trackingIdController.text);
      setState(() => _trackedPackage = result);
    } catch (e) {
      setState(() => _error = "Could not find package. Please check the ID.");
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Package')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _trackingIdController,
              decoration: InputDecoration(
                labelText: 'Enter Tracking ID',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _track,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            if (_trackedPackage != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Status: ${_trackedPackage!.status}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text('Client: ${_trackedPackage!.clientName}'),
                      Text('Destination: ${_trackedPackage!.clientAddress}'),
                      const SizedBox(height: 16),
                      const Text('Real-time map would be shown here.'),
                      // Placeholder for map
                      Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.map, size: 50, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
