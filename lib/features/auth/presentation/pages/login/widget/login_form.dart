import 'package:clean_architecture/features/auth/presentation/providers/login/login_bloc.dart';
import 'package:clean_architecture/features/services/presentation/pages/home/home_page.dart';
import 'package:clean_architecture/features/shared/providers/error_wrapper_cubit.dart';
import 'package:clean_architecture/features/shared/widgets/error_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final status = context.select((LoginBloc bloc) => bloc.state.status);

    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.status != current.status || previous.error != current.error,
      listener: (context, state) {
        /// * Navegar al [HomePage]
        if (state.status == LoginStatus.success) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }

        if (state.error == null) {
          context.read<ErrorWrapperCubit>().hideError();
        }

        if (state.status == LoginStatus.failure && state.error != null) {
          context.read<ErrorWrapperCubit>().showError(state.error!);
        }
      },
      child: WrapError(
        onRetry: () {
          context.read<LoginBloc>().add(
                LoginPressedButton(
                  email: emailCtrl.text,
                  password: passwordCtrl.text,
                ),
              );
        },
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // * Campo de email
              TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),

              // * Campo de password
              TextFormField(
                controller: passwordCtrl,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 50),

              // * Boton de login
              ElevatedButton(
                onPressed: () {
                  final email = emailCtrl.text;
                  final password = passwordCtrl.text;

                  context.read<LoginBloc>().add(
                        LoginPressedButton(
                          email: email,
                          password: password,
                        ),
                      );
                },
                child: status == LoginStatus.loading
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
