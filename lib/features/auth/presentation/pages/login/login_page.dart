import 'package:clean_architecture/config/injection_container.dart';
import 'package:clean_architecture/config/persist.dart';
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Persist.appName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 10),

                // * Form
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
