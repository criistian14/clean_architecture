import 'package:clean_architecture/config/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../providers/login/login_bloc.dart';
import 'widget/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<LoginBloc>(),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
