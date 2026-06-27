import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/env_config.dart';
import '../../../../core/di/injection.dart';
import '../cubit/news_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<NewsCubit>()..getNews(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(EnvConfig.appName),
          backgroundColor: EnvConfig.isProduction
              ? const Color(0xFF00008B)
              : Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading || state is NewsInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Gagal memuat berita:\n${state.message}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            } else if (state is NewsSuccess) {
              final articles = state.articles;

              if (articles.isEmpty) {
                return const Center(child: Text('Belum ada berita hari ini.'));
              }

              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];

                  final String title = article.title ?? 'Tanpa Judul';
                  final String description = article.description ?? '';

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          description.isNotEmpty
                              ? description
                              : 'Tidak ada deskripsi',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
