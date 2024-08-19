import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthUnauthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AuthUnauthorizedState;

  @override
  int get hashCode => 0;
}

class AuthAuthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
class AuthRegisterState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AuthRegisterState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
class AuthRegisterFailedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AuthRegisterFailedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}


class AuthFirebaseFailureState extends AuthState {
  FirebaseAuthException error;

  AuthFirebaseFailureState(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthFirebaseFailureState &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
class AuthFailureState extends AuthState {
  Object error;

  AuthFailureState(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AuthFailureState &&
              runtimeType == other.runtimeType &&
              error == other.error;

  @override
  int get hashCode => error.hashCode;
}
class AuthInProgressState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthInProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthCheckStatusInProgressState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthCheckStatusInProgressState &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
