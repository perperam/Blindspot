import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'tabs_home/tab_gallery.dart';
import 'tabs_home/tab_settings.dart';
import 'screen_camera.dart';
import 'package:hive/hive.dart';
import 'package:blindspot/reusable/widgets/fbuilder_else_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeRoute();
}

class _HomeRoute extends State<HomeScreen> {

  // assure that map_all_image_data.json file is present and return its content
  Future<Map<String, dynamic>> readMapAllImageData() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final File pathMapAllImageData = File('${appDocDir.path}/map_all_image_data.json');

    if (await pathMapAllImageData.exists()) {
      // if available read from file and return its content as map
      final contents = await pathMapAllImageData.readAsString();
      return json.decode(contents);
    } else {
      // if not available create new empty at storage and return empty map
      Map<String, dynamic> empty = {};
      pathMapAllImageData.writeAsString(jsonEncode(empty));
      return empty;
    }
  }

  // assure that directory for ImageDate.json files is present
  _initDirImageData () async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory appDocDirImageData = Directory('${appDocDir.path}/image_data/');

    if (await appDocDirImageData.exists()) {
      // return appDocDirImageData
    } else {
      appDocDirImageData = await appDocDirImageData.create(recursive: true);
      // return appDocDirImageData
    }
  }

  @override
  void initState() {
    // assure that directory for ImageDate.json files is present
    _initDirImageData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // for debugging
    // readListAllImageData().then((Map<String, dynamic> m) {print(m.toString());});

    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
            future: readMapAllImageData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomeScreenTabController(snapshot.data!);
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
  const HomeScreenTabController(this.mapAllImageData, {super.key});
  final Map<String, dynamic> mapAllImageData;

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
              SettingsTab(value: darkMode),
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
