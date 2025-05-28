import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart'; // Ajoutez cette dépendance à votre pubspec.yaml
import '/features/ai_news/presentation/bloc/ai_news_events.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/util/themes.dart';
import '../bloc/ai_news_bloc.dart';
import '../bloc/ai_news_states.dart';
import '../widgets/news_article_card.dart';

class AINewsPage extends StatefulWidget {
  AINewsPage({Key? key}) : super(key: key);

  static const String routeName = 'AINewsPage';

  @override
  State<AINewsPage> createState() => _AINewsPageState();
}

class _AINewsPageState extends State<AINewsPage> {
  final ScrollController _scrollController = ScrollController();
  late double height, width;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        height = constraints.maxHeight;
        width = constraints.maxWidth;

        return BlocProvider(
          create: (BuildContext context) =>
          sl<AINewsBloc>()..add(GetAINewsEvent()),
          child: Scaffold(
            backgroundColor: appBackgroundColor,
            body: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<AINewsBloc>(context).add(GetAINewsEvent());
              },
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Custom App Bar
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AI Technology News",
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              color: appTextPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Stay updated with the latest in AI innovation",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: appTextSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Search bar (non-fonctionnel, juste pour le design)
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: appInputBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search for AI news...",
                                prefixIcon: Icon(Icons.search, color: appTextSecondaryColor),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Filtres de catégories
                          SizedBox(
                            height: 40,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                _buildCategoryChip("All", isSelected: true),
                                _buildCategoryChip("Machine Learning"),
                                _buildCategoryChip("Neural Networks"),
                                _buildCategoryChip("Robotics"),
                                _buildCategoryChip("Computer Vision"),
                                _buildCategoryChip("NLP"),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // En-tête section Trending
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Trending in AI",
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text("See all"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // News Content
                  BlocBuilder<AINewsBloc, AINewsState>(
                    builder: (context, state) {
                      if (state is GetAINewsSuccessState) {
                        if (state.articles.isEmpty) {
                          return SliverFillRemaining(
                            child: _buildEmptyState(),
                          );
                        }

                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) => AINewsWidget(
                                article: state.articles[index],
                                height: height,
                                width: width
                            ),
                            childCount: state.articles.length,
                          ),
                        );
                      } else if (state is GetAINewsErrorState) {
                        return SliverFillRemaining(
                          child: _buildErrorState(context, state.message),
                        );
                      }

                      // Loading state with shimmer effect
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) => _buildShimmerLoading(),
                          childCount: 5,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(label),
        backgroundColor: appChipBackgroundColor,
        selectedColor: appPrimaryColor.withOpacity(0.15),
        checkmarkColor: appPrimaryColor,
        labelStyle: TextStyle(
          color: isSelected ? appPrimaryColor : appTextPrimaryColor,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        onSelected: (bool selected) {
          // Logique de filtrage à implémenter
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.article_outlined,
            size: 80,
            color: appChipBackgroundColor,
          ),
          const SizedBox(height: 16),
          Text(
            'No Articles Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: appTextPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We couldn\'t find any articles matching your criteria',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: appTextSecondaryColor,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              BlocProvider.of<AINewsBloc>(context).add(GetAINewsEvent());
            },
            icon: Icon(Icons.refresh),
            label: Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Something Went Wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: appTextPrimaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: appTextSecondaryColor,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                BlocProvider.of<AINewsBloc>(context).add(GetAINewsEvent());
              },
              icon: Icon(Icons.refresh),
              label: Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: appChipBackgroundColor,
        highlightColor: Colors.white,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),

              // Content placeholder
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Source and date row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 20,
                          color: Colors.white,
                        ),
                        Container(
                          width: 80,
                          height: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Title placeholder
                    Container(
                      width: double.infinity,
                      height: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: width * 0.7,
                      height: 24,
                      color: Colors.white,
                    ),

                    const SizedBox(height: 8),

                    // Description placeholder
                    Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: width * 0.8,
                      height: 16,
                      color: Colors.white,
                    ),

                    const SizedBox(height: 16),

                    // Bottom row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 24,
                          color: Colors.white,
                        ),
                        Container(
                          width: 80,
                          height: 24,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}