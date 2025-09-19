import 'package:flutter/material.dart';

/// A single menu item
class MenuItemData {
  final String name;
  final IconData icon;
  final String? route; // can be null until you wire actual routes

  const MenuItemData({
    required this.name,
    required this.icon,
    this.route,
  });
}

/// A section grouping multiple menu items
class MenuSection {
  final String title;
  final List<MenuItemData> items;

  const MenuSection({
    required this.title,
    required this.items,
  });
}

/// Define your menu structure
const List<MenuSection> ngWalletMenuItems = [
  MenuSection(
    title: "Learn and earn",
    items: [
      MenuItemData(name: "Rewards", icon: Icons.monetization_on, route: null),
      MenuItemData(name: "Refer and earn", icon: Icons.trending_up, route: null),
      MenuItemData(name: "Learn", icon: Icons.card_giftcard, route: null),
    ],
  ),
  MenuSection(
    title: "Manage finances",
    items: [
      MenuItemData(name: "Add bank accounts", icon: Icons.credit_card, route: null),
      MenuItemData(name: "Transaction history", icon: Icons.history, route: null),
      MenuItemData(name: "Income analysis", icon: Icons.arrow_downward, route: null),
      MenuItemData(name: "Spending analysis", icon: Icons.arrow_upward, route: null),
      MenuItemData(name: "Set goals", icon: Icons.flag, route: null),
    ],
  ),
  MenuSection(
    title: "Send and pay",
    items: [
      MenuItemData(name: "Fund wallet", icon: Icons.account_balance_wallet, route: null),
      MenuItemData(name: "Withdraw", icon: Icons.volunteer_activism, route: null),
      MenuItemData(name: "Airtime", icon: Icons.phone_android, route: null),
      MenuItemData(name: "Data", icon: Icons.wifi, route: null),
      MenuItemData(name: "Bills", icon: Icons.flash_on, route: null),
      MenuItemData(name: "Donate", icon: Icons.send, route: null),
    ],
  ),
  MenuSection(
    title: "Profile and support",
    items: [
      MenuItemData(name: "Your profile", icon: Icons.person, route: null),
      MenuItemData(name: "Help centre", icon: Icons.help_outline, route: null),
    ],
  ),
];
