import 'package:hive/hive.dart';

part 'hive_base.g.dart';

@HiveType(typeId: 0)
class ClipBoards {
  @HiveField(0)
  final String keys;

  @HiveField(1)
  final String values;

  ClipBoards(this.keys, this.values);
}
