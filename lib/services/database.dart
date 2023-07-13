//import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:detox/models/recipe.dart';
// import 'package:detox/models/user.dart';
// import 'package:detox/youtube_videoes/models/video_model.dart';
import 'package:flutter/foundation.dart';

// import 'package:spotadate/models/user.dart';

class DatabaseService extends ChangeNotifier {
  final String uid;

  DatabaseService({
    this.uid,
  });
  //final CollectionReference userData =
  //  Firestore.instance.collection("userData");

  Future setUserData(String name, String phone) async {
    // await userData.document(uid).setData({
    //'name': name,
    //'phone': phone,
    //'age': '00',
    //'imgUrl': null,
    //'gender': 'Male',
    //'address': null,
    //'role': null,
    //'firstLogin': true,
    //"bioData": null,
    // });
    // await watchedVideosData.document(uid).setData({
    //   'watchedVideosId': ['abc'],
    // });
  }

  Future deMarkFirstLogIn(bool firstLogin) async {
    //await userData.document(uid).updateData({'firstLogin': !firstLogin});
  }

  Future changeProfilePic({String imgUrl}) async {
    // await userData.document(uid).updateData({
    //'imgUrl': imgUrl,
    //});
  }

  Future modifyUserData(
      {String name,
      String username,
      String about,
      String occupation,
      List<String> interests,
      String sexualpreference,
      String gender
      // var latLong
      }) async {
    //try {
    // await userData.document(uid).updateData({
    //  'name': name,
    // 'gender': gender,
    // 'sexualPreference': sexualpreference,
    // 'username': username,
    //'about': about,
    //'occupation': occupation,
    //'interests': interests
    // 'latlong': latLong,
    // 'imgUrl': imgUrl,
    //});
    //return null;
    // } catch (e) {
    // return e;
  }
}
// Future addToWatch({Video video}) async {
//   try {
//     var x = await watchedVideosData.document(uid).get();
//     print(x);
//     if (x == null || x.data == null) {
//       print("No Videos existed creating a list");
//       await watchedVideosData.document(uid).setData({
//         'watchedVideosId': [video.id],
//       });
//       print("List Created and first video Added");
//     } else {
//       print("List Alredy exists");
//       // List y = [];j
//       var y = new List();
//       print(x.data);
//       for (var ii = 0; ii < x.data['watchedVideosId'].length; ii++) {
//         if (y.contains(x.data['watchedVideosId'][ii])) {
//           continue;
//         }
//         y.add(x.data['watchedVideosId'][ii]);
//       }
//       print("y= $y");
//       if (y.contains(video.id)) {
//         print("No change done Video already Watched");
//       } else {
//         y.add(video.id);
//       }

//       await watchedVideosData.document(uid).setData({'watchedVideosId': y});
//       print("New Data inserted");
//       return "Success";
//     }
//   } catch (e) {
//     return e.toString();
//   }
// }

// Future<List> getWatchedVideos() async {
//   var x = await watchedVideosData.document(uid).get();
//   var y = new List();
//   for (var ii = 0; ii < x.data['watchedVideosId'].length; ii++) {
//     if (y.contains(x.data['watchedVideosId'][ii])) {
//       continue;
//     }
//     y.add(x.data['watchedVideosId'][ii]);
//   }
//   return y;
// }
Stream<List<String>> getWatchedVideos() {}

Future updateUserData(
    {String name,
    String dob,
    String weight,
    String height,
    String occupation,
    String children,
    String maritalStatus}) async {
  //await userData.document(uid).updateData({
  //'name': name,
  // 'dob': dob,
  //'weight': weight,
  //'height': height,
  //'occupation': occupation,
  // 'children': children,
  // 'maritalStatus': maritalStatus
  //});
}

  // Future deMarkFirstLogIn(bool firstLogin) async {
  //   await userData.document(uid).updateData({'firstLogin': firstLogin});
  // }

