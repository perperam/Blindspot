import 'package:flutter/material.dart';
import '../screen_imageview.dart';
import 'package:hive/hive.dart';
import 'tab_settings.dart';


class GalleryTab extends StatefulWidget {
  Map<String, dynamic> mapAllImageData;
  GalleryTab(this.mapAllImageData, {super.key});

  @override
  State<GalleryTab> createState() => _GalleryTab();
}

class _GalleryTab extends State<GalleryTab> {

  // const List<String> _items = List<String>.generate(10000, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    // List<Map<String, String>> listAllImageData;

    List<String> uuidKeys = widget.mapAllImageData.keys.toList();


    var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
    return ListView.builder(
        itemCount: widget.mapAllImageData.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  title: Text(widget.mapAllImageData[uuidKeys[index]]!['name']!),
                  leading: const Icon(Icons.movie),
                  subtitle: Text(widget.mapAllImageData[uuidKeys[index]]!['datetime']!),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => ImageViewScreen(
                              // get the uuid from mapAllImageData at index
                              uuidKeys[index]
                          )
                      )
                  )
              ));
        });
  }
}