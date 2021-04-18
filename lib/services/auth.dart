import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;
  Stream<User> authStateChanges();
  Future<User> signInAnonymously();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<User> createUserWithEmail(String email, String password);
  Future<User> signInWithEmail(String email, String password);
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<User> signInWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password));
    return userCredential.user;
  }

  @override
  Future<User> createUserWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
            code: "ERROR_MISSING_GOOGLE_ID_TOKEN",
            message: "Missing google id token");
      }
    } else {
      throw FirebaseAuthException(
          code: "ERROR_ABORTED_BY_USER", message: "Sign in aborted by user");
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    // final fb = FacebookLogin();
    // final response = await fb.logIn(permissions: [
    //   FacebookPermission.publicProfile,
    //   FacebookPermission.email,
    // ]);
    final LoginResult result = await FacebookAuth.instance
        .login(); // by the fault we request the email and the public profile

    switch (result.status) {
      case LoginStatus.success:
        final AccessToken accessToken = result.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
            FacebookAuthProvider.credential(accessToken.token));
        return userCredential.user;
        break;
      case LoginStatus.cancelled:
        throw FirebaseAuthException(
            code: "ERROR_ABORTED_BY_USER", message: "Sign in aborted by user");
        break;
      case LoginStatus.failed:
        throw FirebaseAuthException(
          code: "ERROR_FACEBOOK_LOGIN_FAILED",
          message: "cANT LOGIN",
        );
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async {
    // un-comment the following code only in release.
    // final googleSignIn = GoogleSignIn();
    // await googleSignIn.signOut();
    // final fbSignIn = FacebookAuth.instance;
    // await fbSignIn.logOut();
    await _firebaseAuth.signOut();
  }
}
