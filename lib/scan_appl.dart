import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'scan_assts.dart';
import 'result_pg.dart';

Map<int, Color> colorCodes = {
  50: Color.fromRGBO(255, 255, 255, 0),
  100: Color.fromRGBO(255, 255, 255, .1),
  200: Color.fromRGBO(255, 255, 255, .2),
  300: Color.fromRGBO(255, 255, 255, .3),
  400: Color.fromRGBO(147, 205, 72, .5),
  500: Color.fromRGBO(147, 205, 72, .6),
  600: Color.fromRGBO(147, 205, 72, .7),
  700: Color.fromRGBO(147, 205, 72, .8),
  800: Color.fromRGBO(147, 205, 72, .9),
  900: Color.fromRGBO(255, 255, 255, 1),
};
MaterialColor custom = MaterialColor(0x00000000, colorCodes);

class Scanner extends StatefulWidget {
  Scanner({Key? key, required this.title, required this.file_name})
      : super(key: key);
  final String title;
  final String file_name;

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  File? selectedImage;
  String? message = "";

  Future getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(pickedImage!.path);
    });
  }

  uploadImage() async {
    final request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://4915-2405-201-1f-ae-a9d6-f597-e1d3-1230.ngrok.io/upload"));

    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile("image",
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));

    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    message = resJson["message"];
    var txt = resJson["ocr_result"];

    File jsfile = new File("/assets/jsons/" + widget.file_name);
    jsfile.createSync();
    jsfile.writeAsStringSync(jsonEncode(res));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: custom[50],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            selectedImage != null
                ? Image.file(selectedImage!)
                : Text(
                    "Take a pic or upload Application Image",
                  ),
            TextButton.icon(
                // ignore: prefer_const_constructors
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    elevation: MaterialStateProperty.all(10.0)),
                onPressed: uploadImage,
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo_outlined),
      ),
    );
  }
}
