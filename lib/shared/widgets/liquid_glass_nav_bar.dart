import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class LiquidGlassNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const LiquidGlassNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  State<LiquidGlassNavBar> createState() => _LiquidGlassNavBarState();
}

class _LiquidGlassNavBarState extends State<LiquidGlassNavBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _iconControllers;

  final List<NavTabItem> _tabs = const [
    NavTabItem(label: 'Home', icon: Icons.home_rounded),
    NavTabItem(label: 'My Plants', icon: Icons.eco_rounded),
    NavTabItem(label: 'Calendar', icon: Icons.calendar_month_rounded),
    NavTabItem(label: 'Tips', icon: Icons.lightbulb_rounded),
    NavTabItem(label: 'Profile', icon: Icons.person_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _iconControllers = List.generate(
      _tabs.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 450),
      ),
    );

    // Animate the initially selected tab icon
    _iconControllers[widget.currentIndex].forward();
  }

  @override
  void didUpdateWidget(covariant LiquidGlassNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _iconControllers[oldWidget.currentIndex].reverse();
      _iconControllers[widget.currentIndex].forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    for (final controller in _iconControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.55)
                    : const Color(0xFF133E2B).withValues(alpha: 0.18),
                blurRadius: 30,
                spreadRadius: -2,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: isDark
                    ? AppColors.primary.withValues(alpha: 0.22)
                    : Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDark
                        ? [
                            const Color(0xFF222B25).withValues(alpha: 0.40),
                            const Color(0xFF131A15).withValues(alpha: 0.22),
                          ]
                        : [
                            Colors.white.withValues(alpha: 0.22),
                            Colors.white.withValues(alpha: 0.08),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.18)
                        : Colors.white.withValues(alpha: 0.70),
                    width: 1.2,
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final tabWidth = constraints.maxWidth / _tabs.length;
                    final pillPadding = 4.0;
                    final pillWidth = tabWidth - (pillPadding * 2);
                    final pillHeight = 54.0;

                    return Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        // Specular top highlight line (Apple liquid glass refraction)
                        Positioned(
                          top: 0,
                          left: 28,
                          right: 28,
                          height: 1.2,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withValues(alpha: 0.0),
                                  Colors.white.withValues(alpha: isDark ? 0.45 : 0.85),
                                  Colors.white.withValues(alpha: 0.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      // --- Liquid Glass Sliding Pill Background ---
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 380),
                        curve: Curves.easeOutBack,
                        left: (widget.currentIndex * tabWidth) + pillPadding,
                        top: (constraints.maxHeight - pillHeight) / 2,
                        width: pillWidth,
                        height: pillHeight,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: isDark
                                  ? [
                                      AppColors.primaryContainer.withValues(alpha: 0.35),
                                      AppColors.primary.withValues(alpha: 0.22),
                                    ]
                                  : [
                                      AppColors.secondaryContainer.withValues(alpha: 0.30),
                                      const Color(0xFFB5F2C8).withValues(alpha: 0.18),
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: isDark
                                  ? AppColors.primaryFixedDim.withValues(alpha: 0.25)
                                  : Colors.white.withValues(alpha: 0.60),
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? AppColors.primary.withValues(alpha: 0.15)
                                    : AppColors.secondaryContainer.withValues(alpha: 0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // --- Interactive Tab Items with Physics Animations ---
                    Row(
                      children: List.generate(_tabs.length, (index) {
                        final tab = _tabs[index];
                        final isSelected = widget.currentIndex == index;
                        final controller = _iconControllers[index];

                        return Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (widget.currentIndex != index) {
                                widget.onTabSelected(index);
                              }
                            },
                            child: SizedBox(
                              height: double.infinity,
                              child: _AnimatedTabContent(
                                index: index,
                                tab: tab,
                                isSelected: isSelected,
                                animation: controller,
                                isDark: isDark,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ),
  ),
);
}
}

class NavTabItem {
  final String label;
  final IconData icon;

  const NavTabItem({required this.label, required this.icon});
}

/// Content widget for each tab with custom top-level micro-animation per icon
class _AnimatedTabContent extends StatelessWidget {
  final int index;
  final NavTabItem tab;
  final bool isSelected;
  final AnimationController animation;
  final bool isDark;

  const _AnimatedTabContent({
    required this.index,
    required this.tab,
    required this.isSelected,
    required this.animation,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = isDark ? AppColors.primaryFixedDim : AppColors.primary;
    final inactiveColor = isDark ? const Color(0xFFB5C2B9) : const Color(0xFF46524A);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        Widget iconWidget;

        switch (index) {
          case 0:
            // Home: Bounce up and settle
            final bounce = math.sin(animation.value * math.pi) * -6.0;
            iconWidget = Transform.translate(
              offset: Offset(0, bounce),
              child: Transform.scale(
                scale: isSelected ? 1.0 + (0.15 * animation.value) : 1.0,
                child: Icon(
                  tab.icon,
                  size: 22,
                  color: isSelected ? activeColor : inactiveColor,
                ),
              ),
            );
            break;

          case 1:
            // My Plants: Leaf sprout sway (rotation + elastic pop)
            final sway = math.sin(animation.value * 2 * math.pi) * 0.18;
            iconWidget = Transform.rotate(
              angle: isSelected ? sway : 0.0,
              child: Transform.scale(
                scale: isSelected ? 1.0 + (0.2 * math.sin(animation.value * math.pi)) : 1.0,
                child: Icon(
                  tab.icon,
                  size: 22,
                  color: isSelected ? activeColor : inactiveColor,
                ),
              ),
            );
            break;

          case 2:
            // Calendar: 3D Flip pulse
            final flip = math.cos(animation.value * math.pi);
            iconWidget = Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateY(isSelected ? (1 - flip) * 0.4 : 0.0),
              child: Transform.scale(
                scale: isSelected ? 1.0 + (0.12 * animation.value) : 1.0,
                child: Icon(
                  tab.icon,
                  size: 22,
                  color: isSelected ? activeColor : inactiveColor,
                ),
              ),
            );
            break;

          case 3:
            // Tips: Lightbulb glow ray pulse
            final pulse = math.sin(animation.value * math.pi);
            iconWidget = Stack(
              alignment: Alignment.center,
              children: [
                if (isSelected && pulse > 0.05)
                  Opacity(
                    opacity: pulse * 0.45,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondaryContainer,
                      ),
                    ),
                  ),
                Transform.scale(
                  scale: isSelected ? 1.0 + (0.16 * pulse) : 1.0,
                  child: Icon(
                    tab.icon,
                    size: 22,
                    color: isSelected ? activeColor : inactiveColor,
                  ),
                ),
              ],
            );
            break;

          case 4:
          default:
            // Profile: Avatar badge zoom and ring halo
            final scale = isSelected
                ? 1.0 + (0.15 * math.sin(animation.value * math.pi))
                : 1.0;
            iconWidget = Transform.scale(
              scale: scale,
              child: Icon(
                tab.icon,
                size: 22,
                color: isSelected ? activeColor : inactiveColor,
              ),
            );
            break;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.1,
                color: isSelected ? activeColor : inactiveColor,
              ),
              child: Text(tab.label),
            ),
          ],
        );
      },
    );
  }
}
