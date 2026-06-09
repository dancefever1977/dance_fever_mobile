/// Represents a news article displayed in the feed.
class NewsArticle {
  final String id;
  final String title;
  final String summary;
  final String category;
  final String source;
  final String author;
  final String timeAgo;
  final String imageUrl;
  final int readTimeMinutes;
  final bool isBookmarked;
  final bool isFeatured;

  const NewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
    required this.source,
    required this.author,
    required this.timeAgo,
    required this.imageUrl,
    this.readTimeMinutes = 5,
    this.isBookmarked = false,
    this.isFeatured = false,
  });

  NewsArticle copyWith({bool? isBookmarked}) {
    return NewsArticle(
      id: id,
      title: title,
      summary: summary,
      category: category,
      source: source,
      author: author,
      timeAgo: timeAgo,
      imageUrl: imageUrl,
      readTimeMinutes: readTimeMinutes,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isFeatured: isFeatured,
    );
  }

  /// Sample data for the news feed UI.
  static const List<NewsArticle> sampleArticles = [
    NewsArticle(
      id: '1',
      title: 'AI Revolution: How Machine Learning Is Transforming Healthcare',
      summary:
          'Groundbreaking AI models are now diagnosing diseases with accuracy surpassing human doctors, opening new frontiers in personalized medicine.',
      category: 'Technology',
      source: 'TechCrunch',
      author: 'Sarah Chen',
      timeAgo: '2h ago',
      imageUrl: 'tech_ai',
      readTimeMinutes: 8,
      isFeatured: true,
    ),
    NewsArticle(
      id: '2',
      title: 'Global Markets Rally as Central Banks Signal Rate Cuts',
      summary:
          'Stock markets worldwide surged after the Federal Reserve hinted at potential interest rate reductions in the coming quarter.',
      category: 'Business',
      source: 'Bloomberg',
      author: 'Michael Torres',
      timeAgo: '3h ago',
      imageUrl: 'business_markets',
      readTimeMinutes: 5,
    ),
    NewsArticle(
      id: '3',
      title: 'SpaceX Starship Completes Historic Orbital Flight',
      summary:
          'The world\'s most powerful rocket successfully completed its first full orbital mission, marking a new era in space exploration.',
      category: 'Science',
      source: 'NASA Daily',
      author: 'Dr. Amy Foster',
      timeAgo: '5h ago',
      imageUrl: 'science_space',
      readTimeMinutes: 6,
    ),
    NewsArticle(
      id: '4',
      title: 'Champions League Final: An Unforgettable Night in Istanbul',
      summary:
          'A dramatic penalty shootout decided the European championship in one of the most thrilling finals in tournament history.',
      category: 'Sports',
      source: 'ESPN',
      author: 'James Wright',
      timeAgo: '6h ago',
      imageUrl: 'sports_football',
      readTimeMinutes: 4,
    ),
    NewsArticle(
      id: '5',
      title: 'The Rise of Sustainable Fashion: Gen Z Leading the Change',
      summary:
          'Young consumers are driving a massive shift toward eco-conscious clothing brands, reshaping the entire fashion industry.',
      category: 'Lifestyle',
      source: 'Vogue',
      author: 'Emma Laurent',
      timeAgo: '8h ago',
      imageUrl: 'lifestyle_fashion',
      readTimeMinutes: 7,
    ),
    NewsArticle(
      id: '6',
      title: 'Climate Summit 2026: World Leaders Commit to Bold New Targets',
      summary:
          'Over 190 nations agreed to aggressive carbon reduction timelines at the landmark climate conference in Geneva.',
      category: 'World',
      source: 'Reuters',
      author: 'David Kim',
      timeAgo: '10h ago',
      imageUrl: 'world_climate',
      readTimeMinutes: 9,
    ),
    NewsArticle(
      id: '7',
      title: 'Breakthrough in Quantum Computing Promises Faster Drug Discovery',
      summary:
          'Researchers at MIT have demonstrated a quantum algorithm that could accelerate pharmaceutical research by decades.',
      category: 'Technology',
      source: 'Wired',
      author: 'Lisa Park',
      timeAgo: '12h ago',
      imageUrl: 'tech_quantum',
      readTimeMinutes: 6,
    ),
  ];
}
