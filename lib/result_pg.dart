import 'package:flutter/material.dart';

class SeeResult extends StatelessWidget {
  const SeeResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SEE RESULTS"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Go Back"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class Results {
  var ocr_result;
  var obj_file;
  var land_file_path;
}
