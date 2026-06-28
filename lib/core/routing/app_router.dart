import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/settings/presentation/profile_page.dart';
import '../../features/settings/presentation/reverse_nim_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),

      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),

      GoRoute(
        path: '/reverse-nim',
        builder: (context, state) => const ReverseNimPage(),
      ),
    ],
  );
}
