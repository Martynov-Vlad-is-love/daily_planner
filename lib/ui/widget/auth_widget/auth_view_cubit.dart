import 'dart:async';

import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_event.dart';
import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_state.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/auth_widget/auth_view_cubit_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthViewCubit extends Cubit<AuthViewCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  AuthViewCubit(super.initState, this.authBloc) {
    _onState(authBloc.state);
    authBlocSubscription = authBloc.stream.listen((onState) {});
  }

  bool isValid(String login, String password) =>
      login.isNotEmpty && password.isNotEmpty;

  void auth({required String login, required String password}) {
    if (!isValid(login, password)) {
      final state =
          AuthViewCubitErrorState('Please, fill login and password correctly.');
      emit(state);
      return;
    }
    authBloc.add(AuthLoginEvent(login: login, password: password));
  }

  void  register({required String login, required String password}) {
    if (!isValid(login, password)) {
      final state =
          AuthViewCubitErrorState('Please, fill login and password correctly.');
      emit(state);
      return;
    }
    authBloc.add(AuthRegisterEvent(login: login, password: password));
  }

  void _onState(AuthState state) {
    if (state is AuthUnauthorizedState) {
      emit(AuthViewCubitFormFillInProgressState());
    } else if (state is AuthAuthorizedState) {
      emit(AuthViewCubitSuccessState());
    } else if (state is AuthFirebaseFailureState) {
      final message = _mapErrorToMessage(state.error);
      emit(AuthViewCubitErrorState(message));
    } else if (state is AuthInProgressState) {
      emit(AuthViewCubitInProgressState());
    } else if (state is AuthCheckStatusInProgressState) {
      emit(AuthViewCubitInProgressState());
    }
  }

  String _mapErrorToMessage(FirebaseAuthException error) {
    switch (error.code) {
      case "account-exists-with-different-credential":
        return "Account already exists";
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      case "wrong-password":
        return "Wrong email/password combination.";
      case "user-not-found":
        return "No user found with this email.";
      case "user-disabled":
        return "User disabled.";
      case "operation-not-allowed":
        return "Server error, please try again later.";
      case "invalid-email":
        return "Email address is invalid.";
      default:
        return "Login failed. Please try again.";
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
