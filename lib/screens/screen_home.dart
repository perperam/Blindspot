import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'tabs_home/tab_gallery.dart';
import 'tabs_home/tab_settings.dart';
import 'screen_camera.dart';
import 'package:hive/hive.dart';
import 'package:blindspot/fbuilder_else_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  State<HomeRoute> createState() => _HomeRoute();
}

class _HomeRoute extends State<HomeRoute> {
  // get path to local storage
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // path to file in local storage
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/map_all_image_data.json');
  }

  Future<Map<String, dynamic>> loadDefaultAsset() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/map_all_image_data.json");
    return jsonDecode(data);
  }

  // write json from assets if missing
  writeDefault() async {
    Map<String, dynamic> listAllImageData;

    listAllImageData = await loadDefaultAsset();

    final file = await _localFile;

    // Write the file
    file.writeAsString(jsonEncode(listAllImageData));
  }

  Future<Map<String, dynamic>> readMapAllImageData() async {
    writeDefault();

    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();

    return json.decode(contents);
  }

  // _initFileMapAllImageData() async {
  //   final Directory appDocDir = await getApplicationDocumentsDirectory();
  //   File pathMapAllImageData = File('${appDocDir.path}/map_all_image_data.json');
  //
  //   if (await pathMapAllImageData.exists()) {
  //     return pathMapAllImageData;
  //   } else {
  //     pathMapAllImageData = await pathMapAllImageData.create(recursive: true);
  //     // return appDocDirImageData
  //   }
  // }

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
                print(snapshot.error);
                return ElseError(massage: "Could not load the App!");
              } else {
                return ElseWaiting(massage: "Loading the App...");
              }
            }));
  }
}

class HomeScreenTabController extends StatelessWidget {
  Map<String, dynamic> mapAllImageData;

  HomeScreenTabController(this.mapAllImageData, {super.key});

  @override
  Widget build(BuildContext context) {
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
                      settings: RouteSettings(name: 'CameraScreen')
                    )
                ));
              },
              child: const Icon(Icons.camera_alt)),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const HomeScreenAppBar(),
          body: TabBarView(
            children: [
              GalleryTab(mapAllImageData),
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
