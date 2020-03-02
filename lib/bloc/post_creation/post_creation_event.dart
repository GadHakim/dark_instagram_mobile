import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class PostCreationEvent extends Equatable {}

class FetchAddPostEvent extends PostCreationEvent {
  final String comment;
  final List<File> file;

  FetchAddPostEvent(
    this.comment,
    this.file,
  );

  @override
  List<Object> get props => null;
}
