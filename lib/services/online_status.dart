// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/petty_shared_pref.dart';

class UpdateOnlineOffline {
  void updateIAmOnline() {
    Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (PettySharedPref.getUserId(prefs) != null) {
        //todo uncomment
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection('OnlineStatus')
            .doc(PettySharedPref.getUserId(prefs));

        documentReference.set({'isOnline': true});
      }
    });
  }

  Future<void> updateIAmOffline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (PettySharedPref.getUserId(prefs) != null) {
      //todo uncomment
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('OnlineStatus')
          .doc(PettySharedPref.getUserId(prefs));
      documentReference.set({'isOnline': false});
    }
  }
}
