import 'package:cloud_firestore/cloud_firestore.dart';

class BlockUnblockUser {
  void setUser(
      Map map, String userId, bool isBlockingUser, String friendUserId) async {
    final batch = FirebaseFirestore.instance.batch();
    var doc =
        FirebaseFirestore.instance.collection('BlockedUserList').doc(userId);
    batch.set(doc, {'users': map});
    var AmIBlockedRef =
        FirebaseFirestore.instance.collection('AmIBlocked').doc(friendUserId);
    DocumentSnapshot documentSnapshot = await AmIBlockedRef.get();

    if (isBlockingUser && documentSnapshot.exists) {
      print('user blocked');
      batch.update(AmIBlockedRef, {
        "blocked": FieldValue.arrayUnion([userId]),
      });
    } else if (!isBlockingUser && documentSnapshot.exists) {
      print('user removed');
      batch.update(AmIBlockedRef, {
        "blocked": FieldValue.arrayRemove([userId]),
      });
    } else {
      print('else called');
      batch.set(AmIBlockedRef, {
        "blocked": [userId],
      });
    }

    batch.set(doc, {'users': map});
    batch.commit();
  }
}
