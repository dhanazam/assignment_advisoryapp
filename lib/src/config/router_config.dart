import 'dart:async';

import 'package:advisoryapp_assigments/src/presentation/provider/app/app_bloc.dart';
import 'package:advisoryapp_assigments/src/presentation/screens/index.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

GoRouter goRouter(AppBloc appBloc) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/Home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/Login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final statusAuthentication = context.read<AppBloc>().state.status;

      if (statusAuthentication == AppStatus.authenticated) {
        return '/Home';
      } else if (statusAuthentication == AppStatus.unauthenticated) {
        return '/Login';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(appBloc.stream),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
