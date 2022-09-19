import 'package:flutter/material.dart';
import 'package:ricoh_theta_example/pages/connect.dart';
import 'package:ricoh_theta_example/pages/home.dart';
import 'package:ricoh_theta_example/pages/settings.dart';

void main() {
  runApp(const RicohThetaApp());
}

class RicohThetaApp extends StatefulWidget {
  const RicohThetaApp({super.key});

  @override
  State<RicohThetaApp> createState() => _RicohThetaAppState();
}

class _RicohThetaAppState extends State<RicohThetaApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/connect',
      routes: {
        '/connect': (context) => const ConnectPage(),
        '/home': (context) => const HomePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
