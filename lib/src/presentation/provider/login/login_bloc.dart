import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:validations/form_inputs.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginEmailUnfocused>(_onLoginEmailUnfocused);
    on<LoginPasswordUnfocused>(_onLoginPasswordUnfocused);
    on<LoginFormSubmitted>(_onLoginFormSubmitted);
    // on<LoginWithGoogle>(_onLoginWithFacebook);
  }

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  void _onLoginEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = LoginEmailField.dirty(event.email);
    emit(
      state.copyWith(
        email: email.isValid ? email : LoginEmailField.pure(event.email),
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void _onLoginPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = LoginPasswordField.dirty(event.password);
    emit(
      state.copyWith(
        password: password.isValid
            ? password
            : LoginPasswordField.pure(event.password),
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  void _onLoginEmailUnfocused(
      LoginEmailUnfocused event, Emitter<LoginState> emit) {
    final email = LoginEmailField.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      status: FormzSubmissionStatus.initial,
      isValid: Formz.validate([email, state.password]),
    ));
  }

  void _onLoginPasswordUnfocused(
    LoginPasswordUnfocused event,
    Emitter<LoginState> emit,
  ) {
    final password = LoginPasswordField.dirty(state.password.value);
    emit(
      state.copyWith(
        password: password,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> _onLoginFormSubmitted(
      LoginFormSubmitted event, Emitter<LoginState> emit) async {
    final email = LoginEmailField.dirty(state.email.value);
    final password = LoginPasswordField.dirty(state.password.value);
    emit(state.copyWith(
      email: email,
      password: password,
      status: FormzSubmissionStatus.initial,
      isValid: Formz.validate([email, password]),
    ));
    if (state.isValid &&
        state.email.value.isNotEmpty &&
        state.password.value.isNotEmpty) {
      User user = User(
        email: state.email.value.toString(),
        password: state.password.value.toString(),
      );
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final userCredentials =
            await _authenticationRepository.signInWithEmailandPassword(user);
        if (userCredentials.status != null &&
            userCredentials.status!.code != 200) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            toastMessage: userCredentials.status!.message,
          ));
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        }

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          toastMessage: e.toString(),
        ));
      }
    }
  }

  // Future<void> _onLoginWithFacebook(
  //     LoginWithGoogle event, Emitter<LoginState> emit) async {
  //   emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
  //   try {
  //     await _authenticationRepository.signInWithGoogle();
  //     emit(state.copyWith(status: FormzSubmissionStatus.success));
  //   } on firebase_auth.FirebaseAuthException catch (e) {
  //     emit(state.copyWith(
  //       status: FormzSubmissionStatus.failure,
  //       toastMessage: e.message.toString(),
  //     ));
  //   }
  // }
}
