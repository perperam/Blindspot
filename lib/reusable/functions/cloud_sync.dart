import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:blindspot/reusable/functions/local_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';




Future<dynamic> syncData() async{
  var user = FirebaseAuth.instance.currentUser?.uid;
  final storageRef = FirebaseStorage.instance.ref();
  final storageRefRef = FirebaseStorage.instance.ref().child("$user");
  final listResult = await storageRefRef.listAll();

  final Directory appDocDirImageData = await getAppDocDirImageData();

  print(storageRefRef);
  print(listResult);

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final allImageFile = File('${appDocDir.path}/$fileNameMapAllImageData');
  final allImageRef = storageRef.child("$user/$fileNameMapAllImageData");

  final downloadTask = allImageRef.writeToFile(allImageFile);
  downloadTask.snapshotEvents.listen((taskSnapshot) {
    switch (taskSnapshot.state) {
      case TaskState.running:
        print("running");
        break;
      case TaskState.paused:
        print("paused");
        break;
      case TaskState.success:
        print("success");
        break;
      case TaskState.canceled:
        print("canceled");
        break;
      case TaskState.error:
        print("error");
        break;
    }
  });

  for (var item in listResult.items){
    print("item:$item");
    print("type:${item.toString()}");
    final imageRef = storageRef.child("$item");

    var str = item.toString();
    const start = "/";
    const end = ")";

    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, startIndex + start.length);

    var filename = str.substring(startIndex + start.length, endIndex);

    print("filename:$filename");
    final file = File("${appDocDirImageData.path}/$filename");
    final downloadTask = item.writeToFile(file);
    downloadTask.snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          print("running");
          break;
        case TaskState.paused:
          print("paused");
          break;
        case TaskState.success:
          print("success");
          break;
        case TaskState.canceled:
          print("canceled");
          break;
        case TaskState.error:
          print("error");
          break;
      }
    });
  }
}

Future<bool> uploadData(Map<String, dynamic> imageData) async{
  var user = FirebaseAuth.instance.currentUser?.uid;
  final storageRef = FirebaseStorage.instance.ref();

  final Directory appDocDirImageData = await getAppDocDirImageData();
  final Directory appDocDir = await getApplicationDocumentsDirectory();

  final File file = File('${appDocDirImageData.path}/${imageData['uuid']}.json');
  final File allImageMap = File('${appDocDir.path}/${imageData['uuid']}.json');

  await storageRef
        .child('$user/${imageData['uuid']}.json')
        .putFile(file);

  await storageRef
      .child('$user/${imageData['uuid']}.json')
      .putFile(allImageMap);

  return true;
}

void deleteUserCloudData() async{
  var user = FirebaseAuth.instance.currentUser?.uid;
  final storageRef = FirebaseStorage.instance.ref();
  final storageRefRef = FirebaseStorage.instance.ref().child("$user");
  final listResult = await storageRefRef.listAll();

  print(storageRefRef);


  for (var item in listResult.items){
    print(item);
    await item.delete();
  }
  print("everything deleted");

}