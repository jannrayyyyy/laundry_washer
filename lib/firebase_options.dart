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
    apiKey: 'AIzaSyDI0rexDnyYDvnxtXAe9XZFTKq7Yu-333U',
    appId: '1:134214055008:web:6185dd48f4393eb724bf05',
    messagingSenderId: '134214055008',
    projectId: 'laundry-2-25e46',
    authDomain: 'laundry-2-25e46.firebaseapp.com',
    storageBucket: 'laundry-2-25e46.appspot.com',
    measurementId: 'G-45TXF9TED7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdKMSFJTSnFOwutU9rhjRVF22NpgtsUek',
    appId: '1:134214055008:android:c56385cff1fdeb5c24bf05',
    messagingSenderId: '134214055008',
    projectId: 'laundry-2-25e46',
    storageBucket: 'laundry-2-25e46.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBW6hf13fNSAsugAMpqVfuUovCMayc7MC4',
    appId: '1:134214055008:ios:6c3ce3524bb1987024bf05',
    messagingSenderId: '134214055008',
    projectId: 'laundry-2-25e46',
    storageBucket: 'laundry-2-25e46.appspot.com',
    androidClientId: '134214055008-11c1hoc1ta1qa386gg5ku1cglh8t63km.apps.googleusercontent.com',
    iosClientId: '134214055008-1r2m20u7n81r27qm2rneka8ba4v2igci.apps.googleusercontent.com',
    iosBundleId: 'com.example.laundryWasher',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBW6hf13fNSAsugAMpqVfuUovCMayc7MC4',
    appId: '1:134214055008:ios:6c3ce3524bb1987024bf05',
    messagingSenderId: '134214055008',
    projectId: 'laundry-2-25e46',
    storageBucket: 'laundry-2-25e46.appspot.com',
    androidClientId: '134214055008-11c1hoc1ta1qa386gg5ku1cglh8t63km.apps.googleusercontent.com',
    iosClientId: '134214055008-1r2m20u7n81r27qm2rneka8ba4v2igci.apps.googleusercontent.com',
    iosBundleId: 'com.example.laundryWasher',
  );
}