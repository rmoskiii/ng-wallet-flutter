import 'package:flutter/material.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  static const int currentScore = 650;
  final TextEditingController _controller = TextEditingController();

  int? savedGoal;

  void _saveGoal() {
    final input = int.tryParse(_controller.text);
    if (input != null && input > currentScore && input <= 800) {
      setState(() {
        savedGoal = input;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = savedGoal != null
        ? (currentScore / savedGoal! * 100).clamp(0, 100).toDouble()
        : 0.0;

    final isGoalAchieved = savedGoal != null && currentScore >= savedGoal!;

    return Scaffold(
      appBar: AppBar(title: const Text("Set a Credit Score Goal")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- Goal Form ---
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Set a Credit Score Goal",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Target Credit Score (max: 800)",
                        helperText: "A perfect score is 800. Set a realistic target.",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _saveGoal,
                      child: const Text("Save Goal"),
                    )
                  ],
                ),
              ),
            ),

            if (savedGoal != null) ...[
              // --- Progress Visualizer ---
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Progress Toward Your Goal",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(label: Text("Current: $currentScore")),
                          Chip(label: Text("Target: $savedGoal")),
                        ],
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: progress / 100,
                        minHeight: 10,
                        color: isGoalAchieved ? Colors.green : Colors.blue,
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          isGoalAchieved
                              ? "Goal Achieved! 🎉"
                              : "${progress.toStringAsFixed(2)}% of your goal reached.",
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // --- Milestones Accordion ---
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  title: const Text("Milestones & Timeline"),
                  children: const [
                    ListTile(
                      leading: Icon(Icons.add_circle_outline),
                      title: Text("Pay all bills on time for 3 months"),
                      subtitle: Text("Impact: Immediate, Timeline: 3 months"),
                    ),
                    ListTile(
                      leading: Icon(Icons.add_circle_outline),
                      title: Text("Reduce credit utilization below 30%"),
                      subtitle:
                          Text("Impact: High, Timeline: 1-2 billing cycles"),
                    ),
                    ListTile(
                      leading: Icon(Icons.add_circle_outline),
                      title: Text("Avoid new credit applications"),
                      subtitle: Text("Impact: Moderate, Timeline: 6 months"),
                    ),
                  ],
                ),
              ),

              // --- Suggestions Accordion ---
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  title: const Text("Personalized Suggestions"),
                  children: const [
                    ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      title: Text(
                          "Review your Spending Analysis page to find areas to save."),
                    ),
                    ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      title: Text(
                          "Set up payment reminders for all your bills to avoid late fees."),
                    ),
                    ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      title: Text(
                          "Consider using the Credit Builder tool to automate savings."),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
