// lib/widgets/team_card.dart
import 'package:epl_zone/widgets/image_display.dart';
import 'package:flutter/material.dart';

class TeamCard extends StatelessWidget {
  final String teamName;
  final String imageUrl;
  final bool isSvg; // Add this
  final VoidCallback? onTap;

  const TeamCard({
    Key? key,
    required this.teamName,
    this.onTap,
    required this.imageUrl,
    required this.isSvg, // Add this
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                // Remove the decoration and use ImageDisplay as child
                child: ImageDisplay(
                  imageUrl: imageUrl,
                  isSvg: isSvg,
                  width: 120,
                  height: 120,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                teamName,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}