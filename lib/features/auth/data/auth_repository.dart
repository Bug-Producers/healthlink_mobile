import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/**
 * Repository for managing user authentication via Firebase and Google Sign-In.
 */
class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /**
   * Listens to authentication state changes.
   */
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  /**
   * Logs in a user with email and password.
   */
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /**
   * Registers a new user and sends an email verification.
   */
  Future<UserCredential> register({
    required String email,
    required String password,
    required String username,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user!.updateDisplayName(username);
    await userCredential.user!.sendEmailVerification();
    await userCredential.user!.reload();
    return userCredential;
  }

  /**
   * Signs in a user using Google authentication.
   */
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  /**
   * Sends a password reset email to the specified address.
   */
  Future<void> forgetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  /**
   * Reloads the current user's data from Firebase.
   */
  Future<void> reloadUser() async {
    await _auth.currentUser?.reload();
  }

  /**
   * Resends the verification email to the current user.
   */
  Future<void> resendVerificationEmail() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  /**
   * Signs out the current user from Firebase and Google.
   */
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  /**
   * Returns the currently signed-in user.
   */
  User? get currentUser => _auth.currentUser;
}