// lib/app_shell.dart
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
      bottomNavigationBar: BottomNavigationBar(
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

      // Posiciona o botão no canto inferior direito, flutuando acima da tab bar
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 1, bottom:1),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [greenStart, greenEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.add, size: 28, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/create'),
          ),
        ),
      ),
    );
  }
}
