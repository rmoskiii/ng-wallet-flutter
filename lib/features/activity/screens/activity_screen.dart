import 'package:flutter/material.dart';
import 'income_analysis_screen.dart';
import 'spending_analysis_screen.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  void _openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTile(
            context,
            icon: Icons.arrow_downward,
            iconColor: Colors.green,
            title: "Income Analysis",
            subtitle: "View sources of income",
            page: const IncomeAnalysisPage(),
          ),
          const SizedBox(height: 8),
          _buildTile(
            context,
            icon: Icons.arrow_upward,
            iconColor: Colors.red,
            title: "Spending Analysis",
            subtitle: "View spending categories",
            page: const SpendingAnalysisPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget page,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle),
        onTap: () => _openPage(context, page),
      ),
    );
  }
}
