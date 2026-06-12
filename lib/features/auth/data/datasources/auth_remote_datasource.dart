import 'package:dance_fever/core/error/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  const AuthRemoteDataSource({required this.firebaseAuth, required this.googleSignIn});

  Future<Result> loginWithGoogle() async {
    try {
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
      return Success<User?>(userCredential.user);
    } on FirebaseAuthException catch (_) {
      return const Failure<UnauthorizedError>(UnauthorizedError());
    } catch (e) {
      return Failure<NotFoundError>(NotFoundError(e.toString()));
    }
  }

  Future<Result> logout() async {
    try {
      await firebaseAuth.signOut();
      return const Success<void>(null);
    } on FirebaseAuthException catch (_) {
      return const Failure(UnauthorizedError());
    } catch (e) {
      return Failure<NotFoundError>(NotFoundError(e.toString()));
    }
  }
}

final firebaseAuthProvider = Provider(
  (ref) => FirebaseAuth.instance,
);

final googleSignInProvider = Provider(
  (ref) => GoogleSignIn.instance,
);

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    googleSignIn: ref.watch(googleSignInProvider),
  ),
);
