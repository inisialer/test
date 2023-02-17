import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UtilEvent extends Equatable {
  const UtilEvent();

  @override
  List<Object> get props => [];
}

class UploadPrivateEvent extends UtilEvent {
  final File file;
  final String category;

  UploadPrivateEvent({@required this.file, @required this.category});

  @override
  String toString() => 'UploadPrivateEvent';
}

class UploadPublicEvent extends UtilEvent {
  final File file;
  final String category;

  UploadPublicEvent({@required this.file, @required this.category});

  @override
  String toString() => 'UploadPublicEvent';
}
class UploadConvertEvent extends UtilEvent {
  final File file;

  UploadConvertEvent({@required this.file});

  @override
  String toString() => 'UploadConvertEvent';
}



class SetDropdownEvent extends UtilEvent {
  final String item;
  final String category;

  SetDropdownEvent({@required this.item, @required this.category});

  @override
  String toString() => 'SetDropdownEvent';
}
