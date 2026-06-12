import 'package:dance_fever/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/news_article.dart';
import '../../../../core/theme/app_colors.dart';

enum _Categories {
  All,
  Entertainment,
  Health,
  Politics,
  Business,
  Religion,
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // ── State ──
  int _selectedCategoryIndex = 0;
  int _bottomNavIndex = 0;
  final Set<String> _bookmarkedIds = {};

  List<NewsArticle> get _filteredArticles {
    final cat = _Categories.values[_selectedCategoryIndex].name;
    if (cat == 'All') return NewsArticle.sampleArticles;
    // Map the new categories to our sample data categories if needed,
    // or just filter directly. Our sample data has Business, but not Religion.
    return NewsArticle.sampleArticles.where((a) => a.category == cat).toList();
  }

  void _onCategoryTap(int index) {
    if (index == _selectedCategoryIndex) return;
    setState(() => _selectedCategoryIndex = index);
  }

  void _toggleBookmark(String id) {
    setState(() {
      if (_bookmarkedIds.contains(id)) {
        _bookmarkedIds.remove(id);
      } else {
        _bookmarkedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(authControllerProvider);
    // final isLoading = authState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──
            _buildAppBar(),

            // ── Search Bar ──
            _buildSearchBar(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Featured News (Horizontal List) ──
                    // _buildFeaturedNews(),

                    // ── Category List (Horizontal) ──
                    _buildCategoryChips(),

                    // ── Vertical Article List ──
                    _buildArticleList(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // ── Bottom Navigation Bar ──
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // ────────────────────────────────────────────────────────────────
  // App Bar
  // ────────────────────────────────────────────────────────────────
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Hamburger Menu
          const Icon(Icons.menu_rounded, color: AppColors.onSurface, size: 28),
          const SizedBox(width: 16),
          // Title
          const Text(
            'NEWS',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              color: AppColors.onSurface,
            ),
          ),
          const Spacer(),
          // Notification Bell with Badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications_none_rounded, color: AppColors.onSurface, size: 26),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.error, // Red dot
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.background, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Profile Icon
          IconButton(
            onPressed: () {},
            icon: IconButton(
              icon: const Icon(
                Icons.person_outline_rounded,
                color: AppColors.onSurface,
                size: 26,
              ),
              onPressed: () {
                ref.read(authControllerProvider.notifier).signOut();
              },
            ),
          ),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────────────────────
  // Search Bar
  // ────────────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Search..',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────────
  // Category Bar
  // ────────────────────────────────────────────────────────────────
  Widget _buildCategoryChips() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: SizedBox(
        height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _Categories.values.length,
          itemBuilder: (context, index) {
            final isSelected = index == _selectedCategoryIndex;
            return GestureDetector(
              onTap: () => _onCategoryTap(index),
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                padding: isSelected
                    ? const EdgeInsets.symmetric(horizontal: 12, vertical: 6)
                    : const EdgeInsets.symmetric(vertical: 6),
                decoration: isSelected
                    ? BoxDecoration(
                        color: AppColors.onSurface,
                        borderRadius: BorderRadius.circular(6),
                      )
                    : null,
                child: Text(
                  _Categories.values[index].name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected
                        ? AppColors
                              .surface // Dark text on light background
                        : AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────────
  // Article List
  // ────────────────────────────────────────────────────────────────
  Widget _buildArticleList() {
    // If filtering by a category that has no data, show sample data to avoid empty screen
    final articles = _filteredArticles.isEmpty
        ? NewsArticle.sampleArticles.where((a) => !a.isFeatured).toList()
        : _filteredArticles;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: articles.length,
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Divider(height: 1, color: AppColors.outlineVariant.withValues(alpha: 0.2)),
      ),
      itemBuilder: (context, index) {
        final article = articles[index];
        final isBookmarked = _bookmarkedIds.contains(article.id);
        return _buildArticleItem(article, isBookmarked);
      },
    );
  }

  Widget _buildArticleItem(NewsArticle article, bool isBookmarked) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Square Image Placeholder
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _getCategoryColor(article.category).withValues(alpha: 0.2),
          ),
          child: Center(
            child: Icon(
              Icons.article_rounded,
              color: _getCategoryColor(article.category),
              size: 32,
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              // Metadata Row (Time, Views, Actions)
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    article.timeAgo,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.visibility_outlined,
                    size: 14,
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '1200 views', // Hardcoded from image
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => _toggleBookmark(article.id),
                    child: Icon(
                      isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                      size: 18,
                      color: isBookmarked
                          ? AppColors.electricPurple
                          : AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.share_outlined,
                    size: 18,
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Technology':
        return const Color(0xFF6C63FF);
      case 'Business':
        return const Color(0xFF00C9A7);
      case 'Science':
        return const Color(0xFF3B82F6);
      case 'Sports':
        return const Color(0xFFF59E0B);
      case 'Lifestyle':
        return const Color(0xFFEC4899);
      case 'World':
        return const Color(0xFF10B981);
      default:
        return AppColors.electricPurple;
    }
  }

  // ────────────────────────────────────────────────────────────────
  // Bottom Navigation Bar
  // ────────────────────────────────────────────────────────────────
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.2))),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(0, Icons.home_filled),
              _buildNavItem(1, Icons.play_circle_outline_rounded),
              _buildNavItem(2, Icons.bookmark_border_rounded),
              _buildNavItem(3, Icons.grid_view_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    final isActive = _bottomNavIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _bottomNavIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 26,
            color: isActive
                ? AppColors.onSurface
                : AppColors.onSurfaceVariant.withValues(alpha: 0.4),
          ),
          if (isActive) ...[
            const SizedBox(height: 4),
            Container(
              width: 16,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.onSurface,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ] else ...[
            const SizedBox(height: 7),
          ],
        ],
      ),
    );
  }
}
