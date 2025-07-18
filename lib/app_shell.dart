import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/home/home_page.dart';
import 'features/favorites/favorites_page.dart';
import 'features/profile/profile_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({Key? key}) : super(key: key);

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final greenStart = Colors.green.shade600;
    final greenEnd = Colors.green.shade400;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4.0, // Height of the gradient "border"
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [greenStart, greenEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
            unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w400),
            selectedItemColor: greenStart,
            unselectedItemColor: Colors.grey.shade600,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: greenStart.withOpacity(0.15),
                  ),
                  child: Icon(Icons.home, color: greenStart),
                ),
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite_border),
                activeIcon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: greenStart.withOpacity(0.15),
                  ),
                  child: Icon(Icons.favorite, color: greenStart),
                ),
                label: 'Favoritos',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                activeIcon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: greenStart.withOpacity(0.15),
                  ),
                  child: Icon(Icons.person, color: greenStart),
                ),
                label: 'Perfil',
              ),
            ],
          ),
        ],
      ), 
    );
  }
}
