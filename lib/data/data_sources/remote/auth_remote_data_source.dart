import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSource(this.firebaseAuth, this.googleSignIn);

  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signup({
    required String email,
    required String password,
    required String name,
    String? avatarId,
  }) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user!.updateDisplayName(name);
    if (avatarId != null) {
      await userCredential.user!.updatePhotoURL(avatarId);
    }
    await userCredential.user!.sendEmailVerification();
    return userCredential;
  }

  Future<void> forgetPassword({required String email}) {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw Exception('Google Sign In aborted');

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await firebaseAuth.signInWithCredential(credential);
  }

  Future<void> logout() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
  }
}
