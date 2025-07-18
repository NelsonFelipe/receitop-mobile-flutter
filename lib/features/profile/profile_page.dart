// lib/features/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'profile_controller.dart';
import 'widgets/profile_avatar.dart';
import 'widgets/profile_stat_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileController>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<ProfileController>();

    return Scaffold(
      body: ctrl.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ctrl.error != null
              ? Center(child: Text('Erro: ${ctrl.error}'))
              : Column(
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
                    imageUrl: 'assets/images/profile_pic.png',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 56), 

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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                
                ProfileStatCard(label: 'Favoritas', value: ctrl.favoritesCount),
              ],
            ),
          ),

          const SizedBox(height: 32),

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
