import 'package:advisoryapp_assigments/src/presentation/screens/index.dart';
import 'package:go_router/go_router.dart';

GoRouter goRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/Home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}
