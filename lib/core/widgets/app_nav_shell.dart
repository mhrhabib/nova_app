import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive.dart';

class AppNavShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppNavShell({
    super.key,
    required this.navigationShell,
  });

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktopOrTablet = !context.isMobile;

    final navItems = const [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(Icons.search_outlined),
        selectedIcon: Icon(Icons.search),
        label: 'Search',
      ),
      NavigationDestination(
        icon: Icon(Icons.domain_outlined),
        selectedIcon: Icon(Icons.domain),
        label: 'Listings',
      ),
      NavigationDestination(
        icon: Icon(Icons.auto_awesome_outlined),
        selectedIcon: Icon(Icons.auto_awesome),
        label: 'Matches',
      ),
      NavigationDestination(
        icon: Icon(Icons.calendar_month_outlined),
        selectedIcon: Icon(Icons.calendar_month),
        label: 'Activities',
      ),
      NavigationDestination(
        icon: Icon(Icons.forum_outlined),
        selectedIcon: Icon(Icons.forum),
        label: 'Messages',
      ),
      NavigationDestination(
        icon: Icon(Icons.dashboard_outlined),
        selectedIcon: Icon(Icons.dashboard),
        label: 'Dashboard',
      ),
      NavigationDestination(
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person),
        label: 'Profile',
      ),
    ];

    if (isDesktopOrTablet) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (int index) => _onTap(context, index),
              labelType: NavigationRailLabelType.selected,
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: theme.colorScheme.primary,
                      radius: 20,
                      child: const Text(
                        'N',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'NOVA',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              destinations: navItems
                  .map((e) => NavigationRailDestination(
                        icon: e.icon,
                        selectedIcon: e.selectedIcon,
                        label: Text(e.label),
                      ))
                  .toList(),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    // Mobile layout with Bottom Navigation Bar
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (int index) => _onTap(context, index),
        destinations: navItems.take(5).toList(), // Show top 5 on mobile bottom nav
      ),
    );
  }
}
