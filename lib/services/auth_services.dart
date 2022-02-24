part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Users users = result.user.convertToUsers(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);
      await UserServices.updateUser(users);
      return SignInSignUpResult(user: users);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(",")[1].trim());
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Users users = await result.user.fromFireStrore();
      return SignInSignUpResult(user: users);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(",")[1].trim());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;
}
