import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:blindspot/reusable/functions/local_storage.dart';

Future cloudListData () async{
  var user = FirebaseAuth.instance.currentUser?.uid;
  final storageRef = FirebaseStorage.instance.ref().child("$user");
  final listResult = await storageRef.listAll();

  return listResult;
}

Future<dynamic> syncData() async{
  var user = FirebaseAuth.instance.currentUser?.uid;
  final storageRef = FirebaseStorage.instance.ref();
  final storageRefRef = FirebaseStorage.instance.ref().child("$user");
  final listResult = await storageRefRef.listAll();
  final Directory appDocDir = await getApplicationDocumentsDirectory();

  print(storageRefRef);
  print(listResult);

  for (var item in listResult.items){
    print("item:$item");
    final imageRef = storageRef.child("$item");
    final File file = File('${appDocDir.path}/user_data/test_image_data.json');

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

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final File file = File('${appDocDir.path}/${imageData['uuid']}.json');

  await storageRef
        .child('$user/${imageData['uuid']}.json')
        .putFile(file);

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