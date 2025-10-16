import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyBD6etIVrKRwbT3r-LQxPkf7G64sGZiqII",
      authDomain: "ecomitra-app-9df6a.firebaseapp.com",
      projectId: "ecomitra-app-9df6a",
      storageBucket: "ecomitra-app-9df6a.firebasestorage.app",
      messagingSenderId: "1095648665251",
      appId: "1:1095648665251:web:8436617df832a62a302916",  // Usually: projectId.appspot.com
    );
  }
}
