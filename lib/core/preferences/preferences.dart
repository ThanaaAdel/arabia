import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../models/login_with_client_id_model.dart';
import '../utils/app_strings.dart';

class Preferences {
  // Singleton pattern to ensure a single instance of Preferences
  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;

  // Get saved language or default to 'ar'
  Future<String> getSavedLang() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(AppStrings.locale) ?? 'ar';
  }

  // Save language preference
  Future<void> saveLang(String locale) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(AppStrings.locale, locale);
  }

  // Save user model
  Future<void> setUser(LoginModel loginModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJson = jsonEncode(loginModel.toJson());
    await preferences.setString('user', userJson);
    print("User data saved: $userJson");
  }

  // Save user session model
  Future<void> setUserWithSession(LoginWithClientIdModel loginWithClientIdModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String sessionJson = jsonEncode(loginWithClientIdModel.toJson());
    print("Saving session JSON: $sessionJson"); // Debugging: Print the JSON being saved
    bool isSaved = await preferences.setString('userWithSession', sessionJson); // Await the saving process
    if (isSaved) {
      print("User session data saved successfully.");
    } else {
      print("Failed to save user session data.");
    }
  }

  // Get user model
  Future<LoginModel> getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('user');
    if (jsonData != null) {
      return LoginModel.fromJson(jsonDecode(jsonData));
    } else {
      return LoginModel(); // Return an empty model if no data found
    }
  }

  // Get user session model
  Future<LoginWithClientIdModel?> getUserModelWithSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('userWithSession');
    print("Retrieved session JSON: $jsonData"); // Debugging: Print the retrieved JSON data

    if (jsonData != null) {
      try {
        return LoginWithClientIdModel.fromJson(jsonDecode(jsonData));
      } catch (e) {
        print("Error parsing JSON: $e"); // Debugging: Print error if JSON parsing fails
        return null;
      }
    } else {
      print("No session data found."); // Debugging: Print when no data is found
      return null;
    }
  }


  // Clear all saved data in SharedPreferences
  Future<void> clearShared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    print("Shared preferences cleared.");
  }


  Future<void> savedLang(String local) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(AppStrings.locale, local);
  }
}
