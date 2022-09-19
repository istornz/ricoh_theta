import 'package:flutter/material.dart';
import 'package:ricoh_theta/models/device_info.dart';
import 'package:ricoh_theta/ricoh_theta.dart';
import 'package:ricoh_theta_example/utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _ricohThetaPlugin = RicohTheta();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final deviceInfo = await _ricohThetaPlugin.getDeviceInfo();
              if (deviceInfo == null) {
                return;
              }
              showResultDialog(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Model: ${deviceInfo.model}'),
                    Text('Firmware: ${deviceInfo.firmwareVersion}'),
                    Text('Serial: ${deviceInfo.serialNumber}'),
                  ],
                ),
              );
            },
            child: const Text('Get device data'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _ricohThetaPlugin.disconnect();
              Navigator.pushReplacementNamed(context, '/connect');
            },
            child: const Text('Disconnect'),
          ),
        ],
      ),
    );
  }
}
