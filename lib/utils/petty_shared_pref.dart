import 'package:shared_preferences/shared_preferences.dart';

class PettySharedPref {
  static final String accessTokenPrefKey = 'access_token';
  static final String userIDPrefKey = 'user_id';
  static final String isLoggedInPrefKey = 'is_logged_in';
  static final String isInitialSignInOrSignUpPrefKey = 'is_initial_in';
  static final String profilePrefKey = 'profile';
  static final String selectedLatPrefKey = 'lat';
  static final String selectedLonPrefKey = 'lon';
  static final String selectedLocationPrefKey = 'location';
  static final String authCompletedTillPrefKey = 'auth_completed';
  static final String userMobileNumberPrefKey = 'user_mobile_number';
  static final String userCountryCodePrefKey = 'user_country_code';
  static final String timeStampMap = 'timestamp_map';
  static final String selectedSubcategoryListPrefKey =
      'selected_subcategory_list';
  static final String chatBGPrefKey = 'chat_bg';
  static final String isPaidOnStart = 'paid';

  static void setIsPaidOnStart(
      SharedPreferences sharedPreferences, int result) {
    sharedPreferences.setInt(isPaidOnStart, result);
  }

  static int getIsPaidOnStart(SharedPreferences prefs) {
    return prefs.getInt(isPaidOnStart);
  }

  static void setChatBG(SharedPreferences sharedPreferences, String image) {
    sharedPreferences.setString(chatBGPrefKey, image);
  }

  static String getChatBG(SharedPreferences prefs) {
    return prefs.getString(chatBGPrefKey);
  }

  static void setTimeStampMapChat(
      SharedPreferences sharedPreferences, String timeStampMapInString) {
    sharedPreferences.setString(timeStampMap, timeStampMapInString);
  }

  static String getTimeStampMapChat(SharedPreferences prefs) {
    return prefs.getString(timeStampMap);
  }

  static void setUserMobileNumber(
      SharedPreferences sharedPreferences, String mobile) {
    sharedPreferences.setString(userMobileNumberPrefKey, mobile);
  }

  static String getUserMobileNumber(SharedPreferences prefs) {
    return prefs.getString(userMobileNumberPrefKey);
  }

  static void setUserCountryCode(
      SharedPreferences sharedPreferences, String code) {
    sharedPreferences.setString(userCountryCodePrefKey, code);
  }

  static String getUserCountryCode(SharedPreferences prefs) {
    return prefs.getString(userCountryCodePrefKey);
  }

  static void setSelectedSubcategoryList(
      SharedPreferences sharedPreferences, List<String> subcategoryList) {
    sharedPreferences.setStringList(
        selectedSubcategoryListPrefKey, subcategoryList);
  }

  static List<String> getSelectedSubcategoryList(SharedPreferences prefs) {
    return prefs.getStringList(selectedSubcategoryListPrefKey);
  }

  static void setAccessToken(
      SharedPreferences sharedPreferences, String accessToken) {
    sharedPreferences.setString(accessTokenPrefKey, accessToken);
  }

  static String getAccessToken(SharedPreferences prefs) {
    return prefs.getString(accessTokenPrefKey);
  }

  static void setUserId(SharedPreferences sharedPreferences, String userId) {
    sharedPreferences.setString(userIDPrefKey, userId);
  }

  static String getUserId(SharedPreferences prefs) {
    return prefs.getString(userIDPrefKey);
  }

  static void setIsLoggedIn(
      SharedPreferences sharedPreferences, bool isLoggedIn) {
    sharedPreferences.setBool(isLoggedInPrefKey, isLoggedIn);
  }

  static bool getIsLoggedIn(SharedPreferences prefs) {
    return prefs.getBool(isLoggedInPrefKey);
  }

  static void setInitialSignInOrSignUp(
      SharedPreferences sharedPreferences, bool isInitialIn) {
    sharedPreferences.setBool(isInitialSignInOrSignUpPrefKey, isInitialIn);
  }

  static bool getInitialSignInOrSignUp(SharedPreferences prefs) {
    return prefs.getBool(isInitialSignInOrSignUpPrefKey);
  }

  static void setProfileData(
      SharedPreferences sharedPreferences, String profileJSON) {
    sharedPreferences.setString(profilePrefKey, profileJSON);
  }

  static String getProfileData(SharedPreferences prefs) {
    return prefs.getString(profilePrefKey);
  }

  static void setLat(SharedPreferences sharedPreferences, double lat) {
    sharedPreferences.setDouble(selectedLatPrefKey, lat);
  }

  static double getLat(SharedPreferences prefs) {
    return prefs.getDouble(selectedLatPrefKey);
  }

  static void setLon(SharedPreferences sharedPreferences, double lon) {
    sharedPreferences.setDouble(selectedLonPrefKey, lon);
  }

  static double getLon(SharedPreferences prefs) {
    return prefs.getDouble(selectedLonPrefKey);
  }

  static void setLocation(
      SharedPreferences sharedPreferences, String location) {
    sharedPreferences.setString(selectedLocationPrefKey, location);
  }

  static String getLocation(SharedPreferences prefs) {
    return prefs.getString(selectedLocationPrefKey);
  }
}
