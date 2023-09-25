import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/login/bloc/login_bloc.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Failed"),
            ));
          }
        },
        builder: (context, state) {
          final geterror = state as LoginErrorState;
          if (state is LoginErrorState) {
            return Center(
              child: Text("${geterror.error}"),
            );
          }
          return Center(child: Text("no state"));
        },
      ),
    );
  }
}
