abstract class AuthViewCubitState {}

class AuthViewCubitFormFillInProgressState extends AuthViewCubitState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AuthViewCubitFormFillInProgressState &&
              runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthViewCubitErrorState extends AuthViewCubitState {
  final String errorMessage;

  AuthViewCubitErrorState(this.errorMessage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AuthViewCubitErrorState &&
              runtimeType == other.runtimeType &&
              errorMessage == other.errorMessage;

  @override
  int get hashCode => errorMessage.hashCode;
}

class AuthViewCubitInProgressState extends AuthViewCubitState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AuthViewCubitInProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthViewCubitSuccessState extends AuthViewCubitState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AuthViewCubitSuccessState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}