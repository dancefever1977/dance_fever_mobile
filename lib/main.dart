import 'package:dance_fever/core/theme/app_colors.dart';
import 'package:dance_fever/features/auth/presentation/pages/auth_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'core/config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GoogleSignIn.instance.initialize();

  runApp(const ProviderScope(child: MyApp()));
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
      child: MaterialApp(
        title: 'Auth Clean App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          canvasColor: AppColors.background,
          colorScheme: const ColorScheme.dark(
            primary: AppColors.primary,
            surface: AppColors.surface,
          ),
        ),
        home: const AuthChecker(),
      ),
    );
  }
}
