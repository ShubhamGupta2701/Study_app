import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_app/controllers/AppLogger.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/screens/home/home_screen.dart';
import 'package:study_app/screens/login/login_screen.dart';
import 'package:study_app/widgets/dialogs/dialogue_widget.dart';

class AuthController extends GetxController {
  final GoogleSignIn googleUser = GoogleSignIn(scopes: <String>["email"]);
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();

  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduciton();
  }

  Future<void> signInWithGoogle() async {
    await googleUser.signIn();
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
            idToken: _authAccount.idToken,
            accessToken: _authAccount.accessToken);

        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        navigateToHomePage();
      }
    } on Exception catch (error) {
      AppLogger.e(error);
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveUser(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl
    });
  }

  Future<void> signOut() async {
    await googleUser.signOut();
    await FirebaseAuth.instance.signOut();
    AppLogger.d('Sign Out');
    try {
      await _auth.signOut();
      navigateToHomePage();
    } on FirebaseAuthException catch (e) {
      AppLogger.e(e);
    }
  }

  void navigateToIntroduciton() {
    Get.offAllNamed("/introduction");
  }

  void navigateToHomePage() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void showLoginAlertDialogue() {
    Get.dialog(Dialogs.questionStartDialogue(onTap: () {
      Get.back();
      NavigateToLoginPage();
    }), barrierDismissible: false);
  }

  void NavigateToLoginPage() {
    Get.toNamed(LoginScreen.routeName);
    // if (isLoggedIn() == true) {
    //   navigateToHomePage();
    // }
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}
