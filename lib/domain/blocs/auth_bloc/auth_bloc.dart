import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_event.dart';
import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_state.dart';
import 'package:daily_planner_firebase_bloc/domain/services/firebase_authentication.dart';
import 'package:daily_planner_firebase_bloc/storage/secured_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final auth = FirebaseAuthentication();
  final secureStorage = SecuredStorage();

  AuthBloc(super.initialState) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckStatusEvent) {
        onAuthCheckStatusEvent(event, emit);
      } else if (event is AuthLoginEvent) {
        onAuthLoginEvent(event, emit);
      } else if (event is AuthLogoutEvent) {
        onAuthLogoutEvent(event, emit);
      }
    }, transformer: sequential());
    add(AuthCheckStatusEvent());
  }

  void onAuthCheckStatusEvent(
      AuthCheckStatusEvent event, Emitter<AuthState> emit) async {
    try {
      final token = await secureStorage.getToken();
      final newState =
          token != null ? AuthAuthorizedState() : AuthUnauthorizedState();
      emit(newState);
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }

  void onAuthLoginEvent(AuthLoginEvent event, Emitter<AuthState> emit) async {
    try {
      auth.signInWithEmailAndPassword(event.login, event.password);
      if (auth.uid != null) {
        secureStorage.setToken(auth.uid as String);
        emit(AuthAuthorizedState());
      } else {
        throw Exception('Account id is null');
      }
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }

  void onAuthLogoutEvent(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    try {
      secureStorage.deleteToken();
      emit(AuthUnauthorizedState());
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }
}
