import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class CareTipArticle {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String readTime;
  final String imageUrl;
  final String author;
  final String date;
  final List<String> sections;

  const CareTipArticle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.readTime,
    required this.imageUrl,
    this.author = 'PlantCare Botanist',
    this.date = 'Updated recently',
    required this.sections,
  });
}

class CareTipDetailsScreen extends StatelessWidget {
  final CareTipArticle article;

  const CareTipDetailsScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // Parallax Hero Header with Image
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.35),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.35),
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border, color: Colors.white),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tip saved to bookmarks!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    article.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceVariant,
                      child: const Icon(Icons.lightbulb, size: 70, color: AppColors.primary),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.65),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Article Content Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.marginHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category tag & Read time
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryContainer,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          article.category,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSecondaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        article.readTime,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Article Headline
                  Text(
                    article.title,
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Subtitle & Author row
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.primaryContainer,
                        child: Icon(Icons.eco, size: 14, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${article.author} • ${article.date}',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Key Takeaways Callout Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceContainerHigh.withValues(alpha: 0.3)
                          : AppColors.secondaryContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.secondary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline, color: AppColors.secondary, size: 22),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            article.subtitle,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Article Paragraphs
                  ...article.sections.map((section) => Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Text(
                          section,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 15,
                            height: 1.6,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      )),

                  const SizedBox(height: 20),

                  // Feedback / Helpful button
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Thank you for your feedback! 🌱'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.thumb_up_alt_outlined, size: 18),
                      label: const Text('Was this tip helpful?'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
