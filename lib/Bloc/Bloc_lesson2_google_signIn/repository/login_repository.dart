// (Business Logic Layer)
// ✔ Why this is needed?
// All API/business logic stays here
// BLoC should not know how login works
// Only the repository knows the details
// Easy to replace Google login later (Facebook/Apple Sign-In)

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class GoogleSignInRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel> signInWithGoogle() async {
    try {
      // Trigger the Google sign-in flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google sign-in was cancelled by the user.');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user == null) {
        throw Exception('Firebase sign-in failed: user is null.');
      }

      return UserModel.fromGoogleSignIn(
        name: user.displayName ?? 'No Name',
        email: user.email ?? 'No Email',
        photoUrl: user.photoURL ?? '',
      );
    } catch (e) {
      throw Exception('Google Sign-In failed: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _googleSignIn.signOut(),
        _firebaseAuth.signOut(),
      ]);
    } catch (e) {
      throw Exception('Sign-out failed: ${e.toString()}');
    }
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}