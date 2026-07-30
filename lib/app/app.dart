// lib/app/app.dart

import 'package:flutter/material.dart';
import 'package:sevasetu/core/constants/app_constants.dart';
import 'package:sevasetu/core/theme/app_theme.dart';
import 'package:sevasetu/router/app_router.dart';

class SevaSetuApp extends StatelessWidget {
  const SevaSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}