// user data from snapshots
  //UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    //return UserData(
        //uid: uid,
        //name: snapshot.data['name'],
        //imgUrl: snapshot.data['imgUrl'],
        //firstLogIn: snapshot.data['firstLogin'],
        //role: snapshot.data['role'],
        //phone: snapshot.data['phone'],
        ///address: snapshot.data['address'],
       // gender: snapshot.data['gender'],
        //height: snapshot.data['height'],
        //city: snapshot.data['city'],
        //country: snapshot.data['country'],
        //occupation: snapshot.data['occupation'],
        //bioData: snapshot.data['bioData']);
  //}

  //Get Stream to FireStore Data
 // Stream<UserData> get uData {
    //return userData.document(uid).snapshots().map(_userDataFromSnapshot);
  //}

 // final CollectionReference watchedVideos =
    //  Firestore.instance.collection("videosData");

  //List<String> _watchedVideosFromSnapShot(DocumentSnapshot snapshot) {
   // List<String> video = [];
   // if (snapshot.exists) {
     // if (snapshot.data.containsKey('watchedVideosId') &&
        //  snapshot.data['watchedVideosId'].length > 0) {
        //print('Fetching and Adding Watched Videos Data');
        //for (int ii = 0; ii < snapshot.data['watchedVideosId'].length; ii++) {
          //video.add(snapshot.data['watchedVideosId'][ii].toString());
        //}
      //}
   // }

   // return
        //snapshot.data['watchedVideosId'].;
        //video;
  //}

  // Stream<List<String>> get watchedVideosList {
  //   return watchedVideos
  //       .document(uid)
  //       .snapshots()
  //       .map(_watchedVideosFromSnapShot);
  // }

  // final CollectionReference questionnaireData =
  // Firestore.instance.collection("questionnaireData");

  //final CollectionReference usersData =
      //Firestore.instance.collection("userData");
  // final CollectionReference recipeDataH =
  // Firestore.instance.collection("recipeListHeb");

 // List<DatesData> _usersDataFromSnapShot(QuerySnapshot snapshot) {
    //return snapshot.documents.map((doc) {
     //print('Adding Data');
      // List<String> interests = [];
      // if (doc.data['interests'] != null || doc.data['interests'] != 'null') {
      //   for (int ii = 0; ii < doc.data['interests'].length; ii++) {
      //     interests.add(doc.data['interests'][ii].toString());
      //   }
      // }

      //print('data added');
     // return DatesData(
         // name: doc.data['name'] ?? 'No name info available',
          //about: doc.data['about'] ?? "no about info available",
          // interests: interests ?? "no interests data available",
          //age: doc.data['age'] ?? "no age info available",
          //imgUrl: doc.data['imgUrl'] ?? "no image url found",
          //sexualPreference:
             // doc.data['sexualPreference'] ?? "no sexPrefs data specified");
   // }).toList();
 // }

// Stream
  //Stream<List<DatesData>> get datesData {
    //return usersData.snapshots().map(_usersDataFromSnapShot);
  //}
//   List<RecipeH> _recipeListFromSnapShotH(QuerySnapshot snapshot) {
//     return
//         //  recipesHebrew =
//         snapshot.documents.map((doc) {
//       List<String> stages = [];
//       List<String> ingredients = [];
//       List<String> steps = [];
//       List<String> categories = [];
//       print('addingData');
//       for (int ii = 0; ii < doc.data['stages'].length; ii++) {
//         stages.add(doc.data['stages'][ii].toString());
//       }
//       for (int ii = 0; ii < doc.data['ingredients'].length; ii++) {
//         ingredients.add(doc.data['ingredients'][ii].toString());
//       }
//       for (int ii = 0; ii < doc.data['steps'].length; ii++) {
//         steps.add(doc.data['steps'][ii].toString());
//       }
//       for (int ii = 0; ii < doc.data['categories'].length; ii++) {
//         categories.add(doc.data['categories'][ii].toString());
//       }

//       print('data added');
//       return RecipeH(
//           stages: stages ?? 'No stages info available',
//           title: doc.data['title'] ?? "no title available",
//           categories: categories ?? "no categories available",
//           ingredients: ingredients ?? "no ingredients info available",
//           imgUrl: doc.data['imgUrl'] ?? "no image url found",
//           steps: steps ?? "no composition data found");
//     }).toList();
//   }

//   Stream<List<RecipeH>> get reDataH {
//     return recipeDataH.snapshots().map(_recipeListFromSnapShotH);
//   }

