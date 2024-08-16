import 'package:daily_planner_firebase_bloc/route_names.dart';
import 'package:daily_planner_firebase_bloc/ui/widget/loader_widget/loader_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderViewCubit, LoaderViewCubitState>(
      listenWhen: (prev, current) => current != LoaderViewCubitState.unknown,
      listener: _onLoaderCubitStateChanges,
      child: const Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      )),
    );
  }

  void _onLoaderCubitStateChanges(BuildContext context, LoaderViewCubitState state){
    final nextScreen = state == LoaderViewCubitState.authorized
        ? RouteNames.mainScreen
        : RouteNames.loginPage;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
