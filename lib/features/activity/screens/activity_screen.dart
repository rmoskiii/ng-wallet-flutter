import 'package:flutter/material.dart';
import 'income_analysis_screen.dart'; // for sibling files
import 'spending_analysis_screen.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Activity Overview")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.arrow_downward, color: Colors.green),
            title: const Text("Income Analysis"),
            subtitle: const Text("View sources of income"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const IncomeAnalysisPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.arrow_upward, color: Colors.red),
            title: const Text("Spending Analysis"),
            subtitle: const Text("View spending categories"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SpendingAnalysisPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
