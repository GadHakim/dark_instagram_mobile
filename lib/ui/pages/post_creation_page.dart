import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/utils/gradients.dart';

class PostCreationPage extends StatefulWidget {
  @override
  _PostCreationPageState createState() => _PostCreationPageState();
}

class _PostCreationPageState extends State<PostCreationPage> {
  List<File> _images = [];
  String _comment = '';

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    setState(() {
      if (image != null) _images.add(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: darkBackgroundGradient(),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: _buildPresentation(),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    TextFormField(
                      onChanged: (comment) {
                        _comment = comment;
                      },
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          hintText: 'Comment'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Gallery",
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            onPressed: () => getImage(ImageSource.gallery),
                          ),
                          SizedBox(width: 10.0),
                          MaterialButton(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Camera",
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            onPressed: () => getImage(ImageSource.camera),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 32.0),
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Publish",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  onPressed: _images.length == 0 ? null : () => _publishRequest,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPresentation() {
    if (_images.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Add Images",
            style: TextStyle(
              fontFamily: 'Billabong',
              fontSize: 48.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            "Click on the camera or gallery button",
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
        ],
      );
    } else {
      return PageView.builder(
        itemCount: _images.length,
        itemBuilder: (BuildContext context, int index) {
          final File file = _images[index];
          return Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Image.file(
                  file,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 40.0,
                right: 20.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('${index + 1}/${_images.length}'),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  _publishRequest() {
    // soon
  }
}
