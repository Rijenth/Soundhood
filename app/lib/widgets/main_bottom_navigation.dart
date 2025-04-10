import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';
import '../providers/auth_provider.dart';
import '../screens/authenticated/home_screen.dart';
import '../screens/authenticated/search_screen.dart';
import '../screens/authenticated/user_profile_update_screen.dart';

class MainBottomNavigation extends StatelessWidget {
  const MainBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    if (!authProvider.isAuthenticated) return const SizedBox.shrink();

    void onItemTapped(int index) {
      navProvider.setIndex(index);

      Widget targetPage;

      switch (index) {
        case 0:
          targetPage = const HomeScreen();
          break;
        case 1:
          targetPage = SearchScreen();
          break;
        case 2:
          targetPage = const HomeScreen();
          break;
        case 3:
          targetPage = const UserProfileUpdateScreen();
          break;
        default:
          targetPage = const HomeScreen();
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => targetPage),
      );
    }

    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      currentIndex: navProvider.currentIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Rechercher'),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Evénements'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
    );
  }
}
