import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(
                  authenticationRepository.currentUser,
                )
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onAppUserChanged);
    on<AppLogoutRequested>(_onAppLogoutRequested);
    _userSubscription = _authenticationRepository.retrieveCurrentUser().listen(
          (user) => add(
            AppUserChanged(user),
          ),
        );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onAppUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    debugPrint("user: ${event.user.isNotEmpty}");
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onAppLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    emit(const AppState.unauthenticated());
    unawaited(_authenticationRepository.signOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
