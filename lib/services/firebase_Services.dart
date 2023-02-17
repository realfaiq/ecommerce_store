import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseServices {
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
