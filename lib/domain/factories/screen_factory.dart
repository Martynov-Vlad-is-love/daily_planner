import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:daily_planner_firebase_bloc/domain/blocs/auth_bloc/auth_state.dart';
import 'package:daily_planner_firebase_bloc/ui/pages/main_page.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/auth_widget/auth_view_cubit.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/loader_widget/loader_view_cubit.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/loader_widget/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenFactory {
  AuthBloc? _authBloc;

  Widget makeLoader() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState());
    _authBloc = authBloc;
    return BlocProvider<LoaderViewCubit>(
      create: (context) =>
          LoaderViewCubit(LoaderViewCubitState.unknown, authBloc),
      lazy: false,
      child: const LoaderWidget(),
    );
  }
  Widget makeAuth(){
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState());
    _authBloc = authBloc;
    return BlocProvider<AuthViewCubit>(
      create: (_) =>
          AuthViewCubit(AuthViewCubitFormFillInProgressState(), authBloc),
      child: const LoaderWidget(),
    );
  }

  Widget makeMainScreen(){
    _authBloc?.close();
    _authBloc = null;
    return const MainPage();
  }
}
