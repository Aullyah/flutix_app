part of 'extensions.dart';

extension FirebaseUserExtension on FirebaseUser {
  Users convertToUsers(
          {String name = "No Name",
          List<String> selectedGenres = const [],
          String selectedLanguage = "English",
          int balance = 50000}) =>
      Users(this.uid, this.email,
          name: name,
          selectedGenres: selectedGenres,
          balance: balance,
          selectedLanguage: selectedLanguage);

  Future<Users> fromFireStrore() async => await UserServices.getUser(this.uid);
}
