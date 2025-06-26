import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/features/discover/widgets/app_bar_discover.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _bannerController;
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  late Animation<double> _bannerAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shimmerAnimation;

  double _scrollOffset = 0.0;
  bool _showFloatingHeader = false;
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'All',
    'Study',
    'Entertainment',
    'Science',
    'Art',
    'Music'
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _bannerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _bannerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bannerController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    _scrollController.addListener(_onScroll);

    // Start animations
    _bannerController.forward();
    _pulseController.repeat(reverse: true);
    _shimmerController.repeat();
    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeController.forward();
    });
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
      _showFloatingHeader = _scrollOffset > 150;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bannerController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBarDiscover(),
      body: Stack(
        children: [
          // Animated background
          _buildAnimatedBackground(),

          // Main scrollable content
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Categories
              SliverToBoxAdapter(
                child: _buildCategoriesSection(width, height),
              ),

              // Animated Good Morning Banner
              SliverToBoxAdapter(
                child: AnimatedBuilder(
                  animation: _bannerAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 50 * (1 - _bannerAnimation.value)),
                      child: Transform.scale(
                        scale: 0.8 + (0.2 * _bannerAnimation.value),
                        child: Opacity(
                          opacity: _bannerAnimation.value.clamp(0.0, 1.0),
                          child: _buildAnimatedBanner(width, height),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Animated content sections
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.02),
                      _buildAnimatedSection(
                        'Partner collections',
                        _buildPartnerCollections(width, height),
                        0,
                      ),
                      SizedBox(height: height * 0.025),
                      _buildAnimatedSection(
                        'Trending Topics',
                        _buildTopicSection(width, height),
                        100,
                      ),
                      SizedBox(height: height * 0.025),
                      _buildAnimatedSection(
                        '',
                        _buildWikipediaCard(width, height),
                        200,
                      ),
                      SizedBox(height: height * 0.025),
                      _buildAnimatedSection(
                        'Explore DICE Studio',
                        _buildStudioSection(width, height),
                        300,
                      ),
                      SizedBox(height: height * 0.025),
                      _buildAnimatedSection(
                        'Featured Content',
                        _buildFeaturedSection(width, height),
                        350,
                      ),
                      SizedBox(height: height * 0.025),
                      _buildAnimatedSection(
                        'Top picks',
                        _buildTopPicks(width, height),
                        400,
                      ),
                      SizedBox(height: height * 0.025),
                      _buildAnimatedSection(
                        'Daily Challenges',
                        _buildDailyChallenges(width, height),
                        450,
                      ),
                      SizedBox(height: height * 0.025),
                      _buildAnimatedSection(
                        'Premium collection',
                        _buildPremiumCollection(width, height),
                        500,
                      ),
                      SizedBox(height: height * 0.025),
                      _buildAnimatedSection(
                        'Live Sessions',
                        _buildLiveSessions(width, height),
                        550,
                      ),
                      SizedBox(height: height * 0.025),
                      _buildAnimatedSection(
                        '',
                        _buildExamSection(
                          'Exam preparation by Experts',
                          'Comprehensive study materials prepared by top educators for your success',
                          [
                            {
                              'title': 'Advanced Mathematics',
                              'color': Colors.orange,
                              'author': 'Dr. Smith ⭐',
                              'students': '2.5k',
                              'rating': '4.9'
                            },
                            {
                              'title': 'Physics Mastery',
                              'color': Colors.purple,
                              'author': 'Prof. Johnson ⭐',
                              'students': '1.8k',
                              'rating': '4.8'
                            },
                          ],
                          width,
                          height,
                        ),
                        600,
                      ),
                      SizedBox(height: height * 0.025),
                      _buildAnimatedSection(
                        '',
                        _buildExamSection(
                          'Language Learning Hub',
                          'Master new languages with interactive lessons and native speakers',
                          [
                            {
                              'title': 'English Fluency',
                              'color': Colors.teal,
                              'author': 'Native Speaker ⭐',
                              'students': '5.2k',
                              'rating': '4.9'
                            },
                            {
                              'title': 'Spanish Basics',
                              'color': Colors.red,
                              'author': 'María García ⭐',
                              'students': '3.1k',
                              'rating': '4.7'
                            },
                          ],
                          width,
                          height,
                        ),
                        650,
                      ),
                      SizedBox(height: height * 0.025),
                      _buildAnimatedSection(
                        'Achievement Showcase',
                        _buildAchievementSection(width, height),
                        700,
                      ),
                      SizedBox(height: height * 0.1),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating header that appears on scroll
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: _showFloatingHeader ? 0 : -100,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.background.withOpacity(0.95),
                    AppColors.background.withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.explore, color: AppColors.purple, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Discover',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Floating action buttons
          _buildFloatingActions(width, height),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topRight,
              radius: 1.5 * _pulseAnimation.value,
              colors: [
                AppColors.purple.withOpacity(0.05),
                Colors.transparent,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchSection(double width, double height) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, -30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: EdgeInsets.all(width * 0.04),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for DICEs, topics, creators...',
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey.shade600),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.purple, Colors.pinkAccent],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.purple.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          HapticFeedback.lightImpact();
                        },
                        child: Icon(Icons.tune, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoriesSection(double width, double height) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(-50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: height * 0.02),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedCategoryIndex;
                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25),
                              onTap: () {
                                setState(() {
                                  _selectedCategoryIndex = index;
                                });
                                HapticFeedback.selectionClick();
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? const LinearGradient(colors: [
                                          AppColors.purple,
                                          Colors.pinkAccent
                                        ])
                                      : null,
                                  color:
                                      isSelected ? null : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: AppColors.purple
                                                .withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Text(
                                  _categories[index],
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedBanner(double width, double height) {
    final parallaxOffset = _scrollOffset * 0.3;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      height: height * 0.15,
      child: Stack(
        children: [
          // Background with parallax effect
          Transform.translate(
            offset: Offset(0, -parallaxOffset),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF8B5CF6),
                    Color(0xFF3B82F6),
                    Color(0xFF10B981),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF8B5CF6).withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),
          // Shimmer effect
          AnimatedBuilder(
            animation: _shimmerAnimation,
            builder: (context, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.white.withOpacity(0.2),
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.5, 1.0],
                      begin: Alignment(_shimmerAnimation.value - 1, 0),
                      end: Alignment(_shimmerAnimation.value, 0),
                    ),
                  ),
                ),
              );
            },
          ),
          // Content
          Container(
            padding: EdgeInsets.all(width * 0.04),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 1000),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(-30 * (1 - value), 0),
                            child: Opacity(
                              opacity: value,
                              child: Text(
                                'Good Morning! 🌅',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.06,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins-normal',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 1200),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(-30 * (1 - value), 0),
                            child: Opacity(
                              opacity: value,
                              child: Text(
                                'Ready to explore amazing content?',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: width * 0.035,
                                  fontFamily: 'poppins-normal',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 8),
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 1400),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.trending_up,
                                      color: Colors.white, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    '25+ New DICEs Today',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: width * 0.18,
                        height: width * 0.18,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.explore,
                          color: Colors.white,
                          size: width * 0.1,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSection(String title, Widget content, int delay) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Column(
              children: [
                if (title.isNotEmpty)
                  _buildSectionHeader(
                      title, 'See all', MediaQuery.of(context).size.width),
                if (title.isNotEmpty)
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                content,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPartnerCollections(double width, double height) {
    final partners = [
      {'name': 'Harvard', 'color': Colors.red, 'icon': Icons.school},
      {'name': 'MIT', 'color': Colors.blue, 'icon': Icons.science},
      {'name': 'Stanford', 'color': Colors.green, 'icon': Icons.psychology},
      {'name': 'Oxford', 'color': Colors.purple, 'icon': Icons.library_books},
      {'name': 'Yale', 'color': Colors.orange, 'icon': Icons.account_balance},
      {'name': 'Cambridge', 'color': Colors.teal, 'icon': Icons.hub},
    ];

    return SizedBox(
      height: height * 0.12,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        itemCount: partners.length,
        itemBuilder: (context, index) {
          final partner = partners[index];
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 300 + (index * 100)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            HapticFeedback.lightImpact();
                          },
                          borderRadius: BorderRadius.circular(height * 0.04),
                          child: Container(
                            width: height * 0.08,
                            height: height * 0.08,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  partner['color'] as Color,
                                  (partner['color'] as Color).withOpacity(0.7),
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.circular(height * 0.04),
                              boxShadow: [
                                BoxShadow(
                                  color: (partner['color'] as Color)
                                      .withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              partner['icon'] as IconData,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        partner['name'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTopicSection(double width, double height) {
    return Container(
      height: height * 0.16,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        itemCount: 4,
        itemBuilder: (context, index) {
          final topics = [
            {
              'title': 'Dice',
              'subtitle': 'What are we doing?',
              'color': const LinearGradient(
                colors: [Color(0xFF7C3AED), Color(0xFF10B981)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              'number': '1',
              'tag': 'Free',
              'participants': '2.1k'
            },
            {
              'title': 'Dice',
              'subtitle': 'What are we doing?',
              'color': const LinearGradient(
                colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              'number': '2',
              'tag': 'Free',
              'participants': '1.8k'
            },
            {
              'title': 'Dice',
              'subtitle': 'What are we doing?',
              'color': const LinearGradient(
                colors: [Color(0xFF7C2D12), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              'number': '3',
              'tag': 'Free',
              'participants': '1.5k'
            },
            {
              'title': 'Dice',
              'subtitle': 'What are we doing?',
              'color': const LinearGradient(
                colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              'number': '4',
              'tag': 'Premium',
              'participants': '892'
            },
          ];
          final topic = topics[index];

          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 500 + (index * 150)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(50 * (1 - value), 0),
                child: Opacity(
                  opacity: value,
                  child: Container(
                    width: width * 0.85,
                    margin: EdgeInsets.only(right: 12),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          _showTopicDetails(topic);
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: topic['color'] as LinearGradient,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Main content
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    // Left icon area
                                    Hero(
                                      tag: 'topic_${topic['number']}',
                                      child: Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                            color:
                                                Colors.white.withOpacity(0.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: _getTopicIcon(index),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    // Text content
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            topic['title'] as String,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'poppins-normal',
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            topic['subtitle'] as String,
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                              fontSize: 14,
                                              fontFamily: 'poppins-normal',
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              TweenAnimationBuilder<double>(
                                                duration: Duration(
                                                    milliseconds:
                                                        1000 + (index * 200)),
                                                tween:
                                                    Tween(begin: 0.0, end: 1.0),
                                                builder:
                                                    (context, value, child) {
                                                  return Transform.scale(
                                                    scale: value,
                                                    child: Icon(Icons.people,
                                                        color: Colors.white,
                                                        size: 14),
                                                  );
                                                },
                                              ),
                                              SizedBox(width: 6),
                                              Text(
                                                '${topic['participants']} participants',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  fontSize: 12,
                                                  fontFamily: 'poppins-normal',
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(Icons.circle,
                                                  color: Colors.white, size: 8),
                                              SizedBox(width: 6),
                                              Text(
                                                'Nobody ✓',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  fontSize: 12,
                                                  fontFamily: 'poppins-normal',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Right side number
                                    Text(
                                      topic['number'] as String,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.2),
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'poppins-normal',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Tag
                              Positioned(
                                top: 16,
                                right: 16,
                                child: TweenAnimationBuilder<double>(
                                  duration: Duration(
                                      milliseconds: 800 + (index * 100)),
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  builder: (context, value, child) {
                                    return Transform.scale(
                                      scale: value,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: topic['tag'] == 'Premium'
                                              ? Colors.amber.withOpacity(0.9)
                                              : Colors.white.withOpacity(0.9),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (topic['tag'] == 'Premium')
                                              Icon(Icons.star,
                                                  color: Colors.white,
                                                  size: 12),
                                            if (topic['tag'] == 'Premium')
                                              SizedBox(width: 4),
                                            Text(
                                              topic['tag'] as String,
                                              style: TextStyle(
                                                color: topic['tag'] == 'Premium'
                                                    ? Colors.white
                                                    : Colors.black87,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _getTopicIcon(int index) {
    final icons = [
      Icons.mic,
      Icons.code,
      Icons.speaker,
      Icons.music_note,
    ];

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1000 + (index * 200)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.5 + (0.5 * value),
          child: Icon(
            icons[index],
            color: Colors.white,
            size: 28,
          ),
        );
      },
    );
  }

  Widget _buildWikipediaCard(double width, double height) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF059669), Color(0xFF10B981)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Wikipedia',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'poppins-normal',
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'VERIFIED',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                '1,247 Educational DICEs',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                  fontFamily: 'poppins-normal',
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.trending_up,
                                      color: Colors.white, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    '+50 this week',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 12,
                                      fontFamily: 'poppins-normal',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 1200),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) {
                            return Transform.rotate(
                              angle: 0.1 * value,
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  Icons.menu_book,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStudioSection(double width, double height) {
    final studios = [
      {
        'icon': Icons.headphones,
        'color': Colors.orange,
        'title': 'Audio',
        'count': '245'
      },
      {
        'icon': Icons.theater_comedy,
        'color': Colors.blue,
        'title': 'Comedy',
        'count': '189'
      },
      {
        'icon': Icons.science,
        'color': Colors.teal,
        'title': 'Science',
        'count': '367'
      },
      {
        'icon': Icons.palette,
        'color': Colors.pink,
        'title': 'Art',
        'count': '156'
      },
    ];

    return SizedBox(
      height: height * 0.14,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        itemCount: studios.length,
        itemBuilder: (context, index) {
          final studio = studios[index];

          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 600 + (index * 200)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: width * 0.28,
                  margin: EdgeInsets.only(right: 12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              studio['color'] as Color,
                              (studio['color'] as Color).withOpacity(0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  (studio['color'] as Color).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                studio['icon'] as IconData,
                                color: Colors.white,
                                size: 32,
                              ),
                              SizedBox(height: 8),
                              Text(
                                studio['title'] as String,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${studio['count']} DICEs',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFeaturedSection(double width, double height) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      height: height * 0.2,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF6366F1).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => HapticFeedback.mediumImpact(),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'FEATURED',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Weekly Challenge',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Join 5K+ learners',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.emoji_events,
                                color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Win prizes!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => HapticFeedback.lightImpact(),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.local_fire_department,
                                  color: Colors.white, size: 24),
                              SizedBox(height: 4),
                              Text(
                                'Hot\nTopics',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => HapticFeedback.lightImpact(),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.leaderboard,
                                  color: Colors.white, size: 24),
                              SizedBox(height: 4),
                              Text(
                                'Leader\nboard',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPicks(double width, double height) {
    return SizedBox(
      height: height * 0.28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        itemCount: 3,
        itemBuilder: (context, index) {
          final picks = [
            {
              'title': 'Digital Art Mastery',
              'color': Colors.purple,
              'subtitle': 'Creative Design',
              'tag': 'Trending',
              'rating': '4.9',
              'students': '1.2k'
            },
            {
              'title': 'Modern Photography',
              'color': Colors.indigo,
              'subtitle': 'Visual Arts',
              'tag': 'Popular',
              'rating': '4.8',
              'students': '980'
            },
            {
              'title': 'AI & Machine Learning',
              'color': Colors.green,
              'subtitle': 'Technology',
              'tag': 'New',
              'rating': '4.7',
              'students': '756'
            },
          ];
          final pick = picks[index];

          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 700 + (index * 250)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: Container(
                    width: width * 0.45,
                    margin: EdgeInsets.only(right: 12),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                pick['color'] as Color,
                                (pick['color'] as Color).withOpacity(0.7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    (pick['color'] as Color).withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        pick['tag'] as String,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.white, size: 14),
                                        SizedBox(width: 2),
                                        Text(
                                          pick['rating'] as String,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  pick['title'] as String,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'poppins-normal',
                                  ),
                                ),
                                Text(
                                  pick['subtitle'] as String,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 12,
                                    fontFamily: 'poppins-normal',
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.people,
                                        color: Colors.white, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      '${pick['students']} students',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 10,
                                        fontFamily: 'poppins-normal',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDailyChallenges(double width, double height) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      height: height * 0.12,
      child: Row(
        children: List.generate(3, (index) {
          final challenges = [
            {
              'title': 'Math Quiz',
              'time': '5 min',
              'points': '50 pts',
              'color': Colors.blue
            },
            {
              'title': 'Word Puzzle',
              'time': '3 min',
              'points': '30 pts',
              'color': Colors.orange
            },
            {
              'title': 'Memory Game',
              'time': '2 min',
              'points': '25 pts',
              'color': Colors.green
            },
          ];
          final challenge = challenges[index];

          return Expanded(
            child: TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 600 + (index * 200)),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    margin: EdgeInsets.only(right: index == 2 ? 0 : 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          challenge['color'] as Color,
                          (challenge['color'] as Color).withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: (challenge['color'] as Color).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => HapticFeedback.lightImpact(),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                challenge['title'] as String,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                challenge['time'] as String,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                challenge['points'] as String,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPremiumCollection(double width, double height) {
    return SizedBox(
      height: height * 0.14,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        itemCount: 4,
        itemBuilder: (context, index) {
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 500 + (index * 150)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: 0.8 + (0.2 * value),
                child: Container(
                  width: width * 0.28,
                  margin: EdgeInsets.only(right: 12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade800,
                              Colors.grey.shade700,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.lock,
                                      color: Colors.white, size: 24),
                                  SizedBox(height: 4),
                                  Text(
                                    'Premium',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLiveSessions(double width, double height) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      height: height * 0.16,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE91E63), Color(0xFF9C27B0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE91E63).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => HapticFeedback.mediumImpact(),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 8),
                          Text(
                            'LIVE NOW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Interactive Sessions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Join live discussions with experts',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.people, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '1,247 viewers',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementSection(double width, double height) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFB800), Color(0xFFFF8A00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFFB800).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Progress 🏆',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Complete daily challenges to unlock rewards',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildAchievementItem(
                    'Streak', '7 days', Icons.local_fire_department),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildAchievementItem('Points', '2,450', Icons.star),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildAchievementItem('Rank', '#42', Icons.leaderboard),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActions(double width, double height) {
    return Positioned(
      bottom: 100,
      right: 20,
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1500),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: FloatingActionButton(
                  heroTag: 'search_fab',
                  mini: true,
                  backgroundColor: AppColors.purple,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                  },
                  child: Icon(Icons.search, color: Colors.white),
                ),
              );
            },
          ),
          SizedBox(height: 12),
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1700),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: FloatingActionButton(
                  heroTag: 'bookmark_fab',
                  mini: true,
                  backgroundColor: Colors.orange,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                  },
                  child: Icon(Icons.bookmark, color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'poppins-normal',
              color: AppColors.black,
            ),
          ),
          if (action.isNotEmpty)
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  HapticFeedback.lightImpact();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        action,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.purple,
                          fontFamily: 'poppins-normal',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: AppColors.purple,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExamSection(String title, String description,
      List<Map<String, dynamic>> items, double width, double height) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFFDB2777)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF8B5CF6).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TweenAnimationBuilder<double>(
                                duration: Duration(milliseconds: 800 + 200),
                                tween: Tween(begin: 0.0, end: 1.0),
                                builder: (context, titleValue, child) {
                                  return Transform.translate(
                                    offset: Offset(-30 * (1 - titleValue), 0),
                                    child: Opacity(
                                      opacity: titleValue,
                                      child: Text(
                                        title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'poppins-normal',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.verified,
                                      color: Colors.white, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    'CERTIFIED',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 800 + 400),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, descValue, child) {
                            return Transform.translate(
                              offset: Offset(-30 * (1 - descValue), 0),
                              child: Opacity(
                                opacity: descValue,
                                child: Text(
                                  description,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                    fontFamily: 'poppins-normal',
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: items.asMap().entries.map((entry) {
                            final index = entry.key;
                            final item = entry.value;
                            return Expanded(
                              child: TweenAnimationBuilder<double>(
                                duration: Duration(
                                    milliseconds: 1000 + (index * 300)),
                                tween: Tween(begin: 0.0, end: 1.0),
                                builder: (context, itemValue, child) {
                                  return Transform.translate(
                                    offset: Offset(0, 30 * (1 - itemValue)),
                                    child: Opacity(
                                      opacity: itemValue,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: items.last == item ? 0 : 12),
                                        height: height * 0.18,
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              HapticFeedback.lightImpact();
                                            },
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    item['color'] as Color,
                                                    (item['color'] as Color)
                                                        .withOpacity(0.8),
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        (item['color'] as Color)
                                                            .withOpacity(0.3),
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 5),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TweenAnimationBuilder<
                                                            double>(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  1200 +
                                                                      (index *
                                                                          200)),
                                                          tween: Tween(
                                                              begin: 0.0,
                                                              end: 1.0),
                                                          builder: (context,
                                                              tagValue, child) {
                                                            return Transform
                                                                .scale(
                                                              scale: tagValue,
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            4),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                child: Text(
                                                                  'Course',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        if (item['rating'] !=
                                                            null)
                                                          Row(
                                                            children: [
                                                              Icon(Icons.star,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 12),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(
                                                                item['rating']
                                                                    as String,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      item['title'] as String,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'poppins-normal',
                                                      ),
                                                    ),
                                                    SizedBox(height: 4),
                                                    if (item['students'] !=
                                                        null)
                                                      Row(
                                                        children: [
                                                          Icon(Icons.people,
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.8),
                                                              size: 12),
                                                          SizedBox(width: 4),
                                                          Text(
                                                            '${item['students']} students',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontSize: 10,
                                                              fontFamily:
                                                                  'poppins-normal',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        TweenAnimationBuilder<
                                                            double>(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  1400 +
                                                                      (index *
                                                                          200)),
                                                          tween: Tween(
                                                              begin: 0.0,
                                                              end: 1.0),
                                                          builder: (context,
                                                              avatarValue,
                                                              child) {
                                                            return Transform
                                                                .scale(
                                                              scale:
                                                                  avatarValue,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 8,
                                                                backgroundColor:
                                                                    Colors.white
                                                                        .withOpacity(
                                                                            0.3),
                                                                child: Icon(
                                                                    Icons
                                                                        .person,
                                                                    size: 10,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          item['author']
                                                              as String,
                                                          style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize: 10,
                                                            fontFamily:
                                                                'poppins-normal',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showTopicDetails(Map<String, dynamic> topic) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic['title'] as String,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      topic['subtitle'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.people,
                            color: Colors.grey.shade600, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '${topic['participants']} participants',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        HapticFeedback.mediumImpact();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.purple,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Join Topic',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
