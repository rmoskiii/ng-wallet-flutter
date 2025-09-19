import 'package:flutter/material.dart';

class BvnVerificationScreen extends StatefulWidget {
  static const routeName = '/bvn-verification';

  const BvnVerificationScreen({super.key});

  @override
  State<BvnVerificationScreen> createState() => _BvnVerificationScreenState();
}

class _BvnVerificationScreenState extends State<BvnVerificationScreen> {
  final TextEditingController _bvnController =
      TextEditingController(text: "2211234567890"); // pre-filled dummy BVN

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Your Identity"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to NG Wallet!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "The smart way to build credit—helping users grow their financial reputation "
              "while giving lenders clearer insight into creditworthiness.",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            const Text(
              "Verify Your Identity",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "For this demo, your details are pre-filled. In the live app, you'll enter your own information.",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // BVN TextField
            TextField(
              controller: _bvnController,
              readOnly: true, // prevent editing
              decoration: const InputDecoration(
                labelText: "Bank Verification Number (BVN) *",
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // After BVN confirm, navigate to dashboard
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
