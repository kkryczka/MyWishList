import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'colorCode.dart';
import 'screens/home_screen.dart';
import 'screens/add_wish_screen.dart';
import 'screens/detail_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
    GoRoute(path: '/add', builder: (_, _) => const AddWishScreen()),
    GoRoute(path: '/item/:id', builder: (_, s) => DetailScreen(id: s.pathParameters['id']!)),
  ],
);

class ZachciankiApp extends StatelessWidget {
  const ZachciankiApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Zachcianki',
      theme: ThemeData(colorScheme: lightColorScheme, useMaterial3: true),
      darkTheme: ThemeData(colorScheme: darkColorScheme, useMaterial3: true),
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}


