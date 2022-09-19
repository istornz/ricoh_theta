import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ricoh_theta/ricoh_theta.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _ricohThetaPlugin = RicohTheta();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ricoh Theta Plugin'),
        ),
        body: Column(children: [
          ElevatedButton(
            onPressed: () async {
              final data = _ricohThetaPlugin.getDeviceInfo();
              print(data);
            },
            child: const Text('Get device data'),
          )
        ]),
      ),
    );
  }
}
