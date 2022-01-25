import 'package:hive/hive.dart';

part 'hive_base.g.dart';

@HiveType(typeId: 0)
class Clipboard {
  @HiveField(0)
  final String keys;

  @HiveField(1)
  final String values;

  Clipboard(this.keys, this.values);
}
