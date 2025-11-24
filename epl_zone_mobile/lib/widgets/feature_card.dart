import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'image_display.dart';

class FeatureCard extends StatelessWidget {
  final IconData? icon;
  final String? imageUrl;
  final bool isSvg;
  final String? backgroundImageUrl;
  final bool isBackgroundSvg;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    Key? key,
    this.icon,
    this.imageUrl,
    this.isSvg = false,
    this.backgroundImageUrl,
    this.isBackgroundSvg = false,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  Widget _buildContent(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ImageDisplay(
        imageUrl: imageUrl!,
        isSvg: isSvg,
      );
    } else if (icon != null) {
      return Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 32, color: Colors.white),
      );
    }
    return const SizedBox(width: 64, height: 64);
  }

  Decoration? _buildBackgroundDecoration() {
    if (backgroundImageUrl != null && backgroundImageUrl!.isNotEmpty) {
      // For SVG backgrounds, we can't use BoxDecoration directly
      // We'll handle SVG separately in the widget tree
      if (isBackgroundSvg) {
        return null;
      }

      // For non-SVG images, use ImageProvider in BoxDecoration
      final imageProvider = ImageDisplay.getImageProvider(backgroundImageUrl!, isBackgroundSvg);
      if (imageProvider != null) {
        return BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        );
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final hasSvgBackground = backgroundImageUrl != null &&
        backgroundImageUrl!.isNotEmpty &&
        isBackgroundSvg;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Background container with image or color
            Container(
              decoration: _buildBackgroundDecoration() ?? BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              // For SVG backgrounds, we overlay the SVG
              child: hasSvgBackground ? _buildSvgBackground() : null,
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildContent(context),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      shadows: backgroundImageUrl != null
                          ? [const Shadow(color: Colors.black54, blurRadius: 4)]
                          : null,
                      color: backgroundImageUrl != null
                          ? Colors.white
                          : null,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: backgroundImageUrl != null
                          ? Colors.white
                          : Colors.grey[600],
                      shadows: backgroundImageUrl != null
                          ? [const Shadow(color: Colors.black54, blurRadius: 2)]
                          : null,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build SVG background
  Widget _buildSvgBackground() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SvgPicture.asset(
        backgroundImageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}