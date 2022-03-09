import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  Scanner({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  File? selectedImage;
  String? message = "";

  Future getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selectedImage = File(pickedImage!.path);
    });
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
                onPressed: () {},
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
