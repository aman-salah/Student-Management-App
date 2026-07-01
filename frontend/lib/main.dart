import 'package:flutter/material.dart';
import 'package:frontend/core/providers/provider_setup.dart';
import 'package:frontend/core/Theme/theme_provider.dart';
import 'package:frontend/core/routes/route_config.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

final appRouter = MyAppRouter();
void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(
    MultiProvider(
      providers: ProviderSetup.providers,
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          routerConfig: appRouter.router,
        ),
      ),
    ),
  );
}
