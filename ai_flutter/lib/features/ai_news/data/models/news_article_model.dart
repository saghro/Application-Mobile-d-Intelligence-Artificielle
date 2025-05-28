import '../../domain/entities/news_article.dart';
import 'dart:developer';

class NewsArticleModel extends NewsArticle {
  const NewsArticleModel({
    required super.sourceName,
    required super.author,
    required super.title,
    required super.description,
    required super.url,
    required super.urlToImage,
    required super.content,
    required super.publishedAt
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    try {
      log("Parsing article: ${json["title"]}");

      // Vérification de tous les champs
      final sourceMap = json["source"];
      final String? sourceName = sourceMap is Map<String, dynamic> ? sourceMap["name"] : null;
      final String? title = json["title"];
      final String? description = json["description"];
      final String? url = json["url"];
      final String? image = json["image"]; // GNews utilise "image" au lieu de "urlToImage"
      final String? content = json["content"];

      // Traitement de la date
      DateTime? publishedAt;
      if (json["publishedAt"] != null) {
        try {
          publishedAt = DateTime.parse(json["publishedAt"]);
        } catch (e) {
          log("Erreur de parsing de la date: ${e.toString()}");
          publishedAt = DateTime.now();
        }
      } else {
        publishedAt = DateTime.now();
      }

      return NewsArticleModel(
        sourceName: sourceName ?? "Source inconnue",
        title: title ?? "Pas de titre",
        author: sourceName ?? "Auteur inconnu", // GNews ne fournit pas toujours l'auteur
        description: description ?? "Pas de description",
        url: url ?? "",
        urlToImage: image, // GNews utilise "image" au lieu de "urlToImage"
        content: content ?? "Pas de contenu",
        publishedAt: publishedAt,
      );
    } catch (e) {
      log("Erreur lors du parsing de l'article: ${e.toString()}");
      log("JSON problématique: $json");

      // Retourner un article par défaut en cas d'erreur
      return const NewsArticleModel(
        sourceName: "Erreur de parsing",
        title: "Article non disponible",
        author: "Inconnu",
        description: "Une erreur s'est produite lors du chargement de cet article",
        url: "",
        urlToImage: null,
        content: "",
        publishedAt: null,
      );
    }
  }
}