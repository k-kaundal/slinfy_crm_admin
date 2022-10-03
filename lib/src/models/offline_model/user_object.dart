import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class UserObject extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;

  UserObject({this.name = '', this.password = '', this.email = ''});
}
