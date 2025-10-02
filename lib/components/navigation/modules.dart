import 'package:flutter/material.dart';

class NavigationItem {
  const NavigationItem(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<NavigationItem> navigationItems = <NavigationItem>[
  NavigationItem('Download', Icon(Icons.download_outlined), Icon(Icons.download_sharp)),
  NavigationItem('Space', Icon(Icons.account_circle_outlined), Icon(Icons.account_circle_sharp)),
  NavigationItem('Settings', Icon(Icons.settings_outlined), Icon(Icons.settings)),
];