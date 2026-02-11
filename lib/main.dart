import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/design.dart';
import 'core/router/app_router.dart';
import 'providers/progress_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.read(progressProvider.notifier).loadProgress();

    return MaterialApp.router(
      title: 'AnimalFacts',
      theme: ThemeData(
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.darkText),
          titleTextStyle: TextStyle(
            color: AppColors.darkText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.green,
          unselectedItemColor: AppColors.grey,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        cardTheme: CardTheme(
          color: AppColors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}