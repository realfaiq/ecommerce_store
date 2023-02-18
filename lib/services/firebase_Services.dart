import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  //Admin Sign-in
  static Future<DocumentSnapshot> adminSignIn(String id) async {
    var result = FirebaseFirestore.instance.collection('admins').doc(id).get();
    return result;
  }

  static Future<String?> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "Email Already in Use";
      } else if (e.code == 'weak-password') {
        return "Password is too weak";
      }
    } catch (e) {
      return e.toString();
    }
  }

  //Login
  static Future<String?> signInAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // SignOut
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
