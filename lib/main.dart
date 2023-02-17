import 'package:ecommerce_store/screens/landing_Screen.dart';
import 'package:ecommerce_store/screens/layout_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyD47TJYCL0kk7wLLLiSvOSS-RUkCLzZJpI",
      authDomain: "e-commerce-store-b4577.firebaseapp.com",
      projectId: "e-commerce-store-b4577",
      storageBucket: "e-commerce-store-b4577.appspot.com",
      messagingSenderId: "148982644307",
      appId: "1:148982644307:web:c1a53ab81c1407752d90a6",
    ));
  } else {
    await Firebase.initializeApp();
  }

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        title: 'Ecommerce Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue, backgroundColor: Colors.white),
        home: const LayOutScreen(),
      ),
    );
  }
}
