import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ricoh_theta_example/ricoh_theta_service.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final _ricohService = RicohThetaService.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ipAddressTextController =
      TextEditingController(text: '192.168.1.1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _ipAddressTextController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an IP address';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _ricohService
                      .setTargetIp(ipAddress: _ipAddressTextController.text);
                  await _ricohService.getDeviceInfo()
                      .then((value) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Impossible to connect to the camera'),
                    ));
                  });
                }
              },
              child: const Text('Set target IP'),
            ),
          ],
        ),
      ),
    );
  }
}
