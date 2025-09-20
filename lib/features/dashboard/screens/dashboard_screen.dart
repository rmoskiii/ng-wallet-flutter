import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool showProgress = false;
  bool reminderOpen = false;
  Timer? _hideTimer;

  final scoreData = [
    {'month': 'May', 'score': 420.0},
    {'month': 'Jun', 'score': 500.0},
    {'month': 'Jul', 'score': 560.0},
    {'month': 'Aug', 'score': 580.0},
    {'month': 'Sep', 'score': 653.0},
  ];

  final breakdownData = [
    {'name': 'Income Stability', 'score': 85, 'grade': 'Good'},
    {'name': 'Expense Ratio', 'score': 75, 'grade': 'Good'},
    {'name': 'Recurring Payment Reliability', 'score': 90, 'grade': 'Excellent'},
    {'name': 'Overdraft Behavior', 'score': 70, 'grade': 'Fair'},
    {'name': 'Loan Repayment Ratio', 'score': 60, 'grade': 'Average'},
    {'name': 'Account Profile', 'score': 80, 'grade': 'Good'},
  ];

  final scoreExplanations = {
    'Income Stability': 'Measures income consistency over time...',
    'Expense Ratio': 'The ratio of expenses to income...',
    'Recurring Payment Reliability': 'How consistently recurring payments succeed...',
    'Overdraft Behavior': 'Based on overdraft occurrences...',
    'Loan Repayment Ratio': 'Measures monthly loan burden relative to income...',
    'Account Profile': 'Account age and number of active accounts...',
  };

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 500),
      () => setState(() => showProgress = true),
    );

    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (mounted) {
          setState(() => reminderOpen = true);

          _hideTimer = Timer(const Duration(seconds: 3), () {
            if (mounted) setState(() => reminderOpen = false);
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildScoreCard(),
              _buildRiskCard(),
              _buildGoalCard(context),
              _buildSavingsCard(),
              _buildBreakdownCard(),
              _buildExplanationsCard(),
            ],
          ),
        ),

        // floating reminder
        Positioned(
          bottom: 16,
          right: 16,
          child: AnimatedOpacity(
            opacity: reminderOpen ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: reminderOpen
                ? FloatingActionButton.extended(
                    onPressed: () => setState(() => reminderOpen = false),
                    label: const Text('Next auto-payment ₦10 on Sep 5, 2024'),
                    icon: const Icon(Icons.warning),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  // --- UI builders ---

  Widget _buildScoreCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('NG Wallet', style: TextStyle(color: Colors.grey)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text('653',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Text('▲ 60', style: TextStyle(color: Colors.green)),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Next update in 2 days',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: scoreData.asMap().entries.map((e) {
                        return FlSpot(
                            e.key.toDouble(), e.value['score'] as double);
                      }).toList(),
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 100,
                        getTitlesWidget: (value, _) {
                          if (value % 100 == 0) {
                            return Text((value / 100).round().toString(),
                                style: const TextStyle(fontSize: 12));
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 30,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          final index = value.toInt();
                          if (index < 0 || index >= scoreData.length) {
                            return const SizedBox.shrink();
                          }
                          return Text(scoreData[index]['month'] as String);
                        },
                      ),
                    ),
                    topTitles:
                        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskCard() {
    return const Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Risk Level', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('LOW', style: TextStyle(fontSize: 24, color: Colors.green)),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: const Text('Ready to Set a Goal?'),
        subtitle: const Text('Improve your score by setting a target.'),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            Navigator.pushNamed(context, '/goals');
          },
        ),
      ),
    );
  }

  Widget _buildSavingsCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My Savings',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('₦450,000',
                style: TextStyle(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: LinearProgressIndicator(
                key: ValueKey(showProgress),
                value: showProgress ? 0.75 : 0,
                minHeight: 10,
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('₦450,000'),
                Text('₦600,000', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: const Text('Score Breakdown'),
        children: breakdownData.map((item) {
          return ListTile(
            title: Text(item['name'] as String),
            subtitle:
                Text('Score: ${item['score']}, Grade: ${item['grade']}'),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExplanationsCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: const Text('How Scores Are Calculated'),
        children: scoreExplanations.entries.map((e) {
          return ExpansionTile(
            title: Text(e.key),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(e.value),
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}
