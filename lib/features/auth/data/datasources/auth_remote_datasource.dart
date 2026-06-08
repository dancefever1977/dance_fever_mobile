import 'package:dance_fever/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithApple();
  Future<void> signOut();
}

class FirebaseAuthentication implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<UserModel> signInWithGoogle() async {
    // Initialize Google Sign-In
    final googleSignIn = GoogleSignIn.instance;

    // Authenticate the user with Google
    final googleUser = await googleSignIn.authenticate();

    // Authorize and get the access token
    final List<String> scopes = <String>['email', 'profile'];
    final clientAuth = await googleUser.authorizationClient.authorizeScopes(scopes);

    // Create a credential for Firebase Authentication
    final credential = GoogleAuthProvider.credential(
      idToken: googleUser.authentication.idToken,
      accessToken: clientAuth.accessToken,
    );

    // Sign in to Firebase with the credential
    final userCredential = await firebaseAuth.signInWithCredential(credential);

    return UserModel(
      uid: userCredential.user!.uid,
      name: userCredential.user!.displayName!,
      email: userCredential.user!.email!,
    );
  }

  @override
  Future<UserModel> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
