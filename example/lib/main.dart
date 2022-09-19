import 'package:flutter/material.dart';
import 'package:ricoh_theta/models/device_info.dart';
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
  DeviceInfo? _deviceInfo;
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
              _ricohThetaPlugin.init();
            },
            child: const Text('Init'),
          ),
          ElevatedButton(
            onPressed: () async {
              final data = await _ricohThetaPlugin.getDeviceInfo();
              setState(() {
                _deviceInfo = data;
              });
            },
            child: const Text('Get device data'),
          ),
          Text(_deviceInfo?.model ?? ''),
          Text(_deviceInfo?.serialNumber ?? ''),
          Text(_deviceInfo?.firmwareVersion ?? ''),
        ]),
      ),
    );
  }
}
