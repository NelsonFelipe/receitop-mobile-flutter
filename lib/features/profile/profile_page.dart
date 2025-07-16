// lib/features/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'profile_controller.dart';
import 'widgets/profile_avatar.dart';
import 'widgets/profile_stat_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<ProfileController>();

    // Carrega perfil ao abrir
    if (ctrl.name.isEmpty) {
      context.read<ProfileController>().loadProfile();
    }

    return Scaffold(
      body: Column(
        children: [
          // ─── Header com gradiente ─────────────────────────
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreenAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Avatar
                Positioned(
                  bottom: -48,
                  child: ProfileAvatar(
                    imageUrl: 'https://i.pinimg.com/736x/6e/64/82/6e64827f0b16635cc489720d5216ab66.jpg',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 56), // espaço para o avatar sobreposto

          // ─── Nome e e‑mail ────────────────────────────────
          Text(
            ctrl.name,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ctrl.email,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 24),

          // ─── Estatísticas ─────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ProfileStatCard(label: 'Receitas', value: ctrl.recipesCount),
                ProfileStatCard(label: 'Favoritas', value: ctrl.favoritesCount),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ─── Ações do usuário ─────────────────────────────
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text('Sair', style: GoogleFonts.inter()),
                  onTap: () {/* TODO */},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
