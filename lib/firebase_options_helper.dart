import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseOptionsHelper {
  static FirebaseOptions get options {
    if (kIsWeb) {
      return FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY_WEB']!,
        appId: dotenv.env['FIREBASE_APP_ID_WEB']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID_WEB']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID_WEB']!,
        authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN_WEB'],
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_WEB'],
      );
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return FirebaseOptions(
            apiKey: dotenv.env['FIREBASE_API_KEY_ANDROID']!,
            appId: dotenv.env['FIREBASE_APP_ID_ANDROID']!,
            messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID_ANDROID']!,
            projectId: dotenv.env['FIREBASE_PROJECT_ID_ANDROID']!,
            authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN_ANDROID'],
            storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_ANDROID'],
          );
        case TargetPlatform.iOS:
          return FirebaseOptions(
            apiKey: dotenv.env['FIREBASE_API_KEY_IOS']!,
            appId: dotenv.env['FIREBASE_APP_ID_IOS']!,
            messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID_IOS']!,
            projectId: dotenv.env['FIREBASE_PROJECT_ID_IOS']!,
            authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN_IOS'],
            storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_IOS'],
          );
        case TargetPlatform.macOS:
          return FirebaseOptions(
            apiKey: dotenv.env['FIREBASE_API_KEY_MACOS']!,
            appId: dotenv.env['FIREBASE_APP_ID_MACOS']!,
            messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID_MACOS']!,
            projectId: dotenv.env['FIREBASE_PROJECT_ID_MACOS']!,
            authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN_MACOS'],
            storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_MACOS'],
          );
        case TargetPlatform.windows:
          return FirebaseOptions(
            apiKey: dotenv.env['FIREBASE_API_KEY_WINDOWS']!,
            appId: dotenv.env['FIREBASE_APP_ID_WINDOWS']!,
            messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID_WINDOWS']!,
            projectId: dotenv.env['FIREBASE_PROJECT_ID_WINDOWS']!,
            authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN_WINDOWS'],
            storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_WINDOWS'],
          );
        default:
          throw UnsupportedError("Platform not supported");
      }
    }
  }
}
