import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kaydi_mobile/UI/Account/view_controller.dart';
import 'package:kaydi_mobile/core/cloud/manager.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';

void isAllowRequest(String id) async {
  AccountViewController c = Get.put(AccountViewController());
  c.setLoading;
  var user = await CloudManager.getDoc(CloudManager.USERS, id).get();
  c.setLoading;
  c.isAllow.value = user["is_allow_request"];
}

void switchAllow() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AccountViewController c = Get.put(AccountViewController());

  var docRef = CloudManager.getDoc(CloudManager.USERS, auth.currentUser?.uid ?? "");
  var docSnapshot = await docRef.get();
  if (docSnapshot.exists) {
    var user = docSnapshot.data();
    user?["is_allow_request"] = !user["is_allow_request"];
    docRef.update(user!);
  }
  c.isAllow.value = !c.isAllow.value;
}

Future<dynamic> deleteAccountDialog(BuildContext context, double width) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: true,
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(translate(IKey.DELETE_ACCOUNT)),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(translate(IKey.CLOSE)),
                ),
              ),
              SizedBox(
                width: width,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 23, 116, 153),
                    elevation: 0,
                  ),
                  onPressed: () async {
                    deleteUser();
                    await GoogleSignIn().disconnect();
                    await FirebaseAuth.instance.signOut();
                    RouteManager.goRouteAndRemoveBefore(RouteName.LOGIN);
                  },
                  child: Text(translate(IKey.DELETE)),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void deleteUser() {
  final FirebaseAuth auth = FirebaseAuth.instance;

  CloudManager.getCollection(CloudManager.USER_LISTS)
      .where("user_id", isEqualTo: auth.currentUser?.uid)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
    snapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> doc) {
      doc.reference.delete();
    });
  });
  CloudManager.getCollection(CloudManager.USERS)
      .where("id", isEqualTo: auth.currentUser?.uid)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
    snapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> doc) {
      doc.reference.delete();
    });
  });
}
