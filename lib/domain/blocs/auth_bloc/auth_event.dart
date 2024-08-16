abstract class AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}

class AuthCheckStatusEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String login;
  final String password;

  AuthLoginEvent({required this.login, required this.password});
}

class AuthRegisterEvent extends AuthEvent {
  final String login;
  final String password;

  AuthRegisterEvent({required this.login, required this.password});
}
