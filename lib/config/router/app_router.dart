import 'package:go_router/go_router.dart';
import 'package:pixabay/view/pixabay/pixabay_screen.dart';

enum AppRoute {
  home,
}

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) {
        return const PixabayScreen();
      },
    ),
  ],
);
