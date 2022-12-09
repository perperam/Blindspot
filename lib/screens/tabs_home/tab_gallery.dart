import 'package:flutter/material.dart';
import '../screen_imageview.dart';
import 'package:hive/hive.dart';
import 'tab_settings.dart';

class GalleryTab extends StatelessWidget {
  final Map<String, dynamic> mapAllImageData;
  const GalleryTab(this.mapAllImageData, {super.key});

  // const List<String> _items = List<String>.generate(10000, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    // List<Map<String, String>> listAllImageData;

    List<String> keys = mapAllImageData.keys.toList();

    var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
    return ListView.builder(
        itemCount: mapAllImageData.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  title: Text(mapAllImageData[keys[index]]!['name']!),
                  leading: const Icon(Icons.movie),
                  subtitle: Text(mapAllImageData[keys[index]]!['datetime']!),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ImageView()))));
        });
  }
}