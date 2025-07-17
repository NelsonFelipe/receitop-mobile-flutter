// lib/features/profile/widgets/profile_avatar.dart
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const ProfileAvatar({
    Key? key,
    required this.imageUrl,
    this.radius = 70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + 4,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: radius,
        backgroundImage: imageUrl.startsWith('http')
            ? NetworkImage(imageUrl)
            : AssetImage(imageUrl) as ImageProvider,
        backgroundColor: Colors.grey.shade200,
      ),
    );
  }
}
  