import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isLoading = true);
    try {
      await Provider.of<AuthService>(
        context,
        listen: false,
      ).login(_email, _password);
    } catch (error) {
      _showErrorDialog(error.toString());
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bs Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // EDIT: Added the image here
                Image.asset(
                  'assets/bs.JPG',
                  height: 150, // You can adjust the size
                  errorBuilder: (context, error, stackTrace) {
                    // This shows a placeholder if the image fails to load
                    return const Icon(
                      Icons.local_shipping,
                      size: 150,
                      color: Colors.grey,
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (v) => (v == null || v.isEmpty || !v.contains('@'))
                      ? 'Please enter a valid email.'
                      : null,
                  onSaved: (v) => _email = v!,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  key: const ValueKey('password'),
                  validator: (v) => (v == null || v.isEmpty || v.length < 5)
                      ? 'Password is too short!'
                      : null,
                  onSaved: (v) => _password = v!,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 20),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Login'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
