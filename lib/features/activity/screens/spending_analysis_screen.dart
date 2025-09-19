import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Example data model (simplified for demo)
class Transaction {
  final String date;
  final String description;
  final int amount;
  final String implication;

  Transaction({
    required this.date,
    required this.description,
    required this.amount,
    required this.implication,
  });
}

class SpendingCategory {
  final String name;
  int value;
  final List<Transaction> transactions;

  SpendingCategory({
    required this.name,
    required this.value,
    required this.transactions,
  });
}

// Dummy data (replace with your rawDataByBank logic)
final Map<String, Map<String, Map<String, List<SpendingCategory>>>> dataByBank = {
  'all': {
    '2024': {
      'August': [
        SpendingCategory(
          name: 'Bills',
          value: 15000,
          transactions: [
            Transaction(
              date: 'Aug 2',
              description: 'Electricity',
              amount: 10000,
              implication: 'Timely bill payments boost credit.',
            ),
            Transaction(
              date: 'Aug 15',
              description: 'Water Bill',
              amount: 5000,
              implication: 'Late payment can slightly hurt score.',
            ),
          ],
        ),
        SpendingCategory(
          name: 'Food',
          value: 10000,
          transactions: [
            Transaction(
              date: 'Aug 4',
              description: 'Groceries',
              amount: 10000,
              implication: 'No direct impact, but budgeting matters.',
            ),
          ],
        ),
      ],
    },
  },
};

class SpendingAnalysisPage extends StatefulWidget {
  final String initialBank;
  final String initialYear;
  final String initialMonth;

  const SpendingAnalysisPage({
    super.key,
    this.initialBank = 'all',
    this.initialYear = '2024',
    this.initialMonth = 'August',
  });

  @override
  State<SpendingAnalysisPage> createState() => _SpendingAnalysisPageState();
}

class _SpendingAnalysisPageState extends State<SpendingAnalysisPage> {
  late String selectedBank;
  late String selectedYear;
  late String selectedMonth;
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedBank = widget.initialBank;
    selectedYear = widget.initialYear;
    selectedMonth = widget.initialMonth;
  }

  @override
  Widget build(BuildContext context) {
    final data = dataByBank[selectedBank]?[selectedYear]?[selectedMonth] ?? [];
    final totalSpending = data.fold<int>(0, (sum, e) => sum + e.value);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Spending Behaviour - $selectedMonth, $selectedYear'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdowns for Year & Month
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                            initialValue: selectedYear,
                    decoration: const InputDecoration(labelText: "Year"),
                    items: dataByBank[selectedBank]!.keys
                        .map((year) => DropdownMenuItem(
                              value: year,
                              child: Text(year),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value!;
                        final months = dataByBank[selectedBank]![selectedYear]!.keys.toList();
                        selectedMonth = months.first;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                            initialValue: selectedMonth,
                    decoration: const InputDecoration(labelText: "Month"),
                    items: dataByBank[selectedBank]![selectedYear]!.keys
                        .map((month) => DropdownMenuItem(
                              value: month,
                              child: Text(month),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMonth = value!;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Pie Chart
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: data.asMap().entries.map((entry) {
                    final index = entry.key;
                    final cat = entry.value;
                    final percentage = (cat.value / (totalSpending == 0 ? 1 : totalSpending)) * 100;

                    return PieChartSectionData(
                      value: cat.value.toDouble(),
                      title: "${cat.name}\n${percentage.toStringAsFixed(0)}%",
                      color: [
                        Colors.green,
                        Colors.blue,
                        Colors.orange,
                        Colors.red,
                      ][index % 4],
                      radius: 60,
                      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Category List
            Expanded(
              child: ListView(
                children: data.map((cat) {
                  final percentage = (cat.value / (totalSpending == 0 ? 1 : totalSpending)) * 100;
                  return Card(
                    child: ListTile(
                      title: Text("${cat.name}: ₦${cat.value} (${percentage.toStringAsFixed(0)}%)"),
                      onTap: () {
                        setState(() {
                          selectedCategory = cat.name;
                        });
                        _showCategoryDialog(cat);
                      },
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

  void _showCategoryDialog(SpendingCategory cat) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${cat.name} Details"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: cat.transactions.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final tx = cat.transactions[index];
                return ListTile(
                  title: Text("${tx.date}: ${tx.description} - ₦${tx.amount}"),
                  subtitle: Text(tx.implication),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }
}
