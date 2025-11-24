import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageDisplay extends StatelessWidget {
  final String imageUrl;
  final bool isSvg;
  final double? width;
  final double? height;

  const ImageDisplay({
    super.key,
    required this.imageUrl,
    required this.isSvg,
    this.width,
    this.height,
  });

  // Static method to get ImageProvider for use in BoxDecoration
  static ImageProvider? getImageProvider(String imageUrl, bool isSvg) {
    if (imageUrl.startsWith('http')) {
      // For network images
      return CachedNetworkImageProvider(imageUrl.split('?').first);
    } else if (isSvg) {
      // Note: SVG cannot be used directly as ImageProvider in BoxDecoration
      // We'll return null and handle SVG differently
      return null;
    } else {
      // For local PNG/JPG
      return AssetImage(imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double w = width ?? 50;
    final double h = height ?? 50;

    // Network Image
    if (imageUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imageUrl.split('?').first,
        width: w,
        height: h,
        alignment: Alignment.center,
        placeholder: (_, __) => const ColoredBox(color: Color(0xffedecec)),
      );
    }

    // Local SVG
    if (isSvg) {
      return SvgPicture.asset(
        imageUrl,
        width: w,
        height: h,
        alignment: Alignment.center,
        color: null, // Added to prevent color blendi
      );
    }

    // Local PNG/JPG
    return Image.asset(
      imageUrl,
      width: w,
      height: h,
      alignment: Alignment.center,
    );
  }
}