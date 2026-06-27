import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../config/env_config.dart';
import '../../features/home/data/domain/news_repository.dart';
import '../../features/home/presentation/cubit/news_cubit.dart';

final locator = GetIt.instance;

void setupLocator() {
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
    () => NewsRepository(locator()),
  );
  locator.registerFactory<NewsCubit>(() => NewsCubit(locator()));
}
