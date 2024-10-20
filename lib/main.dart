import 'package:advisoryapp_assigments/src/config/router_config.dart';
import 'package:advisoryapp_assigments/src/presentation/provider/app/app_bloc.dart';
import 'package:advisoryapp_assigments/src/presentation/provider/login/login_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.retrieveCurrentUser().first;

  runApp(MainApp( 
    authenticationRepository: AuthenticationRepository(),));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (BuildContext context) =>
            AppBloc(authenticationRepository: authenticationRepository),
            
      ),
      BlocProvider(create: (context) => LoginBloc(),)
    ], child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return MaterialApp.router(
        title: 'Advisory App',
        routerConfig: goRouter( BlocProvider.of<AppBloc>(context)),
      );
    },),);
  }
}
