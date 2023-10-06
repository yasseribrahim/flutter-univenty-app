import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> handleSignInEmail(String email, String password) async {
    UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;
    return user;
  }

  Future<User> handleSignUp(email, password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;
    await result.user!.sendEmailVerification();
    return user;
  }

  Future<void> handleResetPassword(email) async {
    return await auth.sendPasswordResetEmail(email: email);
  }

  Future<bool> handleSignout() async {
    await auth.signOut();
    return true;
  }

  User? getCurrentUser() {
    return auth.currentUser;
  }

  User? isUserLoggedIn() {
    return auth.currentUser;
  }
}