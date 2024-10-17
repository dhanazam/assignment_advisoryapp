import 'package:advisoryapp_assigments/src/presentation/provider/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginFormView(),
    );
  }
}

class LoginFormView extends StatefulWidget {
  const LoginFormView({super.key});

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
        } else if (state.status.isSuccess) {}
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  // context.read<ThemeBloc>().add(ChangeThemeEvent());
                },
                icon: Icon(
                  Icons.light_mode,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            body: AbsorbPointer(
              absorbing: state.status.isInProgress ? true : false,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.email.value,
                        focusNode: _emailFocusNode,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          errorText: state.email.displayError != null
                              ? 'Email must be valid'
                              : null,
                          labelStyle: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.fontSize,
                            fontFamily: 'medium',
                          ),
                          errorStyle: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.fontSize,
                            fontFamily: 'medium',
                          ),
                        ),
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.labelLarge?.fontSize,
                          fontFamily: 'medium',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(LoginEmailChanged(email: value));
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: state.password.value,
                        focusNode: _passwordFocusNode,
                        decoration: InputDecoration(
                          helperMaxLines: 2,
                          labelText: 'Password',
                          errorMaxLines: 2,
                          errorText: state.password.displayError != null
                              ? 'Password must be valid'
                              : null,
                          labelStyle: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.fontSize,
                            fontFamily: 'medium',
                          ),
                          errorStyle: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.fontSize,
                            fontFamily: 'medium',
                          ),
                        ),
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.labelLarge?.fontSize,
                          fontFamily: 'medium',
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(LoginPasswordChanged(password: value));
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: isValid
                              ? () => context
                                  .read<LoginBloc>()
                                  .add(LoginFormSubmitted())
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40),
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            textStyle: TextStyle(
                                fontFamily: 'semibold',
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.fontSize),
                          ),
                          label: const Text('Login'),
                          icon: state.status.isInProgress
                              ? Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(2.0),
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Icon(Icons.login_outlined),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(LoginWithGoogle());
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            foregroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Sign in with Google",
                            style: TextStyle(
                                fontFamily: 'semibold',
                                color: Theme.of(context).primaryColor,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.fontSize),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
