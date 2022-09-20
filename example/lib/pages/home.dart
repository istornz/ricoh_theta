import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ricoh_theta/models/image_infoes.dart';
import 'package:ricoh_theta/ricoh_theta.dart';
import 'package:ricoh_theta_example/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _ricohThetaPlugin = RicohTheta();
  List<ImageInfoes> _imageInfoes = [];

  @override
  void initState() {
    super.initState();
  }

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
          Flexible(
            child: Container(
              // color: Colors.red,
              child: Stack(
                children: [
                  StreamBuilder<Uint8List>(
                      stream: _ricohThetaPlugin.listenCameraImages(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Image.memory(snapshot.data!);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                  Center(
                      child: ElevatedButton(
                    onPressed: () {
                      _ricohThetaPlugin.startLiveView();
                    },
                    child: Text('Start Live'),
                  )),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              ElevatedButton(
                onPressed: () async {
                  getImages();
                },
                child: const Text('Refresh files'),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
              itemCount: _imageInfoes.length,
              itemBuilder: (context, index) {
                final ImageInfoes imageInfoes = _imageInfoes[index];
                return ListTile(
                  title: Text(imageInfoes.fileName),
                  subtitle: Text(
                    '${imageInfoes.imagePixWidth} * ${imageInfoes.imagePixHeight}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  getImages() async {
    final images = await _ricohThetaPlugin.getImageInfoes();

    setState(() {
      _imageInfoes = images;
    });
  }
}
