import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../data/app_state.dart';
import 'care_tip_details_screen.dart';

class CareTipsScreen extends StatefulWidget {
  const CareTipsScreen({super.key});

  @override
  State<CareTipsScreen> createState() => _CareTipsScreenState();
}

class _CareTipsScreenState extends State<CareTipsScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = const [
    'All',
    'Watering',
    'Sunlight',
    'Humidity',
    'Soil',
    'Pruning',
  ];

  static const CareTipArticle _featuredTip = CareTipArticle(
    id: 'tip-featured',
    title: 'How often should you water indoor plants?',
    subtitle: 'Understanding the soil soak-and-dry cycle to prevent root rot and leaf drop.',
    category: 'Watering',
    readTime: '5 min read',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDip-tV0zm_UWK6aStiVYTn5Mo2p2kpNOvp5qKgmsuH58gRe2GtoQFtto9uFfVRd1EidvNKjfY32KCWzCToazbi7gnn9fqSDBXnQ5oWSR3SsYHxNY5l1tLacQTuMExMxzLlGqgW7fpnXZ86wGwTY4dmRup6-k3GxV2G4iJ3taBTdNUFkz4muKc2xAHfO2i9ZXHMP1zFy_O40KJ5MgVdYC8nf4jSy39UuuGqo2K_YPnuBkzTGfamT_Ib',
    sections: [
      'Watering houseplants is one of the most common challenges for plant parents. The most effective rule of thumb is not sticking to a rigid calendar schedule, but checking the soil moisture before every watering.',
      '1. The Finger Test: Insert your index finger about two inches into the potting mix. If it feels cool and damp, hold off. If dry and crumbly, it is time to hydrate.',
      '2. Drainage is Essential: Always ensure your planter has drainage holes. Never let your plant sit in standing drainage saucer water for more than 30 minutes.',
      '3. Room Temperature Water: Cold tap water can shock tender tropical roots. Let tap water sit for a few hours so chlorine dissipates and it reaches room temperature.',
    ],
  );

  final List<CareTipArticle> _allTips = const [
    _featuredTip,
    CareTipArticle(
      id: 'tip-2',
      title: 'Signs of overwatering: Yellow leaves & root health',
      subtitle: 'Recognize the early symptoms before fungal damage sets in.',
      category: 'Watering',
      readTime: '3 min read',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCBJJEm2gx237SHvUX1WJyCiItl4umKG0Q7jP_YS279CJp1SyM6dHly_cCtNWKRtW3qWTl8BuLUc0N-l8hyTmrKyoPN-L8ExZySiXN2FzlhImIkSY6QWXWKbVH5YgcpeTQOLrLzcuiFEhHag7kLIRJp2T52L8dXgHI3_1HqZ2Iw7hNmbnDORCVOI71z29IDWDfyeSg7OWl14ddI5qmPB5_0DAXp2LAEmoFJjdjU2SNVr3pzcOx2Ih1Y',
      sections: [
        'Yellowing lower leaves combined with soft, mushy stems are classic distress signals of oversaturated roots.',
        'If detected early, gently lift the root ball out of the pot and allow it to breathe on paper towels for several hours before repotting with dry, airy soil.',
      ],
    ),
    CareTipArticle(
      id: 'tip-3',
      title: 'Finding the sweet spot: Indirect vs direct sun',
      subtitle: 'Where to place each species relative to your windows.',
      category: 'Sunlight',
      readTime: '4 min read',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD0WDjU2hOewm6R3tYNkGISMB_Q2jKZt5OYIhIGtlPrO9x1LLVVqYS7Z5CaItfQvnmkEhFdXxKP3YEEITwA2AbO_h-9y3JbhDyiaLfBFL2CjF72Fs6mTzeye0YSvr-uCUCWauQ1uVhtgPDXTefE52MpBXR2g8AjxUqVmf4geJoJdMJLc8zFkCTo8IhtEJFVaEWXQb_hd-RE7esqcruwqwQ_Sl1Tun7C_6LTg_E9YKPbxkc7BxKuDBRn',
      sections: [
        'Direct sun rays can scorch tender foliage like Monsteras and Ferns. Filter intense midday sun with sheer curtains.',
        'East-facing windows offer gentle morning rays ideal for almost all tropical foliage, while South-facing windows suit succulents and cacti.',
      ],
    ),
    CareTipArticle(
      id: 'tip-4',
      title: 'Humidity hacks: Pebble trays & grouping plants',
      subtitle: 'Boost ambient humidity without costly humidifiers.',
      category: 'Humidity',
      readTime: '3 min read',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDA2bHoYUouTg7vf38_5lPjPHtmXutZJMCgdmMiNgmZ36vW8A0Q9OnW433DQriGuIsoiYv7LPErsSR1I686b7uKKZ1l_bfiW2irsEzt9x61vUXhgCMYl7NMQ4MKWVYVTaaMk6cSU2mFhBMuSOw_E3gDe5Eh15Dju9u_7GfanfX_zkTbAV4X5VebE6phkDWhcVpHvsjsuEINOSw2zRXkVXpg72nkktAFfx697g7fDcuz8P9C09kH-X47',
      sections: [
        'Grouping several houseplants close together naturally creates a microclimate of elevated humidity through plant transpiration.',
        'Pebble trays filled with water below the pots provide consistent gentle evaporation without soaking the bottom roots.',
      ],
    ),
    CareTipArticle(
      id: 'tip-5',
      title: 'Aerating soil: Why your plant roots need oxygen',
      subtitle: 'Prevent compaction and improve water infiltration.',
      category: 'Soil',
      readTime: '2 min read',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCb3E6maTmpoxoBMcAgtolj_CiaW2ZYNw0H6yks8Wo7jcuEtNyW5UeIP2H8NpIIFAXdzNPxqGl-9nfnF6dOaow4yn0cOhmuLnn0ZjPywh4gnH3lfDrgGLTAqDKPAIGKOlPi5LDzeQW919aT-bjdaEP-pTE3FqHkJWrHnkDkMsaqiE86mxwYD82MbDovaJIwYoC-6cHX7qqXp2yB5ZOOIwCpfhfJrCtRU-pJLMfKNioquqlX0mXUB2cy',
      sections: [
        'Over time, repeated watering compacts potting soil, squeezing out oxygen pockets.',
        'Use a wooden chopstick to gently poke a few holes around the root zone once a month to let air and water penetrate evenly.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final user = appState.currentUser;
    final theme = Theme.of(context);

    final filteredTips = _allTips.where((t) {
      if (_selectedCategory == 'All') return true;
      return t.category == _selectedCategory;
    }).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Top Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppSizes.marginHorizontal,
                  right: AppSizes.marginHorizontal,
                  top: 20,
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryContainer,
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(user.avatarUrl, fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'PlantCare',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.psychology_outlined, color: AppColors.primary, size: 28),
                  ],
                ),
              ),
            ),

            // Page Title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.marginHorizontal,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Care Tips',
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Expert botanical advice for thriving greenery.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Category Chips
            SliverToBoxAdapter(
              child: SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.marginHorizontal,
                  ),
                  itemCount: _categories.length,
                  separatorBuilder: (_, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final isSelected = _selectedCategory == cat;

                    return InkWell(
                      onTap: () => setState(() => _selectedCategory = cat),
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : (theme.brightness == Brightness.dark
                                  ? AppColors.surfaceContainerHigh.withValues(alpha: 0.2)
                                  : AppColors.surfaceContainerHigh),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Featured Hero Card (Shown if 'All' or 'Watering' selected)
            if (_selectedCategory == 'All' || _selectedCategory == 'Watering')
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.marginHorizontal,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CareTipDetailsScreen(
                            article: _featuredTip,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: AppColors.cardShadow,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 180,
                            width: double.infinity,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  _featuredTip.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 12,
                                  left: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.95),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Text(
                                      'Featured Guide',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _featuredTip.title,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _featuredTip.subtitle,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 13,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Articles List
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.marginHorizontal,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final tip = filteredTips[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: AppColors.cardShadow,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CareTipDetailsScreen(article: tip),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  width: 64,
                                  height: 64,
                                  child: Image.network(
                                    tip.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.secondaryContainer.withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        tip.category,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.onSecondaryContainer,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      tip.title,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right, color: AppColors.outline),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: filteredTips.length,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 110)),
          ],
        ),
      ),
    );
  }
}
