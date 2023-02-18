import 'package:ecommerce_store/screens/home_Screen.dart';
import 'package:ecommerce_store/screens/login_Screen.dart';
import 'package:ecommerce_store/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  Future<FirebaseApp> initialize = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialize,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.active) {
                    User? user = snapshot.data;
                    if (user == null) {
                      return const LogInScreen();
                    } else {
                      return HomeScreen();
                    }
                  }
                  return Scaffold(
                    body: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Checking Authentication',
                              textAlign: TextAlign.center,
                              style: EcommerceStore.boldStyle,
                            ),
                            CircularProgressIndicator(),
                          ]),
                    ),
                  );
                });
          }
          return Scaffold(
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'INITIALIZER',
                      style: EcommerceStore.boldStyle,
                    ),
                    CircularProgressIndicator(),
                  ]),
            ),
          );
        });
  }
}
