import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/bloc/post_creation/post_creation_bloc.dart';
import 'package:instagram/bloc/post_creation/post_creation_event.dart';
import 'package:instagram/bloc/post_creation/post_creation_state.dart';
import 'package:instagram/utils/alerts.dart';
import 'package:instagram/utils/gradients.dart';

class PostCreationPage extends StatefulWidget {
  @override
  _PostCreationPageState createState() => _PostCreationPageState();
}

class _PostCreationPageState extends State<PostCreationPage> {
  String _comment = '';
  List<File> _images = [];

  PostCreationBloc _postCreationBloc;

  @override
  void initState() {
    super.initState();
    _postCreationBloc = BlocProvider.of<PostCreationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PostCreationBloc, PostCreationState>(
        listener: (BuildContext context, PostCreationState state) => _blocListener(context, state),
        child: SingleChildScrollView(
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
                    onPressed: _images.length == 0 || _comment.length == 0 ? null : () => _publishAddPostRequest(),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
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

  _blocListener(BuildContext context, PostCreationState state) {
    if (state is PostCreationLoadingState) {
      showLoadingDialog(context);
    } else if (state is PostCreationLoadedState) {
      closeLoadingDialog(context);
      Navigator.of(context).pop();
    } else if (state is PostCreationErrorState) {
      closeLoadingDialog(context);
      showDialogMessage(context, 'Error', state.message);
    }
  }

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  _publishAddPostRequest() {
    _postCreationBloc.add(FetchAddPostEvent(
      _comment,
      _images,
    ));
  }
}
