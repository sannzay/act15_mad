import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return windows;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDpdIvlmNeBx60a4STC4nkI87AKzq6DUmA',
    appId: '1:407509906103:android:663ab24cce5a33e1089332',
    messagingSenderId: '407509906103',
    projectId: 'inventory-app-sanjayreddy',
    storageBucket: 'inventory-app-sanjayreddy.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCD15D89smm0ad9eE--u0LK7TuqHUiSZcA',
    appId: '1:407509906103:ios:f25464b603557062089332',
    messagingSenderId: '407509906103',
    projectId: 'inventory-app-sanjayreddy',
    storageBucket: 'inventory-app-sanjayreddy.firebasestorage.app',
    iosBundleId: 'com.example.act15Mad',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAE1K5fe14twCG73EzZ58rMyi4mxg9bE2o',
    appId: '1:407509906103:web:3dca90ae0df135ef089332',
    messagingSenderId: '407509906103',
    projectId: 'inventory-app-sanjayreddy',
    authDomain: 'inventory-app-sanjayreddy.firebaseapp.com',
    storageBucket: 'inventory-app-sanjayreddy.firebasestorage.app',
    measurementId: 'G-S005T3LMS8',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCD15D89smm0ad9eE--u0LK7TuqHUiSZcA',
    appId: '1:407509906103:ios:f25464b603557062089332',
    messagingSenderId: '407509906103',
    projectId: 'inventory-app-sanjayreddy',
    storageBucket: 'inventory-app-sanjayreddy.firebasestorage.app',
    iosBundleId: 'com.example.act15Mad',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAE1K5fe14twCG73EzZ58rMyi4mxg9bE2o',
    appId: '1:407509906103:web:eed8e4199ae2a6b4089332',
    messagingSenderId: '407509906103',
    projectId: 'inventory-app-sanjayreddy',
    authDomain: 'inventory-app-sanjayreddy.firebaseapp.com',
    storageBucket: 'inventory-app-sanjayreddy.firebasestorage.app',
    measurementId: 'G-P30BFBTVXH',
  );

}
