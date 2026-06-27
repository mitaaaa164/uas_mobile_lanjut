import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import '../models/article_model.dart';

class NewsRepository {
  final Dio dio;
  final Isar isar;

  NewsRepository(this.dio, this.isar);

  Future<List<ArticleModel>> fetchTopNews() async {
    try {
      final response = await dio.get(
        'top-headlines',
        queryParameters: {'category': 'technology', 'language': 'en'},
      );

      final List<dynamic> articlesJson = response.data['articles'];
      List<ArticleModel> articles = articlesJson
          .map((json) => ArticleModel.fromJson(json))
          .toList();

      articles.sort(
        (a, b) => (b.title ?? '').toLowerCase().compareTo(
          (a.title ?? '').toLowerCase(),
        ),
      );

      await isar.writeTxn(() async {
        await isar.articleModels.clear();
        await isar.articleModels.putAll(articles);
      });

      return articles;
    } catch (e) {
      final cachedArticles = await isar.articleModels.where().findAll();

      if (cachedArticles.isNotEmpty) {
        return cachedArticles;
      }

      throw Exception('Tidak ada internet dan belum ada data tersimpan.');
    }
  }
}
