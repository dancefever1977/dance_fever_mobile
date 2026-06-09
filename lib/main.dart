import 'package:dance_fever/core/config/firebase_options.dart';
import 'package:dance_fever/core/router/router.dart';
import 'package:dance_fever/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'core/config/injection_container.dart' as di;
import 'core/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GoogleSignIn.instance.initialize();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // Android: Changes status bar icons to white
        statusBarIconBrightness: Brightness.light,
        // iOS: Tells the system the background is dark so it renders white icons
        statusBarBrightness: Brightness.dark,
        // Optional: Forces a transparent status bar background on Android
        statusBarColor: Colors.transparent,
      ),
      child: BlocProvider(
        create: (_) => di.sl<AuthBloc>(),
        child: Builder(
          builder: (context) {
            final authBloc = context.read<AuthBloc>();
            final appRouter = AppRouter(authBloc: authBloc);

            return MaterialApp.router(
              title: 'Auth Clean App',
              routerConfig: appRouter.router,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.background,
                canvasColor: AppColors.background,
                colorScheme: const ColorScheme.dark(
                  primary: AppColors.primary,
                  surface: AppColors.surface,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
