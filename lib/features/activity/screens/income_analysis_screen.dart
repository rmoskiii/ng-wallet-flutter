import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// --- Example raw income data ---
final rawDataByBank = {
  "all": {
    "2024": {
      "August": {
        "salary": {
          "transactions": [
            {"date": "2024-08-28", "amount": 50000},
            {"date": "2024-08-15", "amount": 30000},
          ],
          "financialImplication": "Your primary income source."
        },
        "bonus": {
          "transactions": [
            {"date": "2024-08-10", "amount": 10000},
          ],
          "financialImplication": "Extra earnings, usually one-time."
        },
        "freelance": {
          "transactions": [
            {"date": "2024-08-20", "amount": 5000},
          ],
          "financialImplication": "Side hustle or irregular work."
        },
      }
    }
  }
};

class IncomeAnalysisPage extends StatefulWidget {
  const IncomeAnalysisPage({super.key});

  @override
  State<IncomeAnalysisPage> createState() => _IncomeAnalysisPageState();
}

class _IncomeAnalysisPageState extends State<IncomeAnalysisPage> {
  String selectedYear = "2024";
  String selectedMonth = "August";

  @override
  Widget build(BuildContext context) {
    final data = rawDataByBank["all"]?[selectedYear]?[selectedMonth] ?? {};
    final chartData = data.entries.map((e) {
      final total = (e.value["transactions"] as List)
          .fold<int>(0, (sum, tx) => sum + (tx["amount"] as int));
      return {"name": e.key, "value": total};
    }).toList();

    final totalIncome =
        chartData.fold<int>(0, (sum, item) => sum + (item["value"] as int));

    return Scaffold(
      appBar: AppBar(title: const Text("Income Analysis")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Dropdowns
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                      initialValue: selectedYear,
                    decoration: const InputDecoration(labelText: "Year"),
                    items: ["2024", "2025"]
                        .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                        .toList(),
                    onChanged: (val) => setState(() => selectedYear = val!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                      initialValue: selectedMonth,
                    decoration: const InputDecoration(labelText: "Month"),
                    items: ["August", "September", "October"]
                        .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                        .toList(),
                    onChanged: (val) => setState(() => selectedMonth = val!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pie Chart
            SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 60,
                  sections: chartData.map((item) {
                    final name = item["name"] as String;
                    final value = item["value"] as int;
                    final percent =
                        totalIncome > 0 ? (value / totalIncome) * 100 : 0;
                    return PieChartSectionData(
                      value: value.toDouble(),
                      title: "$name\n${percent.toStringAsFixed(0)}%",
                      color: _colorForCategory(name),
                      radius: 60,
                      titleStyle: const TextStyle(color: Colors.white),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Category Cards
            Expanded(
              child: ListView(
                children: data.entries.map((e) {
                  final name = e.key;
                  final txs = e.value["transactions"] as List;
                  final total =
                      txs.fold<int>(0, (sum, tx) => sum + (tx["amount"] as int));
                  final percent = totalIncome > 0 ? (total / totalIncome) * 100 : 0;

                  return Card(
                    child: ListTile(
                      title: Text("$name: ₦$total"),
                      subtitle: Text("${percent.toStringAsFixed(1)}% of income"),
                      onTap: () => _showDetails(context, name, txs,
                          e.value["financialImplication"] as String),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetails(BuildContext ctx, String name, List txs, String implication) {
    showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: Text("$name Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...txs.map((tx) => ListTile(
                  dense: true,
                  title: Text("₦${tx["amount"]}"),
                  subtitle: Text(tx["date"]),
                )),
            const Divider(),
            Text("Implication: $implication"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          )
        ],
      ),
    );
  }

  Color _colorForCategory(String name) {
    switch (name) {
      case "salary":
        return Colors.green;
      case "bonus":
        return Colors.blue;
      case "freelance":
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }
}
