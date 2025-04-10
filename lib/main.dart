// lib/main.dart
import 'package:flutter/material.dart';
import 'package:machinetest_10042025/screens/home.dart';
import 'package:machinetest_10042025/services/event_services.dart';
import 'package:machinetest_10042025/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'providers/event_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<http.Client>(
          create: (_) => http.Client(),
        ),
        Provider<EventService>(
          create: (context) =>
              EventService(client: context.read<http.Client>()),
        ),
        ChangeNotifierProxyProvider<EventService, EventProvider>(
          create: (context) =>
              EventProvider(eventService: context.read<EventService>()),
          update: (context, eventService, eventProvider) =>
              eventProvider!..initialize(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Calendar',
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
    );
  }
}

class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}
