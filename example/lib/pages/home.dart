import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ricoh_theta/ricoh_theta.dart';
import 'package:ricoh_theta_example/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _ricohThetaPlugin = RicohTheta();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ricoh Theta Plugin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final picturePath = await _ricohThetaPlugin.takePicture();
              if (picturePath == null) {
                return;
              }

              showResultDialog(
                context,
                child: Image.file(
                  File(picturePath),
                ),
              );
            },
            child: const Text('Take picture'),
          ),
          Expanded(
            child: ListView(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
