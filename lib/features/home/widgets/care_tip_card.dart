import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../models/care_tip.dart';

class CareTipCard extends StatelessWidget {
  final CareTip tip;

  const CareTipCard({
    super.key,
    required this.tip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.tertiaryContainer.withValues(alpha: 0.5)
            : AppColors.tertiaryFixed,
        borderRadius: AppSizes.roundedCard,
      ),
      child: Stack(
        children: [
          // Background decorative watermark icon
          Positioned(
            right: -24,
            bottom: -24,
            child: Opacity(
              opacity: 0.08,
              child: Icon(
                Icons.psychology_outlined,
                size: 130,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lightbulb circle icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceContainerHigh : AppColors.surfaceBright,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lightbulb,
                  color: AppColors.tertiaryContainer,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),

              // Tip Title & Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tip.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : AppColors.tertiaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tip.content,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: isDark
                            ? AppColors.tertiaryFixedDim
                            : AppColors.onTertiaryFixedVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
