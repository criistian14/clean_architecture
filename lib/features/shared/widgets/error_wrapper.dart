import 'package:clean_architecture/config/base_errors.dart';
import 'package:clean_architecture/features/auth/infrastructure/errors/login_errors.dart';
import 'package:clean_architecture/features/shared/errors/default_errors.dart';
import 'package:clean_architecture/features/shared/errors/internet_errors.dart';
import 'package:clean_architecture/features/shared/providers/error_wrapper_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ErrorSnackbarBaseExtension on ErrorSnackbarBase {
  String get messageToShow {
    if (this is ConnectionTimeout) {
      return "Tiempo de espera agotado";
    } else if (this is LoginWrongCredentials) {
      return "Credenciales incorrectas";
    } else if (this is CustomError) {
      return (this as CustomError).message;
    } else {
      return toString();
    }
  }
}

extension ErrorRetryBaseExtension on ErrorRetryBase {
  String get messageToShow {
    if (this is LoginWrongUUID) {
      return "UUID incorrecto";
    } else {
      return toString();
    }
  }
}

class WrapError extends StatelessWidget {
  const WrapError({
    super.key,
    required this.child,
    required this.onRetry,
  });

  final Widget child;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ErrorWrapperCubit, Exception?>(
      listener: (context, error) {
        // * Show snack bar
        if (error is ErrorSnackbarBase) {
          String message = error.messageToShow;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
        }
      },
      child: BlocBuilder<ErrorWrapperCubit, Exception?>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, error) {
          if (error is ErrorRetryBase) {
            return _ErrorRetryWidget(
              error: error,
              onRetry: onRetry,
            );
          }

          return child;
        },
      ),
    );
  }
}

class _ErrorRetryWidget extends StatelessWidget {
  const _ErrorRetryWidget({
    required this.error,
    required this.onRetry,
  });

  final ErrorRetryBase error;

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error.messageToShow),

          // * Retry button
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<ErrorWrapperCubit>().hideError();

              onRetry();
            },
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
