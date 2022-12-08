import 'package:flutter/material.dart';
import '../screen_imageview.dart';
import 'package:hive/hive.dart';
import 'tab_settings.dart';

class GalleryTab extends StatelessWidget {
  const GalleryTab({super.key});

  // const List<String> _items = List<String>.generate(10000, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
    return ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  title: Text('image'),
                  leading: Icon(Icons.movie),
                  subtitle: Text('subtitle'),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ImageView()))));
        });
  }
}