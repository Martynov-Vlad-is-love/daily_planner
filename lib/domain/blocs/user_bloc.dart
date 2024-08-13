import 'package:daily_planner_firebase_bloc/domain/entity/user.dart';

abstract class UserEvents {}

class UserLoginEvent extends UserEvents {}

class UserRegistrationEvent extends UserEvents {}

class UserLogoutEvent extends UserEvents {}

class UserState {
  final User currentUser;

  UserState({required this.currentUser});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserState &&
          runtimeType == other.runtimeType &&
          currentUser == other.currentUser);

  @override
  int get hashCode => currentUser.hashCode;

  UserState copyWith({User? user}) =>
      UserState(currentUser: user ?? currentUser);
}
