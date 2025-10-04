import 'package:bili_music_r/components/navigation/modules.dart';
import 'package:flutter/material.dart';

// The bottom navigation bar
class BottomNavbarScaffold extends StatelessWidget {
  final int index;
  final Function(int) setIndex;
  final Widget Function(int, bool) buildPageContent;
  final isDesktopMode = false;

  const BottomNavbarScaffold({
    super.key,
    required this.index,
    required this.setIndex,
    required this.buildPageContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildPageContent(index, isDesktopMode),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: setIndex,
        destinations: navigationItems.map(
          (NavigationItem item) {
            return NavigationDestination(
              label: item.label,
              icon: item.icon,
              selectedIcon: item.selectedIcon,
              tooltip: item.label,
            );
          },
        ).toList(),
      ),
    );
  }
}
