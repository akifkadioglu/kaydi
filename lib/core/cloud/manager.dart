import 'package:cloud_firestore/cloud_firestore.dart';

class CloudManager {
  /* Table names */
  static const USERS = "users";
  static const LISTS = "lists";
  static const TASKS = "tasks";
  /* Table names */

  static DocumentReference<Map<String, dynamic>> getDoc(String collection, String? doc) {
    return FirebaseFirestore.instance.collection(collection).doc(doc);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getSnapshots(String collection) {
    return FirebaseFirestore.instance.collection(collection).snapshots();
  }
}
