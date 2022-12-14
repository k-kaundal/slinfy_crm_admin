// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBfU6eE4zW9HAnUpRNwRDfyiwzmadX97jg',
    appId: '1:774640621936:web:004a632b2f7a43359157b5',
    messagingSenderId: '774640621936',
    projectId: 'slinfy-crm',
    authDomain: 'slinfy-crm.firebaseapp.com',
    databaseURL: 'https://slinfy-crm-default-rtdb.firebaseio.com',
    storageBucket: 'slinfy-crm.appspot.com',
    measurementId: 'G-B1FJS92J7P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCorqimdWiWaPZyvvUJdMvd9hFmDTX6DlA',
    appId: '1:774640621936:android:e45feef0fc297c5a9157b5',
    messagingSenderId: '774640621936',
    projectId: 'slinfy-crm',
    databaseURL: 'https://slinfy-crm-default-rtdb.firebaseio.com',
    storageBucket: 'slinfy-crm.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBpqdS84Sx8iTwM6eToZXcKZ_EurK6xmzM',
    appId: '1:774640621936:ios:2368df54709a714a9157b5',
    messagingSenderId: '774640621936',
    projectId: 'slinfy-crm',
    databaseURL: 'https://slinfy-crm-default-rtdb.firebaseio.com',
    storageBucket: 'slinfy-crm.appspot.com',
    iosClientId: '774640621936-ok3jhdh9j0afbmdv0d4d30usr2nlsqv5.apps.googleusercontent.com',
    iosBundleId: 'com.slinfy.slinfyCrmAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBpqdS84Sx8iTwM6eToZXcKZ_EurK6xmzM',
    appId: '1:774640621936:ios:2368df54709a714a9157b5',
    messagingSenderId: '774640621936',
    projectId: 'slinfy-crm',
    databaseURL: 'https://slinfy-crm-default-rtdb.firebaseio.com',
    storageBucket: 'slinfy-crm.appspot.com',
    iosClientId: '774640621936-ok3jhdh9j0afbmdv0d4d30usr2nlsqv5.apps.googleusercontent.com',
    iosBundleId: 'com.slinfy.slinfyCrmAdmin',
  );
}
