import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/package.dart';
import '../../services/package_service.dart';
import 'package:intl/intl.dart';

class OrderLogisticsScreen extends StatefulWidget {
  const OrderLogisticsScreen({super.key});

  @override
  _OrderLogisticsScreenState createState() => _OrderLogisticsScreenState();
}

class _OrderLogisticsScreenState extends State<OrderLogisticsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pickupDateController = TextEditingController();
  var _isLoading = false;

  var _package = Package(
    weightKg: 0,
    sizeWidthCm: 0,
    sizeHeightCm: 0,
    sizeDepthCm: 0,
    clientName: '',
    clientAddress: '',
    clientPhone: '',
    pickupDate: DateTime.now(),
  );

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _package.pickupDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _package.pickupDate) {
      setState(() {
        _package = Package(
          weightKg: _package.weightKg,
          sizeWidthCm: _package.sizeWidthCm,
          sizeHeightCm: _package.sizeHeightCm,
          sizeDepthCm: _package.sizeDepthCm,
          clientName: _package.clientName,
          clientAddress: _package.clientAddress,
          clientPhone: _package.clientPhone,
          pickupDate: picked,
        );
        _pickupDateController.text = DateFormat.yMd().format(picked);
      });
    }
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isLoading = true);

    try {
      final result = await Provider.of<PackageService>(
        context,
        listen: false,
      ).createPackage(_package);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Package created! Price: \$${result['price']}')),
      );
      Navigator.of(context).pop();
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _pickupDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Logistics')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Package Details",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    (v == null ||
                        double.tryParse(v) == null ||
                        double.parse(v) <= 0)
                    ? 'Enter a valid weight'
                    : null,
                onSaved: (v) => _package = Package(
                  weightKg: double.parse(v!),
                  sizeWidthCm: _package.sizeWidthCm,
                  sizeHeightCm: _package.sizeHeightCm,
                  sizeDepthCm: _package.sizeDepthCm,
                  clientName: _package.clientName,
                  clientAddress: _package.clientAddress,
                  clientPhone: _package.clientPhone,
                  pickupDate: _package.pickupDate,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Width (cm)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          (v == null ||
                              double.tryParse(v) == null ||
                              double.parse(v) <= 0)
                          ? 'Enter valid width'
                          : null,
                      onSaved: (v) => _package = Package(
                        weightKg: _package.weightKg,
                        sizeWidthCm: double.parse(v!),
                        sizeHeightCm: _package.sizeHeightCm,
                        sizeDepthCm: _package.sizeDepthCm,
                        clientName: _package.clientName,
                        clientAddress: _package.clientAddress,
                        clientPhone: _package.clientPhone,
                        pickupDate: _package.pickupDate,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Height (cm)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          (v == null ||
                              double.tryParse(v) == null ||
                              double.parse(v) <= 0)
                          ? 'Enter valid height'
                          : null,
                      onSaved: (v) => _package = Package(
                        weightKg: _package.weightKg,
                        sizeWidthCm: _package.sizeWidthCm,
                        sizeHeightCm: double.parse(v!),
                        sizeDepthCm: _package.sizeDepthCm,
                        clientName: _package.clientName,
                        clientAddress: _package.clientAddress,
                        clientPhone: _package.clientPhone,
                        pickupDate: _package.pickupDate,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Depth (cm)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          (v == null ||
                              double.tryParse(v) == null ||
                              double.parse(v) <= 0)
                          ? 'Enter valid depth'
                          : null,
                      onSaved: (v) => _package = Package(
                        weightKg: _package.weightKg,
                        sizeWidthCm: _package.sizeWidthCm,
                        sizeHeightCm: _package.sizeHeightCm,
                        sizeDepthCm: double.parse(v!),
                        clientName: _package.clientName,
                        clientAddress: _package.clientAddress,
                        clientPhone: _package.clientPhone,
                        pickupDate: _package.pickupDate,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                "Client Details",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Client Name'),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Enter client name' : null,
                onSaved: (v) => _package = Package(
                  weightKg: _package.weightKg,
                  sizeWidthCm: _package.sizeWidthCm,
                  sizeHeightCm: _package.sizeHeightCm,
                  sizeDepthCm: _package.sizeDepthCm,
                  clientName: v!,
                  clientAddress: _package.clientAddress,
                  clientPhone: _package.clientPhone,
                  pickupDate: _package.pickupDate,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Client Address'),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Enter client address' : null,
                onSaved: (v) => _package = Package(
                  weightKg: _package.weightKg,
                  sizeWidthCm: _package.sizeWidthCm,
                  sizeHeightCm: _package.sizeHeightCm,
                  sizeDepthCm: _package.sizeDepthCm,
                  clientName: _package.clientName,
                  clientAddress: v!,
                  clientPhone: _package.clientPhone,
                  pickupDate: _package.pickupDate,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Client Phone'),
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Enter client phone' : null,
                onSaved: (v) => _package = Package(
                  weightKg: _package.weightKg,
                  sizeWidthCm: _package.sizeWidthCm,
                  sizeHeightCm: _package.sizeHeightCm,
                  sizeDepthCm: _package.sizeDepthCm,
                  clientName: _package.clientName,
                  clientAddress: _package.clientAddress,
                  clientPhone: v!,
                  pickupDate: _package.pickupDate,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pickupDateController,
                decoration: const InputDecoration(
                  labelText: 'Pickup Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: _selectDate,
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Center(
                  child: ElevatedButton(
                    onPressed: _submitOrder,
                    child: const Text('Calculate Price & Submit'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
