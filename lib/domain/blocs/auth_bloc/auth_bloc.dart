import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_event.dart';
import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_state.dart';
import 'package:daily_planner_firebase_bloc/domain/services/firebase_authentication.dart';
import 'package:daily_planner_firebase_bloc/storage/secured_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final auth = FirebaseAuthentication();
  final secureStorage = SecuredStorage();

  AuthBloc(super.initialState) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckStatusEvent) {
        await onAuthCheckStatusEvent(event, emit);
      } else if (event is AuthLoginEvent) {
        await onAuthLoginEvent(event, emit);
      } else if (event is AuthLogoutEvent) {
        await onAuthLogoutEvent(event, emit);
      } else if (event is AuthRegisterEvent) {
        await onAuthRegisterEvent(event, emit);
      }
    }, transformer: sequential());
    add(AuthCheckStatusEvent());
  }

  Future<void> onAuthCheckStatusEvent(
      AuthCheckStatusEvent event, Emitter<AuthState> emit) async {
    try {
      final token = await secureStorage.getToken();
      final newState =
          token != null ? AuthAuthorizedState() : AuthUnauthorizedState();
      emit(newState);
    } catch (e) {
      if(e is FirebaseAuthException) {
        emit(AuthFirebaseFailureState(e));
      }else{
        emit(AuthFailureState(e));
      }
    }
  }

  Future<void> onAuthLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    try {
      auth.signInWithEmailAndPassword(event.login, event.password);
      if (auth.uid != null) {
        secureStorage.setToken(auth.uid as String);
        emit(AuthAuthorizedState());
      } else {
        throw Exception('Account id is null');
      }
    } catch (e) {
      if(e is FirebaseAuthException) {
        emit(AuthFirebaseFailureState(e));
      }else{
        emit(AuthFailureState(e));
      }
    }
  }

  Future<void> onAuthRegisterEvent(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    try {
      auth.signUpWithEmailAndPassword(event.login, event.password);
      if (auth.uid != null) {
        secureStorage.setToken(auth.uid as String);
        emit(AuthRegisterState());
      } else {
        throw Exception("You can't create an account with this credentials");
      }
    } catch (e) {
      if(e is FirebaseAuthException) {
        emit(AuthFirebaseFailureState(e));
      }else{
        emit(AuthRegisterFailedState());
      }
    }
  }

  Future<void> onAuthLogoutEvent(
      AuthLogoutEvent event, Emitter<AuthState> emit) async {
    try {
      secureStorage.deleteToken();
      emit(AuthUnauthorizedState());
    } catch (e) {
      if(e is FirebaseAuthException) {
        emit(AuthFirebaseFailureState(e));
      }else{
        emit(AuthFailureState(e));
      }

    }
  }
}
