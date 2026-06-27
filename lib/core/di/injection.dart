import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

import '../config/env_config.dart';
import '../../features/home/data/domain/news_repository.dart';
import '../../features/home/presentation/cubit/news_cubit.dart';
import '../../features/home/data/models/article_model.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([ArticleModelSchema], directory: dir.path);
  locator.registerLazySingleton<Isar>(() => isar);

  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: EnvConfig.baseUrl));

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['apiKey'] =
              'ee2aef9fe84b486c89711c5ed5c5206d';
          return handler.next(options);
        },
      ),
    );

    return dio;
  });

  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepository(locator(), locator()),
  );
  locator.registerFactory<NewsCubit>(() => NewsCubit(locator()));
}
