import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/util/themes.dart';
import '../../domain/entities/news_article.dart';

class AINewsWidget extends StatelessWidget {
  final NewsArticle article;
  final double width, height;

  const AINewsWidget({
    required this.article,
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format date in a professional way
    final dateFormat = DateFormat('MMM d, yyyy');
    final formattedDate = article.publishedAt != null
        ? dateFormat.format(article.publishedAt!)
        : 'Unknown date';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        shadowColor: appShadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // TODO: Ajouter la navigation vers la page de détail de l'article
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section with rounded corners on top
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: article.urlToImage != null
                    ? Image.network(
                  article.urlToImage!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: appInputBackgroundColor,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: appTextSecondaryColor,
                          size: 40,
                        ),
                      ),
                    );
                  },
                )
                    : Container(
                  height: 180,
                  color: appInputBackgroundColor,
                  child: Center(
                    child: Icon(
                      Icons.article,
                      color: appTextSecondaryColor,
                      size: 40,
                    ),
                  ),
                ),
              ),

              // Content section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top info row (source and date)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Source chip
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: appPrimaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            article.sourceName ?? 'Unknown Source',
                            style: TextStyle(
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),

                        // Date with icon
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 12,
                              color: appTextSecondaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                color: appTextSecondaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Title
                    Text(
                      article.title ?? 'No Title',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: appTextPrimaryColor,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Description
                    Text(
                      article.description ?? 'No description available',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: appTextSecondaryColor,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 16),

                    // Bottom row with author and read more
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Author
                        if (article.author != null && article.author!.isNotEmpty && article.author != article.sourceName)
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: appPrimaryColor.withOpacity(0.2),
                                child: Icon(
                                  Icons.person,
                                  size: 16,
                                  color: appPrimaryColor,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                constraints: BoxConstraints(maxWidth: width * 0.4),
                                child: Text(
                                  article.author!,
                                  style: TextStyle(
                                    backgroundColor: appTextSecondaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),

                        // Read more button
                        TextButton.icon(
                          onPressed: () {
                            // TODO: Ajouter la navigation vers la page de détail de l'article
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 18,
                          ),
                          label: Text('Read More'),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            visualDensity: VisualDensity.compact,
                          ),
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