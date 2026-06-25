import 'package:flutter/material.dart';
import 'theme.dart';
import 'router.dart';
import '../core/constants/app_strings.dart';

class BalaramayyyaApp extends StatelessWidget {
  const BalaramayyyaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppRouter.home,
      routes: AppRouter.routes,
      onUnknownRoute: AppRouter.onUnknownRoute,
    );
  }
}
