import 'package:hive/hive.dart';
import 'package:slinfy_crm_admin/src/models/offline_model/user_object.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
enum UserType { ADMIN, HR, TRAINER, TRAINEE }

class Commons {
  late final BoxCollection collection;
  late final CollectionBox<UserObject> userBox ;
  late final List<UserObject?> getAllUserObject ;

  static getDate(){
    return DateFormat('dd/MM/yy').format(DateTime.now());
  }

  static String getTime(){
    return DateFormat('kk:mm').format(DateTime.now());
  }
  createObjectBox() async {
    collection = await BoxCollection.open(
      'slinfy_crm', // Name of your database
      {'users', 'demo'}, // Names of your boxes
      path: './',
      // Path where to store your boxes (Only used in Flutter / Dart IO)
      key: HiveAesCipher([
        1234567890
      ]), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
    );
  }

  openUserBox() async {
    userBox =  await collection.openBox<UserObject>('users');
  }

  addUserBoxData(UserObject userObject) async {
    await userBox.put('user',userObject);
  }

 getBoxData() async {
    getAllUserObject =  await userBox.getAll(['user']);
  }
}
