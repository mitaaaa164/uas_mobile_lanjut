import 'package:isar/isar.dart';

part 'article_model.g.dart';

@collection
class ArticleModel {
  Id id = Isar.autoIncrement;

  String? title;
  String? description;

  ArticleModel();

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel()
      ..title = json['title'] ?? 'No Title'
      ..description = json['description'] ?? '';
  }
}
