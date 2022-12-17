import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future cloudListData () async{
  var user = FirebaseAuth.instance.currentUser?.uid;
  final storageRef = FirebaseStorage.instance.ref().child("$user");
  final listResult = await storageRef.listAll();

  return listResult;
}

void syncData(listElements) async{
  var user = FirebaseAuth.instance.currentUser?.uid;
  final storageRef = FirebaseStorage.instance.ref();
  final Directory appDocDir = await getApplicationDocumentsDirectory();


  for (var item in listElements.items){
    final imageRef = storageRef.child("$user/$item");
    final File file = File('${appDocDir.path}/$item');

    final downloadTask = imageRef.writeToFile(file);
    downloadTask.snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
        // TODO: Handle this case.
          break;
        case TaskState.paused:
        // TODO: Handle this case.
          break;
        case TaskState.success:
          print("success");
          break;
        case TaskState.canceled:
        // TODO: Handle this case.
          break;
        case TaskState.error:
          print("error");
          break;
      }
    });

  }
}

void uploadData(imageData) async{
  var user = FirebaseAuth.instance.currentUser?.uid;
  final storageRef = FirebaseStorage.instance.ref();

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final File file = File('${appDocDir.path}/${imageData['uuid']}.json');

  await storageRef
        .child('$user/${imageData['uuid']}.json')
        .putFile(file);
}

void deleteUserCloudData(listElements) async{
  var user = FirebaseAuth.instance.currentUser?.uid;
  final storageRef = FirebaseStorage.instance.ref();


  for (var item in listElements.items){
    await storageRef
          .child("$user/$item")
          .delete();
  }

}