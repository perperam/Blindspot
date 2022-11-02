import 'package:flutter/material.dart';
import 'tabs/tabs_home.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: null, child: Icon(Icons.camera_alt)),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
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
          body: TabBarView(
            children: [
              GalleryTab(),
              SettingsTab(),
            ],
          ),
        ));
  }
}
