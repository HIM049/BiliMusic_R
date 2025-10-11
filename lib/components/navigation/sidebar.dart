import 'package:bili_music_r/components/navigation/modules.dart';
import 'package:flutter/material.dart';

// The left navigation bar
class LeftNavbarScaffold extends StatelessWidget {
  final int index;
  final Function(int) setIndex;
  final Widget Function(int, bool) buildPageContent;
  final isDesktopMode = true;

  const LeftNavbarScaffold({
    super.key,
    required this.index,
    required this.setIndex,
    required this.buildPageContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top: false,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                width: 230,
                child: NavigationDrawer(
                  onDestinationSelected: setIndex,
                  selectedIndex: index,
                  backgroundColor: Colors.transparent,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                      child: Text(
                        'Menu',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    ...navigationItems.map(
                      (NavigationItem navigationItems) {
                        return NavigationDrawerDestination(
                          label: Text(navigationItems.label),
                          icon: navigationItems.icon,
                          selectedIcon: navigationItems.selectedIcon,
                        );
                      },
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
                    //   child: Divider(),
                    // ),
                  ],
                ),
              )

            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: buildPageContent(index, isDesktopMode),
            ),
          ],
        ),
      ),
    );
  }
}
