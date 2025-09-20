import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool showPassword = false;

  Map<String, bool> notifications = {
    'Email': true,
    'SMS': false,
    'Push': true,
  };

  final userData = {
    'name': 'Ahmed Bello',
    'email': 'abello92@example.com',
    'phone': '080-1234-5678',
    'bvn': '22111111111',
    'accountNumber': '0012345678',
    'bank': 'First Bank of Nigeria',
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  "Account Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(),

                /// Personal Information
                ExpansionTile(
                  leading: const Icon(Icons.person),
                  title: const Text(
                    "Personal Information",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  initiallyExpanded: true,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: "Full Name"),
                      controller: TextEditingController(text: "Ahmed Bello"),
                      enabled: false,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: "BVN"),
                      controller: TextEditingController(text: "22111111111"),
                      enabled: false,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: "Email"),
                      controller: TextEditingController(text: "abello92@example.com"),
                      enabled: false,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: "Phone Number"),
                      controller: TextEditingController(text: "080-1234-5678"),
                      enabled: false,
                    ),
                  ],
                ),

                /// Linked Accounts
                ExpansionTile(
                  leading: const Icon(Icons.account_balance),
                  title: const Text(
                    "Linked Accounts",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  initiallyExpanded: true,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: "Bank Name"),
                      controller: TextEditingController(text: "First Bank of Nigeria"),
                      enabled: false,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: "Account Number"),
                      controller: TextEditingController(text: "0012345678"),
                      enabled: false,
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        // Placeholder action
                      },
                      child: const Text("Manage Linked Accounts"),
                    ),
                  ],
                ),

                /// Notifications
                ExpansionTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text(
                    "Notification Preferences",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  initiallyExpanded: true,
                  children: notifications.keys.map((type) {
                    return SwitchListTile(
                      title: Text("$type Notifications"),
                      value: notifications[type]!,
                      onChanged: (val) {
                        setState(() {
                          notifications[type] = val;
                        });
                      },
                    );
                  }).toList(),
                ),

                /// Security
                ExpansionTile(
                  leading: const Icon(Icons.security),
                  title: const Text(
                    "Security",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  initiallyExpanded: true,
                  children: [
                    TextField(
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                        labelText: "Current Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "New Password"),
                    ),
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "Confirm New Password"),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        // Placeholder action
                      },
                      child: const Text("Update Password"),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {
                        // Placeholder action
                      },
                      child: const Text("Enable Two-Factor Authentication"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
