import 'package:flutter/material.dart';
import '../constants/menu_items.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  void _handleItemTap(BuildContext context, MenuItemData item) {
    if (item.route != null) {
      Navigator.pop(context); // close drawer first
      // Later: Navigator.pushNamed(context, item.route!);
      debugPrint("Navigate to ${item.route}");
    } else {
      Navigator.pop(context);
      debugPrint("Tapped on '${item.name}' (no route yet)");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: ngWalletMenuItems.length,
          itemBuilder: (context, sectionIndex) {
            final section = ngWalletMenuItems[sectionIndex];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section title
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    section.title.toUpperCase(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                // Section items
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 1,
                  child: Column(
                    children: section.items.map((item) {
                      return ListTile(
                        leading: Icon(item.icon,
                            color: theme.colorScheme.primary),
                        title: Text(
                          item.name,
                          style:
                              const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () => _handleItemTap(context, item),
                      );
                    }).toList(),
                  ),
                ),

                if (sectionIndex < ngWalletMenuItems.length - 1)
                  const SizedBox(height: 24),
              ],
            );
          },
        ),
      ),
    );
  }
}
