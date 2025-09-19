import 'package:flutter/material.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool loading = false;



  late TextEditingController emailController;
  late TextEditingController passwordController;

  String email = '';
  String password = '';
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: dummyEmail);
    passwordController = TextEditingController(text: dummyPassword);
    email = dummyEmail;
    password = dummyPassword;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Dummy user credentials
  final String dummyEmail = 'user@demo.com';
  final String dummyPassword = 'password123';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => loading = true);

      // Dummy authentication: check if entered credentials match dummy user
      if (email == dummyEmail && password == dummyPassword) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, '/bvn-verification');
        });
      } else {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials. Try user@demo.com / password123')),
        );
      }
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
                    'Sign In',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Email
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    onChanged: (val) => email = val,
                    validator: (val) =>
                        val!.isEmpty ? 'Email is required' : null,
                  ),
                  const SizedBox(height: 12),

                  // Password
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () => setState(() => showPassword = !showPassword),
                      ),
                    ),
                    obscureText: !showPassword,
                    onChanged: (val) => password = val,
                    validator: (val) =>
                        val!.isEmpty ? 'Password is required' : null,
                  ),
                  const SizedBox(height: 24),

                  // Login button
                  ElevatedButton(
                    onPressed: loading ? null : _submitForm,
                    child: Text(loading ? 'Logging in...' : 'Log In'),
                  ),
                  const SizedBox(height: 16),

                  // Navigate to SignUp
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text("Don’t have an account? Sign Up"),
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
