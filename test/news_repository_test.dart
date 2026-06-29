import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiDataSource extends Mock {}

class Article {
  final String title;
  Article({required this.title});
}

class NewsRepository {
  final MockApiDataSource dataSource;
  NewsRepository(this.dataSource);

  List<Article> getSortedNews(List<Article> rawArticles) {
    rawArticles.sort((a, b) => b.title.compareTo(a.title));
    return rawArticles;
  }
}

void main() {
  late MockApiDataSource mockDataSource;
  late NewsRepository newsRepository;

  setUp(() {
    mockDataSource = MockApiDataSource();
    newsRepository = NewsRepository(mockDataSource);
  });

  group('News Repository Tests (Logika Anti-AI)', () {
    test('1. Repository harus mengembalikan list yang valid (tidak null)', () {
      final rawArticles = <Article>[];
      final result = newsRepository.getSortedNews(rawArticles);

      expect(result, isNotNull);
      expect(result, isA<List<Article>>());
    });

    test(
      '2. Repository harus mengurutkan judul artikel dari Z ke A (Descending)',
      () {
        final rawArticles = [
          Article(title: 'Ayam Goreng Enak'),
          Article(title: 'Zebra Cross Baru'),
          Article(title: 'Bebek Bakar Madu'),
        ];

        final sortedResult = newsRepository.getSortedNews(rawArticles);

        expect(sortedResult[0].title, 'Zebra Cross Baru');
        expect(sortedResult[1].title, 'Bebek Bakar Madu');
        expect(sortedResult[2].title, 'Ayam Goreng Enak');
      },
    );

    test(
      '3. Repository tidak error saat memproses list artikel yang kosong',
      () {
        final rawArticles = <Article>[];

        final result = newsRepository.getSortedNews(rawArticles);

        expect(result.isEmpty, true);
        expect(result.length, 0);
      },
    );
  });
}
