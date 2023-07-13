//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

//class AuthService {
// final FirebaseAuth _auth = FirebaseAuth.instance;

// create user obj based on firebase user

//MyUser _userFromFirebaseUser(FirebaseUser user) {
//  return user != null ? MyUser(uid: user.uid) : null;
//}

// auth change user stream
// Stream<MyUser> get user {
//return _auth.onAuthStateChanged
//.map((FirebaseUser user) => _userFromFirebaseUser(user));
//.map(_userFromFirebaseUser);
// }

// sign in anon
// Future signInAnon() async {
//   try {
//     UserCredential result = await _auth.signInAnonymously();
//     User user = result.user;
//     return _fromFirebaseUser(user);
//   } catch (e) {
//     print(e.toString());
//     return null;
//   }
// }

// sign in with email and password
// Future signInWithEmailAndPassword(String email, String password) async {
//   try {
//     AuthCredential result = await _auth.signInWithEmailAndPassword(
//         email: email, password: password);
//     FirebaseUser user = result.user;
//     return _userFromFirebaseUser(user);
//   } catch (error) {
//     print(error.toString());
//     return null;
//   }
// }

Future signInWithEmailAndPassword(String email, String password) async {
  try {
    // AuthResult result = await _auth.signInWithEmailAndPassword(
    //  email: email, password: password);
    // FirebaseUser user = result.user;
    // return _userFromFirebaseUser(user);
  } catch (e) {
    print(e.toString());
    return null;
  }
}

// register with email and password
// Future registerWithEmailAndPassword(
//     String name, String email, String password) async {
//   try {
//     UserCredential result = await _auth.createUserWithEmailAndPassword(
//         email: email, password: password);
//     User user = result.user;

//     user.updateProfile(displayName: name);
//     await DatabaseService(uid: user.uid)
//         .setUserD
//     return _userFromFirebaseUser(user);
//   } catch (signUpError) {
//     if (signUpError is PlatformException) {
//       if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
//         showToast("this email already exist");

//         /// `foo@bar.com` has alread been registered.
//       }
//     }
//     print(signUpError.toString());
//     return null;
//   }
// }
Future registerWithEmailAndPassword(
    String name, String email, String password, String phone) async {
  try {
    // AuthResult result = await _auth.createUserWithEmailAndPassword(
    //   email: email, password: password);

    ///This will create the dummy initial data for each user in firestore which we can Update Later on
    //FirebaseUser user = result.user;
    //await DatabaseService(uid: user.uid).setUserData(name, phone);

    // return _userFromFirebaseUser(user);
  } catch (e) {
    print(e.toString());
    return true;
  }
}

// sign out
Future signOut() async {
  try {
    // return await _auth.signOut();
  } catch (error) {
    print(error.toString());
    return null;
    //  }
  }
}

void showToast(String msg, [isBottom = false]) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: !isBottom ? ToastGravity.TOP : ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}
