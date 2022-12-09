import 'package:flutter/material.dart';

enum FileTypeEnum {
  image('IMAGE', Icons.image),
  audio('AUDIO', Icons.audio_file),
  video('VIDEO', Icons.video_file),
  application('APPLICATION', Icons.apps),
  other('', Icons.attachment);

  final String value;
  final IconData icon;

  const FileTypeEnum(this.value, this.icon);
}
