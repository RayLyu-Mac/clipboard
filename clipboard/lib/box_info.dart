import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/services.dart';
import 'hive_base.dart';

Widget clip_info() {
  return WatchBoxBuilder(
      box: Hive.box("Clip_board"),
      builder: (context, clips) {
        return ListView.builder(
            itemCount: clips.length,
            itemExtent: 80,
            itemBuilder: ((context, index) {
              final clip = clips.getAt(index);
              return ListTile(
                trailing: IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    clips.deleteAt(index);
                  },
                ),
                onTap: () {
                  Clipboard.setData(
                      ClipboardData(text: clip.values.toString()));
                },
                title: Text("Key:" +
                    clip.keys.toString() +
                    " Value:" +
                    clip.values.toString()),
              );
            }));
      });
}
