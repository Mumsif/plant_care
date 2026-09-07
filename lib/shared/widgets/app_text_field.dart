import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool autofocus;

  const AppTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onClear,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceContainerHigh.withValues(alpha: 0.15)
            : AppColors.surfaceContainerHigh,
        borderRadius: AppSizes.roundedLg,
      ),
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        onChanged: onChanged,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontSize: 14,
          color: theme.colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.outline,
            fontSize: 14,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
