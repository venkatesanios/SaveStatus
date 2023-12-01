import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

 
 

class HomeStatus1 extends StatefulWidget {
  @override
  State<HomeStatus1> createState() => _HomeStatusState();
}

class _HomeStatusState extends State<HomeStatus1> {
  final Directory _newPhotoDir = Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  List<String> imageList = [];

  @override
  void initState() {
    super.initState();
    checkAndRequestPermission();
  }

  Future<void> checkAndRequestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        // Handle permission denied
        return;
      }
    }
    accessFiles();
  }

  Future<void> accessFiles() async {
    if (!_newPhotoDir.existsSync()) {
      // Directory does not exist
      return;
    }

    imageList = _newPhotoDir
        .listSync()
        .where((item) => item.path.endsWith('.jpg'))
        .map((item) => item.path)
        .toList(growable: false);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp Statuses'),
      ),
      body: imageList.isEmpty
          ? Center(
              child: Text('No images found'),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return Image.file(
                  File(imageList[index]),
                  fit: BoxFit.cover,
                );
              },
            ),
    );
  }
}
