import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hrm_application/routers/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  RxBool isLogin = true.obs;
  RxBool isEditingEmail = false.obs;
  RxBool isEditingPassword = false.obs;
  RxBool isLoggingIn = false.obs;
  RxBool isRegistering = false.obs;
  RxnString loginStatus = RxnString(null);
  RxBool isProcessing = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '220250884125-i9jmjkaid089ul486erdhhure62dmunk.apps.googleusercontent.com',
  );

  Rxn<User?> user = Rxn<User?>(null);
  RxBool isLoading = false.obs;
  RxString errorMessage = RxString('');

  // Thông tin người dùng
  RxString uid = ''.obs;
  RxString name = ''.obs;
  RxString userEmail = ''.obs;
  RxString imgUrl = ''.obs;

  void toggleForm() {
    isLogin.toggle();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  String? validateEmail(String? value) {
    value = value!.trim();
    if (emailController.text.isNotEmpty) {
      if (value.isEmpty)
        return "Email can't be empty";
      else if (!value.contains(
          RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")))
        return "Enter a correct email address";
    }
    return null;
  }

  String? validatePassword(String? value) {
    value = value!.trim();
    if (passwordController.text.isNotEmpty) {
      if (value.isEmpty) {
        return "Password can't be empty";
      } else if (value.length < 6) {
        return "Password must be at least 6 characters";
      }
    }
    return null;
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        final UserCredential userCredential =
            await _auth.signInWithPopup(googleProvider);
        user.value = userCredential.user;
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          final UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          user.value = userCredential.user;
        }
      }

      if (user.value != null) {
        _updateUserInfo(user.value!);
        await _saveUserPreferences();
        Get.toNamed(AppRoutes.home);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithEmail() async {
    isLoading.value = true;
    errorMessage.value = '';
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      user.value = userCredential.user;

      if (user.value != null) {
        _updateUserInfo(user.value!);
        await _saveUserPreferences();
        emailController.clear();
        passwordController.clear();
        Get.toNamed(AppRoutes.home);
      }
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _handleAuthError(e);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> registerWithEmail() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      user.value = userCredential.user;

      if (user.value != null) {
        _updateUserInfo(user.value!);
        await _saveUserPreferences();
        Get.toNamed(AppRoutes.auth);
      }
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _handleAuthError(e);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth');

      user.value = null;
      uid.value = '';
      name.value = '';
      userEmail.value = '';
      imgUrl.value = '';
      Get.toNamed(AppRoutes.auth);
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> _saveUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('auth', true);
  }

  void _updateUserInfo(User user) {
    uid.value = user.uid;
    name.value = user.displayName ?? '';
    userEmail.value = user.email ?? '';
    imgUrl.value = user.photoURL ?? '';
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'email-already-in-use':
        return 'Email is already in use.';
      default:
        return 'Authentication error occurred.';
    }
  }

  @override
  void onInit() {
    user.value = _auth.currentUser;
    if (user.value != null) {
      _updateUserInfo(user.value!);
    }
    super.onInit();
  }
}
