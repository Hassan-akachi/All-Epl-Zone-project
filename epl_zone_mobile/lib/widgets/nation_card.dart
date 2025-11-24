// lib/widgets/nation_card.dart
import 'package:flutter/material.dart';

class NationCard extends StatelessWidget {
  final String countryName;
  final String flagEmoji;
  final VoidCallback? onTap;

  const NationCard({
    Key? key,
    required this.countryName,
    required this.flagEmoji,
    this.onTap,
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
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                flagEmoji,
                style: const TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 12),
              Text(
                countryName,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}