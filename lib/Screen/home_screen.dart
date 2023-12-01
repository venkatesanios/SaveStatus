import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:status_save/permission_check.dart';

class HomeStatus extends StatefulWidget {
  @override
  State<HomeStatus> createState() => _HomeStatusState();
}

class _HomeStatusState extends State<HomeStatus> {
  final _formKeydealer = GlobalKey<FormState>();
  String? dropdowninitialValue;
  // final Directory _newPhotoDir = Directory('/storage/emulated/0/Android/WhatsApp/Media/.Statuses');
  final Directory _newPhotoDir1 = Directory('/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');
 final Directory _newPhotoDir =
      Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  @override
  void initState() {
    super.initState();
    Permissionget();
        var per = PermissionClass();
    per.checkPermission(context, Permission.accessMediaLocation);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Save Status'),
          bottom: const TabBar(
            isScrollable: false,
            tabs: [
              Tab(
                text: 'Viedo',
                // icon: Icon(Icons.video_camera_back),
              ),
              Tab(
                text: 'image',
                // icon: Icon(Icons.image),
              ),
              Tab(
                text: 'saved',
                // icon: Icon(Icons.save),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 70),
          child: Form(
            key: _formKeydealer,
            child: TabBarView(
              children: [
                buildTab(0),
                buildTab(13),
                buildimage(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTab(int count) {
    if (count == 0) {
      return Center(child: const Text('Ther are no status available'));
    }
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.transparent),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: count,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                // color: Colors.amber,
                child: Center(child: Text('$index')),
              );
            }),
      ),
    );
  }

  Permissionget() async {
    final permissionStatus = await Permission.storage.status;
    if (permissionStatus.isDenied) {
      // Here just ask for the permission for the first time
      await Permission.storage.request();

      // I noticed that sometimes popup won't show after user press deny
      // so I do the check once again but now go straight to appSettings
      if (permissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      // Here open app settings for user to manually enable permission in case
      // where permission was permanently denied
      await openAppSettings();
    } else {
      // Do stuff that require permission here
    }
  }

  Widget buildimage(BuildContext context)  {
  if (!_newPhotoDir.existsSync()) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Directory not found',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      );
    } else {
    final imageList = _newPhotoDir.listSync().map((item) => item.path).where((item) => item.endsWith('.jpg')).toList(growable: false);
    print('imageList:  $imageList ');
    if (imageList.length > 0) {
      return Container(
          margin: const EdgeInsets.all(8.0),
          child: GridView.builder(
            key: PageStorageKey(widget.key),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150),
            itemCount: imageList.length,
            itemBuilder: (BuildContext context, int index) {
              final String imgPath = imageList[index];
              return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: GestureDetector(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ViewPhotos(
                    //         imgPath: imgPath,
                    //       ),
                    //     ),
                    //   );
                    // },

                    //                 Center(
                    //   child: Image.file(
                    //     File(widget.imgPath),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    child: Image.file(
                      File(imageList[index]),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                    ),
                  ));
            },
          ));
    } else {
      return Scaffold(
        body: Center(
          child: Container(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: const Text(
                'Sorry, No Image Found!',
                style: TextStyle(fontSize: 18.0),
              )),
        ),
      );
    }
  }
}
}
