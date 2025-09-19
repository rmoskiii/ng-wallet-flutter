import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    final educationalContent = [
      {
        "title": "How Your Credit Score Works in Nigeria",
        "icon": Icons.menu_book,
        "content": Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Think of your credit score as your financial report card. It's a three-digit number that tells lenders how well you've managed your money in the past. In Nigeria, this score is calculated by licensed Credit Bureaus like CRC Credit Bureau, CreditRegistry, and FirstCentral Credit Bureau.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            const Text(
              "What Matters Most?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            _bullet("Payment History: Paying your loans and bills on time shows you're a responsible borrower."),
            _bullet("Debt Amount: How much debt you owe compared to your credit limits. Keeping your credit utilization low is key."),
            _bullet("Credit History Length: The longer your history of responsible borrowing, the better your score."),
            _bullet("New Credit Applications: Applying for too much credit at once can temporarily lower your score."),
          ],
        )
      },
      {
        "title": "Habits to Improve Your Financial Health",
        "icon": Icons.emoji_events,
        "content": Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Building good money habits is a marathon, not a sprint. Here are some simple, practical steps to take control of your finances:",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 6),
            _bullet("Create a Budget: Track income and expenses to see how you're spending."),
            _bullet("Pay Yourself First: Set aside money for savings before expenses."),
            _bullet("Distinguish Needs from Wants: Learn to live within your means."),
            _bullet("Build an Emergency Fund: Save 3-6 months of living expenses."),
          ],
        )
      },
      {
        "title": "Understanding Savings vs. Investment",
        "icon": Icons.menu_book,
        "content": Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Saving and investing are both crucial, but they serve different purposes.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            const Text(
              "Savings",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            _bullet("Purpose: Short-term goals like rent, gadgets, or emergency fund."),
            _bullet("Risk: Very low, safe in savings accounts."),
            _bullet("Returns: Typically low, often below inflation."),
            const SizedBox(height: 12),
            const Text(
              "Investment",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            _bullet("Purpose: Long-term goals like retirement, house, school fees."),
            _bullet("Risk: Varies from low to high depending on bonds, stocks, real estate."),
            _bullet("Returns: Potentially higher, can outpace inflation."),
          ],
        )
      },
    ];

    final faqs = [
      {
        "q": "What is a credit score and why is it important in Nigeria?",
        "a":
            "A credit score is a number that shows how reliable you are at paying back money you've borrowed. A good score can help you get loans, mortgages, or credit cards with better interest rates."
      },
      {
        "q": "How can NG Wallet help me build my credit score?",
        "a":
            "By using features like the Credit Builder, NG Wallet helps you report your on-time payments to local credit bureaus. Consistent repayments build your history and improve your score."
      },
      {
        "q": "How long does it take to build a good credit score?",
        "a":
            "With regular on-time payments, you may see improvement in a few months, but it often takes 6–12 months to build a solid history."
      },
      {
        "q": "What if I miss a payment?",
        "a":
            "Missing a payment can negatively affect your score. Pay it off quickly and return to consistency."
      },
      {
        "q": "Can I check my credit score on NG Wallet?",
        "a":
            "Yes, you can view your score directly in the app dashboard and track improvements."
      },
    ];

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(   // ✅ ensures content avoids notch & status bar
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 12 : 24,
            horizontal: isMobile ? 8 : 16,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Financial Wisdom Hub 🧠",
                    style: TextStyle(
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Learn how to manage your money like a pro with bite-sized content on financial literacy.",
                    style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Educational cards
                  for (var item in educationalContent)
                    Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(item["icon"] as IconData,
                                      color: theme.colorScheme.primary),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      item["title"] as String,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              item["content"] as Widget,
                            ]),
                      ),
                    ),

                  const SizedBox(height: 24),
                  Text(
                    "FAQs about Credit Building with NG Wallet",
                    style: TextStyle(
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: faqs.map((faq) {
                        return ExpansionTile(
                          title: Text(
                            faq["q"]!,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                faq["a"]!,
                                style: TextStyle(
                                  color: theme.textTheme.bodySmall?.color,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        );
                      }).toList(),
                    ),
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

/// Helper function for bullet points
Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 16, // fixed space for bullet
          child: Text("•", style: TextStyle(fontSize: 14)),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    ),
  );
}
