import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;


class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  var apiUrlString = Uri.parse('http://dev.icatas.eu:5000/string');
  var apiUrlPicture = Uri.parse('http://dev.icatas.eu:5000/picture');

  Future<String> fetchString() async {
    final response = await http.get(apiUrlString);
    return response.body;
  }

  // , body:widget.picture

  Future<String> postPic() async {
    var request = http.MultipartRequest('POST', apiUrlPicture);
    request.files.add(await http.MultipartFile.fromPath('image', widget.picture.path)); // HERE IS THE ERROR

    var streamedResponse = await request.send();
    final responseString = await http.Response.fromStream(streamedResponse);
    return responseString.body;
  }

  late Future<String> futurehttp;
  late Future<String> futureImg;

  @override
  void initState() {
    super.initState();
    // futurehttp = fetchString();
    futureImg = postPic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(File(widget.picture.path), fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
          Text(widget.picture.name),
          Container(child: FutureBuilder<String>(
            future: futureImg,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              }
              return const CircularProgressIndicator();
            }
          ))
        ]),
      ),
    );
  }
}
