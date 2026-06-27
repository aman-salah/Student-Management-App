import 'package:flutter/material.dart';
import 'package:frontend/core/providers/provider_setup.dart';
import 'package:frontend/core/Theme/theme_provider.dart';
import 'package:frontend/splash_screen.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: ProviderSetup.providers,
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          theme: themeProvider.themeData,
        ),
      ),
    ),
  );
}
