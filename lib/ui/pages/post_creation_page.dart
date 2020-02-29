import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostCreationPage extends StatefulWidget {
  @override
  _PostCreationPageState createState() => _PostCreationPageState();
}

class _PostCreationPageState extends State<PostCreationPage> {

  List<File> _images = [];

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _images.add(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

      ),
    );
  }
}