// Future setQuestionnaireData({}) async {
//     await userData.document(uid).setData({
//       'name': name,
//       'dob': dob,
//       '': address,
//       'role': null,
//       'firstLogin': firstLogin
//     });
  // }
  // final CollectionReference recipeDataH =
  //     Firestore.instance.collection("recipeListHeb");

  // Future updateRecipeData(
  //     {String rid,
  //     String title,
  //     String categories,
  //     String url,
  //     String steps,
  //     String ingredients}) async {
  //   await recipeData.document(rid).setData({
  //     'title': title,
  //     'categories': categories,
  //     // 'variant': variant,
  //     'url': url,
  //     'ingredients': ingredients,
  //     'steps': steps,
  //   });
  // }

  // List<Recipe> _recipeListFromSnapShot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     List<String> stages = [];
  //     List<String> ingredients = [];
  //     List<String> steps = [];
  //     List<String> categories = [];
  //     // dynamic stages = doc.data['stages'];
  //     // dynamic ingredients = doc.data['ingredients'];
  //     // dynamic steps = doc.data['steps'];
  //     // dynamic categories = doc.data['categories'];
  //     print('addingData');
  //     for (int ii = 0; ii < doc.data['stages'].length; ii++) {
  //       stages.add(doc.data['stages'][ii].toString());
  //     }
  //     for (int ii = 0; ii < doc.data['ingredients'].length; ii++) {
  //       ingredients.add(doc.data['ingredients'][ii].toString());
  //     }
  //     for (int ii = 0; ii < doc.data['steps'].length; ii++) {
  //       steps.add(doc.data['steps'][ii].toString());
  //     }
  //     for (int ii = 0; ii < doc.data['categories'].length; ii++) {
  //       categories.add(doc.data['categories'][ii].toString());
  //     }

  //     print('data added');
  //     // print("$stages, $steps, $categories, $ingredients");
  //     return Recipe(
  //         stages: stages ?? 'No stages info available',
  //         title: doc.data['title'] ?? "no title available",
  //         categories: categories ?? "no categories available",
  //         ingredients: ingredients ?? "no ingredients info available",
  //         imgUrl: doc.data['url'] ?? "no image url found",
  //         steps: steps ?? "no composition data found");
  //   }).toList();
  // }

  // Query SnapShots to convert phone records into a map
  // List<Recipe> _recipeListFromSnapShot(QuerySnapshot snapshot) {
  //   // snapshot.documents.
  //   // snapshot.get();
  //   return snapshot.documents.map((doc) {
  //     // Map<String, dynamic> x =doc.data;
  //     // doc.data['stages'][ii];
  //     return Recipe(
  //         stages: doc.data['stages'] ?? 'No stages info available',
  //         title: doc.data['title'] ?? "no title available",
  //         categories: doc.data['categories'] ?? "no categories available",
  //         ingredients:
  //             doc.data['ingredients'] ?? "no ingredients info available",
  //         imgUrl: doc.data['url'] ?? "no image url found",
  //         steps: doc.data['steps'] ?? "no composition data found");
  //   }).toList();
  // }

// Stream
  // Stream<List<Recipe>> get reData {
  //   return recipeData.snapshots().map(_recipeListFromSnapShot);
  // }

  //Updating the phone records in the document

//}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:detox/models/user.dart';

// class DatabaseService {
//   final String uid;

//   DatabaseService({
//     this.uid,
//   });
//   final CollectionReference userData =
//       Firestore.instance.collection("userData");

//   Future setUserData(
//       String name, String phone, String address, bool firstLogin) async {
//     await userData.document(uid).setData({
//       'name': name,
//       'phone': phone,
//       'address': address,
//       'role': null,
//       'firstLogin': firstLogin
//     });
//   }

//   Future updateUserData(
//       {String name,
//       String dob,
//       String weight,
//       String height,
//       String occupation,
//       String children,
//       String maritalStatus}) async {
//     await userData.document(uid).updateData({
//       'name': name,
//       'dob': dob,
//       'weight': weight,
//       'height': height,
//       'occupation': occupation,
//       'children': children,
//       'maritalStatus': maritalStatus
//     });
//   }

//   Future deMarkFirstLogIn(bool firstLogin) async {
//     await userData.document(uid).updateData({
//       // 'name': name,
//       // 'phone': phone,
//       // 'address': address,
//       // 'role': null,
//       'firstLogin': firstLogin
//     });
//   }

// // user data from snapshots
//   UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
//     return UserData(
//         uid: uid,
//         name: snapshot.data['name'],
//         img: snapshot.data['img'],
//         firstLogIn: snapshot.data['firstLogin']);
//   }

//   //Get Stream to FireStore Data
//   Stream<UserData> get uData {
//     return userData.document(uid).snapshots().map(_userDataFromSnapshot);
//   }

//   final CollectionReference questionnaireData =
//       Firestore.instance.collection("questionnaireData");

// // Future setQuestionnaireData({}) async {
// //     await userData.document(uid).setData({
// //       'name': name,
// //       'dob': dob,
// //       '': address,
// //       'role': null,
// //       'firstLogin': firstLogin
// //     });
//   // }
// }
