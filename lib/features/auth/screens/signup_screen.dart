import 'package:flutter/material.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;

  String name = '';
  String email = '';
  String dob = '';
  String password = '';
  String confirmPassword = '';
  bool loading = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords don't match")),
        );
        return;
      }

      setState(() => loading = true);

      // Simulate API call
      Future.delayed(const Duration(seconds: 1), () {
  if (!mounted) return;
  Navigator.pushReplacementNamed(context, '/dashboard');
});

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // Full Name
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    onChanged: (val) => name = val,
                    validator: (val) => val!.isEmpty ? 'Name is required' : null,
                  ),
                  const SizedBox(height: 12),

                  // Email
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    onChanged: (val) => email = val,
                    validator: (val) => val!.isEmpty ? 'Email is required' : null,
                  ),
                  const SizedBox(height: 12),

                  // DOB
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Date of Birth'),
                    onChanged: (val) => dob = val,
                    validator: (val) => val!.isEmpty ? 'DOB is required' : null,
                  ),
                  const SizedBox(height: 12),

                  // Password
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                            showPassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () =>
                            setState(() => showPassword = !showPassword),
                      ),
                    ),
                    obscureText: !showPassword,
                    onChanged: (val) => password = val,
                    validator: (val) =>
                        val!.isEmpty ? 'Password is required' : null,
                  ),
                  const SizedBox(height: 12),

                  // Confirm Password
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                            showPassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () =>
                            setState(() => showPassword = !showPassword),
                      ),
                    ),
                    obscureText: !showPassword,
                    onChanged: (val) => confirmPassword = val,
                    validator: (val) =>
                        val!.isEmpty ? 'Confirm password is required' : null,
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: loading ? null : _submitForm,
                    child: Text(loading ? 'Signing up...' : 'Sign Up'),
                  ),
                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/signin');
                    },
                    child: const Text("Already have an account? Sign In"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
