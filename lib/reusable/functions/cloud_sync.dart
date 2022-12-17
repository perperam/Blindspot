import 'package:firebase_core/firebase_core.dart';
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

void syncData(listElements){
  var local_path = "image_data";
  var user = FirebaseAuth.instance.currentUser?.uid;
  final storage = FirebaseStorage.instance.ref();

  for (var item in listElements.items){

  }
}

void uploadData(imageData) async{
  var local_path = "image_data";
  var user = FirebaseAuth.instance.currentUser?.uid;

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final File file = File('${appDocDir.path}/${imageData['uuid']}.json');

  var snapshot = FirebaseStorage.instance.ref()
      .child('$user')
      .putFile(file);
}