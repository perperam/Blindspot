import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// const names in local storage
const String _fileNameMapAllImageData =  'map_all_image_data.json';
const String _directoryNameImageData = 'image_data';

// The mapAllImageData functions could be enhanced by abstract them into a class

Future<Map<String, dynamic>> readMapAllImageData() async {
  // create path vars
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final File pathMapAllImageData = File('${appDocDir.path}/$_fileNameMapAllImageData');

  // read json file
  if (await pathMapAllImageData.exists()) {
    // if available read from file and return its content as map
    final contents = await pathMapAllImageData.readAsString();
    return json.decode(contents);
  } else {
    // if not available create new empty at storage and return empty map
    final Map<String, dynamic> empty = {};
    pathMapAllImageData.writeAsString(jsonEncode(empty));
    return empty;
  }
}

Future<bool> writeMapAllImageData(Map<String, dynamic> mapAllImageData) async {
  // THIS FUNCTION WILL OVERWRITE EXISTING DATA!!
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final File pathMapAllImageData = File('${appDocDir.path}/$_fileNameMapAllImageData');

  pathMapAllImageData.writeAsString(jsonEncode(mapAllImageData));

  return true;
}

Future<bool> addToMapAllImageData(Map<String, dynamic> newImageData) async {
  // get existing map
  final Map<String, dynamic> mapAllImageData = await readMapAllImageData();

  // convert new imageData to format mapAllImageData
  final Map<String, dynamic> newMap = {
    (newImageData)['uuid'] : {
      'name' : (newImageData)['name'],
      'datetime' : (newImageData)['metadata']['datetime']
    }
  };

  // add to newMap so that the new Data is at beginning of the Map
  // this is to keep it chronological in mapAllImageData as stack
  newMap.addAll(mapAllImageData);

  // override file with new map
  writeMapAllImageData(newMap);

  return true;
}



Future<Directory> getAppDocDirImageData() async {
  // create path vars
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final Directory appDocDirImageData = Directory('${appDocDir.path}/$_directoryNameImageData');

  // when directory is missing create it
  if ( !(await appDocDirImageData.exists()) ) {
    await appDocDirImageData.create(recursive: true);
  }

  return appDocDirImageData;
}

Future<bool> saveImageData(Map<String, dynamic> imageData) async {
  // create path vars
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final Directory appDocDirImageData = Directory('${appDocDir.path}/$_directoryNameImageData');
  final File pathImageData = File('${appDocDirImageData.path}/${imageData['uuid']}.json');

  // save json file
  pathImageData.writeAsString(jsonEncode(imageData));

  return true;
}

void deleteImageData(String imageUuid) {

}

void deleteAllImageData() async {
  // delete imageData
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final File pathMapAllImageData = File('${appDocDir.path}/$_fileNameMapAllImageData');
  final Directory appDocDirImageData = Directory('${appDocDir.path}/$_directoryNameImageData');

  // delete mapAllImageData
  await pathMapAllImageData.delete(recursive: true);
  await appDocDirImageData.delete(recursive: true);
}