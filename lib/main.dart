import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:itfox_test_project/src/app/cubit/app_cubit.dart';
import 'package:itfox_test_project/src/domain/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itfox_test_project/src/domain/repositories/weather_repository.dart';
import 'src/app/app.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthenticationRepository(),
        ),
        RepositoryProvider(
          create: (_) => WeatherRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => AppCubit(
          authenticationRepository: context.read<AuthenticationRepository>(),
        ),
        child: const App(),
      ),
    ),
  );
}
