import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import '/features/ai_news/data/models/news_article_model.dart';

abstract class AINewsRemoteDataSource {
  Future<List<NewsArticleModel>> getAINews();
}

class AINewsRemoteDataSourceImpl extends AINewsRemoteDataSource {
  final Dio dio;

  AINewsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<NewsArticleModel>> getAINews() async {
    try {
      log("Using mock data since GNews requires account activation");

      // Simulation d'un délai pour imiter un appel API
      await Future.delayed(Duration(milliseconds: 800));

      // Créer des données fictives avec des images d'IA réalistes
      return [
        NewsArticleModel(
          sourceName: "TechCrunch",
          author: "John Mitchell",
          title: "OpenAI Releases GPT-5 with Enhanced Reasoning Capabilities",
          description: "OpenAI has announced the release of GPT-5, featuring significant improvements in reasoning, multi-step problem solving, and code generation capabilities.",
          url: "https://techcrunch.com/gpt5-release",
          urlToImage: "https://images.unsplash.com/photo-1620712943543-bcc4688e7485?q=80&w=2065&auto=format&fit=crop",
          content: "OpenAI's latest model shows remarkable improvements in handling complex tasks requiring reasoning across multiple domains. The new model excels at understanding context, making logical deductions, and solving multi-step problems.",
          publishedAt: DateTime.now().subtract(Duration(hours: 5)),
        ),
        NewsArticleModel(
          sourceName: "MIT Technology Review",
          author: "Sarah Johnson",
          title: "AI-Powered Drug Discovery Leads to Breakthrough Treatment",
          description: "Researchers using AI algorithms have discovered a novel treatment for resistant forms of lung cancer, reducing discovery time from years to months.",
          url: "https://mittechreview.com/ai-drug-discovery",
          urlToImage: "https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?q=80&w=1932&auto=format&fit=crop",
          content: "Using machine learning algorithms to analyze vast datasets of molecular structures, researchers identified a compound that shows promise in treating forms of lung cancer that have developed resistance to existing therapies.",
          publishedAt: DateTime.now().subtract(Duration(hours: 12)),
        ),
        NewsArticleModel(
          sourceName: "AI Business",
          author: "Mark Thompson",
          title: "Computer Vision Systems Reduce Manufacturing Defects by 90%",
          description: "Implementation of advanced computer vision AI in manufacturing lines has resulted in dramatic quality improvements and cost savings.",
          url: "https://aibusiness.com/computer-vision-manufacturing",
          urlToImage: "https://images.unsplash.com/photo-1581091226033-d5c48150dbaa?q=80&w=2070&auto=format&fit=crop",
          content: "Industrial implementations of computer vision systems have detected subtle defects that would otherwise have been missed by human inspectors, leading to a 90% reduction in product returns and substantial cost savings.",
          publishedAt: DateTime.now().subtract(Duration(days: 1)),
        ),
        NewsArticleModel(
          sourceName: "VentureBeat",
          author: "Lisa Chen",
          title: "AI Startup Secures 150M to Develop Autonomous Home Assistants",
          description: "A startup focused on building physically embodied AI assistants for the home has secured major funding to bring their product to market.",
          url: "https://venturebeat.com/ai-home-assistant",
          urlToImage: "https://images.unsplash.com/photo-1531297484001-80022131f5a1?q=80&w=2020&auto=format&fit=crop",
          content: "The company's prototype combines advanced robotics with state-of-the-art AI models to create assistants that can physically interact with home environments, assist elderly individuals, and perform everyday tasks.",
          publishedAt: DateTime.now().subtract(Duration(days: 2)),
        ),
        NewsArticleModel(
          sourceName: "The AI Ethics Institute",
          author: "Dr. Robert Kim",
          title: "New Legislation Proposed for AI Regulation in Healthcare",
          description: "Lawmakers have introduced comprehensive legislation aimed at regulating the use of AI in healthcare settings, focusing on transparency and safety.",
          url: "https://aiethics.org/healthcare-regulation",
          urlToImage: "https://images.unsplash.com/photo-1576091160550-2173dba999ef?q=80&w=2070&auto=format&fit=crop",
          content: "The proposed regulations would require all AI systems used in clinical decision-making to meet strict standards for explainability, providing physicians with clear reasoning behind AI recommendations.",
          publishedAt: DateTime.now().subtract(Duration(days: 3)),
        ),
        NewsArticleModel(
          sourceName: "Nature AI",
          author: "Dr. Emily Rodriguez",
          title: "AI System Achieves Breakthrough in Protein Structure Prediction",
          description: "A new deep learning system has demonstrated unprecedented accuracy in predicting protein structures from amino acid sequences.",
          url: "https://nature.com/ai-protein-folding",
          urlToImage: "https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?q=80&w=2070&auto=format&fit=crop",
          content: "The research team combined transformer-based neural networks with novel physical simulations to achieve results that could dramatically accelerate drug discovery and our understanding of biological processes.",
          publishedAt: DateTime.now().subtract(Duration(days: 4)),
        ),
        NewsArticleModel(
          sourceName: "AI Trends",
          author: "Michael Zhang",
          title: "Autonomous Vehicles Achieve 1 Million Miles Without Human Intervention",
          description: "A leading autonomous vehicle company has announced that its fleet has driven over 1 million miles without requiring human takeover.",
          url: "https://aitrends.com/autonomous-milestone",
          urlToImage: "https://images.unsplash.com/photo-1553934864-3a4405bf84b1?q=80&w=1974&auto=format&fit=crop",
          content: "This milestone represents a significant advance in self-driving technology, with the vehicles navigating complex urban environments, adverse weather conditions, and unexpected road events without human assistance.",
          publishedAt: DateTime.now().subtract(Duration(days: 5)),
        ),
        NewsArticleModel(
          sourceName: "Education Technology Review",
          author: "Rachel Adams",
          title: "AI Tutoring Systems Show 40% Improvement in Student Math Scores",
          description: "A large-scale study of AI-powered personalized tutoring systems shows significant improvements in student performance across diverse learning environments.",
          url: "https://edtechreview.com/ai-tutoring-results",
          urlToImage: "https://images.unsplash.com/photo-1509869175650-a1d97972541a?q=80&w=2070&auto=format&fit=crop",
          content: "The adaptive learning systems identified individual student knowledge gaps and learning styles, providing tailored instruction that resulted in mathematics performance improvements averaging 40% compared to traditional methods.",
          publishedAt: DateTime.now().subtract(Duration(days: 6)),
        ),
        NewsArticleModel(
          sourceName: "Science Daily",
          author: "Thomas Wilson",
          title: "Neural Interfaces Allow Thought-to-Text Communication for Paralyzed Patients",
          description: "A breakthrough in neural interface technology has enabled patients with severe paralysis to communicate through text using only their thoughts.",
          url: "https://sciencedaily.com/neural-interface-communication",
          urlToImage: "https://images.unsplash.com/photo-1617791160536-598cf32026fb?q=80&w=1964&auto=format&fit=crop",
          content: "The system, which uses implanted electrodes and advanced machine learning algorithms, can interpret neural patterns associated with imagined handwriting, allowing for communication rates approaching normal typing speeds.",
          publishedAt: DateTime.now().subtract(Duration(days: 7)),
        ),
        NewsArticleModel(
          sourceName: "Forbes Tech",
          author: "Jennifer Park",
          title: "AI-Generated Content Now 30% of All Online Media",
          description: "New research shows that AI-generated articles, images and videos now constitute approximately 30% of new online content.",
          url: "https://forbes.com/ai-content-statistics",
          urlToImage: "https://images.unsplash.com/photo-1620712943543-bcc4688e7485?q=80&w=2065&auto=format&fit=crop",
          content: "The study revealed that consumers often cannot distinguish between AI-created and human-created content, raising important questions about authenticity, attribution, and the future of creative work.",
          publishedAt: DateTime.now().subtract(Duration(days: 8)),
        ),
      ];
    } catch (e) {
      log("Error generating mock data: $e");
      throw Exception("Erreur lors de la récupération des nouvelles IA: $e");
    }
  }
}