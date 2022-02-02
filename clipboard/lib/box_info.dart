import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:open_file/open_file.dart';
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
            itemExtent: 130,
            itemBuilder: ((context, index) {
              final clip = clips.getAt(index);
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.shade300,
                ),
                child: ListTile(
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () {
                      clips.deleteAt(index);
                    },
                  ),
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: clip.values.toString()));
                    OpenFile.open(clip.values.toString());
                  },
                  title: Text("Key:" +
                      clip.keys.toString() +
                      " \nValue:" +
                      clip.values.toString()),
                ),
              );
            }));
      });
}
