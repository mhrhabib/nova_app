import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/app_radii.dart';

class LoadingShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const LoadingShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = AppRadii.md,
  });

  static Widget propertyCardShimmer(BuildContext context, {bool isList = false}) {
    if (isList) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            LoadingShimmer(width: 120, height: 120, borderRadius: AppRadii.md),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  LoadingShimmer(width: 100, height: 20),
                  SizedBox(height: 8),
                  LoadingShimmer(width: double.infinity, height: 16),
                  SizedBox(height: 8),
                  LoadingShimmer(width: 140, height: 14),
                  SizedBox(height: 12),
                  LoadingShimmer(width: 180, height: 14),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        LoadingShimmer(width: double.infinity, height: 160, borderRadius: AppRadii.lg),
        SizedBox(height: 12),
        LoadingShimmer(width: 120, height: 20),
        SizedBox(height: 8),
        LoadingShimmer(width: double.infinity, height: 16),
        SizedBox(height: 8),
        LoadingShimmer(width: 180, height: 14),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
