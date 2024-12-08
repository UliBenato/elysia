// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBmzDN6jy1Noqf-O4VF5_zgm_YxYGeNfnI',
    appId: '1:664204796211:web:dbefa252c244ba78075e46',
    messagingSenderId: '664204796211',
    projectId: 'elysia-ff0f6',
    authDomain: 'elysia-ff0f6.firebaseapp.com',
    databaseURL: 'https://elysia-ff0f6-default-rtdb.firebaseio.com',
    storageBucket: 'elysia-ff0f6.firebasestorage.app',
    measurementId: 'G-LD6V829G2R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxaCo2mm_e2PhtNRhc5EeOZ6uZLsIx38o',
    appId: '1:664204796211:android:d55bd13d6a473c85075e46',
    messagingSenderId: '664204796211',
    projectId: 'elysia-ff0f6',
    databaseURL: 'https://elysia-ff0f6-default-rtdb.firebaseio.com',
    storageBucket: 'elysia-ff0f6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUkwycbdaPK8SwZzr0qPRBUK_IIxM7ExM',
    appId: '1:664204796211:ios:78dfb31ba35a91a1075e46',
    messagingSenderId: '664204796211',
    projectId: 'elysia-ff0f6',
    databaseURL: 'https://elysia-ff0f6-default-rtdb.firebaseio.com',
    storageBucket: 'elysia-ff0f6.firebasestorage.app',
    iosClientId: '664204796211-08u076c1vuu92k5i9qg2ls0aj728ki09.apps.googleusercontent.com',
    iosBundleId: 'br.com.casabotanica.elysiaSensor',
  );
}
