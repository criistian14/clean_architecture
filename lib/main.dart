import 'package:clean_architecture/config/injection_container.dart' as di;
import 'package:clean_architecture/config/usecase.dart';
import 'package:clean_architecture/features/auth/presentation/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'features/shared/shared.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);

  await di.init();

  final loadConfigCall = di.sl<LoadRemoteConfigUseCase>();
  await loadConfigCall(const NoParams());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ErrorWrapperCubit>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
