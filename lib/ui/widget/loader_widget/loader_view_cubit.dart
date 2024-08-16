import 'dart:async';

import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_event.dart';
import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LoaderViewCubitState { unknown, authorized, notAuthorized }

class LoaderViewCubit extends Cubit<LoaderViewCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  LoaderViewCubit(super.initialState, this.authBloc) {
    authBloc.add(AuthCheckStatusEvent());
    _onState(authBloc.state);
    authBlocSubscription = authBloc.stream.listen((onState) {});
  }

  void _onState(AuthState state) {
    if (state is AuthAuthorizedState) {
      emit(LoaderViewCubitState.authorized);
    } else if (state is AuthUnauthorizedState){
      emit(LoaderViewCubitState.notAuthorized);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
