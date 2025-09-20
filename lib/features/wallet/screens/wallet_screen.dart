import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool showBalance = false;
  double balance = 125000; // Dummy balance
  double interest = 500;   // Dummy interest added

  String get formattedBalance => "₦${balance.toStringAsFixed(0)}";
  String get formattedInterest => "₦${interest.toStringAsFixed(0)}";
  String get hiddenBalance => "₦${"•" * (formattedBalance.length - 1)}";

  final List<Map<String, dynamic>> services = [
    {"label": "Fund Wallet", "icon": Icons.arrow_upward},
    {"label": "Withdraw", "icon": Icons.arrow_downward},
    {"label": "Airtime", "icon": Icons.phone_iphone},
    {"label": "Data", "icon": Icons.wifi},
    {"label": "Bills", "icon": Icons.flash_on},
    {"label": "Link Bank", "icon": Icons.account_balance},
    {"label": "Refer & Earn", "icon": Icons.share},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        color: theme.colorScheme.surface,
        padding: const EdgeInsets.only(bottom: 16),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Balance Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "NG Wallet Balance",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() => showBalance = !showBalance);
                            },
                            icon: Icon(
                              showBalance
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        showBalance ? formattedBalance : hiddenBalance,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        showBalance
                            ? "+ $formattedInterest interest added"
                            : "••••••••••••••",
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Tap to ${showBalance ? "hide" : "show"} balance",
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Credit Score Message
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: theme.brightness == Brightness.dark
                    ? Colors.grey[850]
                    : Colors.blue[50],
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "Funding and withdrawing from your NG Wallet can help boost your credit score!",
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.indigo[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // Services Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final service = services[index];
                  return OutlinedButton(
                    onPressed: () {
                      // Placeholder - navigation disabled
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${service["label"]} page not added yet."),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: theme.dividerColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          service["icon"],
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          service["label"],
                          style: const TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Transactions Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Recent Transactions",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "No recent transactions found.",
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("History page not added yet."),
                            ),
                          );
                        },
                        child: const Text("View all history"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
