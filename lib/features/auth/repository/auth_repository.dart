import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:track_money_app/core/constants/firebase_constants.dart';
import 'package:track_money_app/core/failure.dart';
import 'package:track_money_app/core/providers/firebase_providers.dart';

import '../models/user.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    firebaseFirestore: ref.read(firestoreProvider),
    auth: ref.read(firebaseAuthProvider),
    googleSignIn: ref.read(googleSignInProvider)));

class AuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  CollectionReference get _users =>
      _firebaseFirestore.collection(FirebaseConstants.usersCollection);

  AuthRepository(
      {required FirebaseFirestore firebaseFirestore,
      required FirebaseAuth auth,
      required GoogleSignIn googleSignIn})
      : _auth = auth,
        _googleSignIn = googleSignIn,
        _firebaseFirestore = firebaseFirestore;

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<Either<Failure, AppUser>> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(credentials);
      print("user123: $userCredential");

      final userFromFirebase = userCredential.user;

      AppUser user;

      if (userCredential.additionalUserInfo!.isNewUser) {
        user = AppUser(
            uid: userCredential.user!.uid,
            name: userFromFirebase?.displayName ?? "",
            email: userFromFirebase?.email ?? "");

        _users.doc(userCredential.user!.uid).set(user.toMap());
        return right(user);
      } else {
        user = await getUserData(userCredential.user!.uid).first;
        print("usre: ${user.uid}");
        print("usre: ${user.name}");
        print("usre: ${user.email}");
        return right(user);
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<AppUser> getUserData(String uid) {
    return _users
        .doc(uid)
        .snapshots()
        .map((event) => AppUser.fromMap(event.data() as Map<String, dynamic>));
  }
}
