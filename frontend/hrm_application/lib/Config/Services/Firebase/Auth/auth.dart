import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String? userEmail;
String? imgUrl;
String? uid;
String? name;

Future<User?> signInWithGoogle() async {
  await Firebase.initializeApp();
  User? user;
  if (kIsWeb) {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    try {
      final UserCredential userCredential =
          await auth.signInWithPopup(googleProvider);
      user = userCredential.user;
    } catch (e) {
      print(e);
    }
  } else {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print('The account already exists with a different credential.');
        } else if (e.code == 'invalid-credential') {
          print('Error occurred while accessing credentials. Try again.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  if (user != null) {
    uid = user.uid;
    name = user.displayName;
    userEmail = user.email;
    imgUrl = user.photoURL;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);
  }
  return user;
}

Future<User?> registerWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp();
  User? user;
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  return user;
}

Future<User?> signInWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp();
  User? user;
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
    if (user != null) {
      uid = user.uid;
      userEmail = user.email;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('auth', true);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
  return user;
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  await auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);
  userEmail = null;
  imgUrl = null;
  print('User signed out');
}

Future<String> signOut() async {
  await auth.signOut();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);
  uid = null;
  userEmail = null;
  return 'User signed out';
}

Future getUser() async {
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool authSignedIn = prefs.getBool('auth') ?? false;
  final User? user = auth.currentUser;
  if (authSignedIn) {
    if (user != null) {
      uid = user.uid;
      userEmail = user.email;
      name = user.displayName;
      imgUrl = user.photoURL;
    }
  }
}
