import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:camera/camera.dart';

import 'tabs_home/tab_gallery.dart';
import 'tabs_home/tab_settings.dart';
import 'screen_camera.dart';
import 'package:blindspot/reusable/widgets/fbuilder_else_widgets.dart';
import 'package:blindspot/reusable/functions/local_storage.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late Future<Map<String, dynamic>> _mapAllImageDataFuture;

  @override
  void initState() {
    super.initState();
    _mapAllImageDataFuture = readMapAllImageData();
  }

  void callback() {
    setState(() {
      _mapAllImageDataFuture = readMapAllImageData();
      print("SET STATE");
    });
  }

  @override
  Widget build(BuildContext context) {
    // for debugging
    // readListAllImageData().then((Map<String, dynamic> m) {print(m.toString());});

    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
            future: _mapAllImageDataFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomeScreenTabController(
                    snapshot.data!,
                    callback: callback
                );
              } else if (snapshot.hasError) {
                // print(snapshot.error);
                return ElseError(massage: "Could not load the App!");
              } else {
                return ElseWaiting(massage: "Loading the App...");
              }
            }));
  }
}

class HomeScreenTabController extends StatefulWidget {
  const HomeScreenTabController(this.mapAllImageData, {super.key, required this.callback,});
  final Map<String, dynamic> mapAllImageData;
  final Function callback;

  @override
  State<HomeScreenTabController> createState() => _HomeScreenTabController();
}


class _HomeScreenTabController extends State<HomeScreenTabController> {


  @override
  Widget build(BuildContext context) {
    //var cloudDarkMode = FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.uid).get();
    var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await availableCameras().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) {
                          return CameraScreen(cameras: value);
                        },
                      settings: const RouteSettings(name: 'CameraScreen')
                    )
                ));
              },
              child: const Icon(Icons.camera_alt)),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const HomeScreenAppBar(),
          body: TabBarView(
            children: [
              GalleryTab(widget.mapAllImageData),
              SettingsTab(callback: widget.callback, darkMode: darkMode),
            ],
          ),
        ));
  }
}

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      color: Colors.orangeAccent,
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      child: TabBar(
        tabs: [
          Tab(text: "Images", icon: Icon(Icons.image)),
          Tab(text: "Settings", icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
