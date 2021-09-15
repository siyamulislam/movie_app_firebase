import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? getCurrentUser() => _auth.currentUser;
  static Future<String> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credential.user!.uid;
  }

  static Future<String> registration(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credential.user!.uid;
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static bool isVerified()  {
   return _auth.currentUser!.emailVerified;
  }
  static Future <void> sendVerificationMail()  {
   return _auth.currentUser!.sendEmailVerification();
  }
}
