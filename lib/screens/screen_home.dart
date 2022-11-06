import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'tabs_home/tab_gallery.dart';
import 'tabs_home/tab_settings.dart';
import 'screen_camera.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  State<HomeRoute> createState() => _HomeRoute();
}

class _HomeRoute extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await availableCameras().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CameraPage(cameras: value))));
              },
              child: const Icon(Icons.camera_alt)),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const BottomAppBar(
            color: Colors.orangeAccent,
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            child: TabBar(
              tabs: [
                Tab(text: "Images", icon: Icon(Icons.image)),
                Tab(text: "Settings", icon: Icon(Icons.settings)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              GalleryTab(),
              SettingsTab(),
            ],
          ),
        ));
  }
}
