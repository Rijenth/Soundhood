import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main bottom navigation bar used across the app.
class MainBottomNavigation extends StatelessWidget {
  const MainBottomNavigation({super.key});

  /// Returns the tab index based on the current route.
  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/events')) return 2;
    if (location.startsWith('/user/profile')) return 3;

    return 0;
  }

  /// Navigates to the correct route based on selected index.
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/search');
        break;
      case 2:
        context.go('/events');
        break;
      case 3:
        context.go('/user/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getSelectedIndex(context);

    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Rechercher'),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Événements'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
    );
  }
}
