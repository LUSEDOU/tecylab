import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class HandledException implements Exception {
  HandledException(this.message);
  final String message;

  @override
  String toString() => 'HandledException: $message';
}

class AuthRepository {
  AuthRepository(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  String? get currentDisplayName =>
      _firebaseAuth.currentUser?.email?.split('@').first;

  Future<UserCredential> signInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

  Future<User?> register({
    required String email,
    required String password,
  }) async {
    try {
      return (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw HandledException('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw HandledException('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        throw HandledException('The email address is not valid.');
      }

      print(e.code);
      throw HandledException('Something wrong happened!');
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        HandledException('Something wrong happened!'),
        stackTrace,
      );
    }
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return await register(email: email, password: password);
      } else if (e.code == 'wrong-password') {
        throw HandledException('Wrong password provided for that user.');
      }

      print(e.code);
      throw HandledException('Something wrong happened!');
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        HandledException('Something wrong happened!'),
        stackTrace,
      );
    }
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
