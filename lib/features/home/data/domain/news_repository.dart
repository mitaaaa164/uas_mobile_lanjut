import 'package:dio/dio.dart';

class Article {
  final String title;
  final String description;

  Article({required this.title, required this.description});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
    );
  }
}

class NewsRepository {
  final Dio dio;

  NewsRepository(this.dio);

  Future<List<Article>> fetchTopNews() async {
    try {
      final response = await dio.get(
        'top-headlines',
        queryParameters: {'category': 'technology', 'language': 'en'},
      );

      final List<dynamic> articlesJson = response.data['articles'];
      List<Article> articles = articlesJson.map((json) => Article.fromJson(json)).toList();

      articles.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));

      return articles;
    } catch (e) {
      throw Exception('Gagal mengambil data berita: $e');
    }
  }
}