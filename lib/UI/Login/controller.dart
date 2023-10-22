import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kaydi_mobile/UI/Login/view_controller.dart';
import 'package:kaydi_mobile/core/cloud/manager.dart';
import 'package:kaydi_mobile/core/models/user_model.dart';
import 'package:kaydi_mobile/core/notifications/manager.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';

void loginWithGoogle() async {
  LoginViewController c = Get.put(LoginViewController());
  try {
    c.setLoading;
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    var userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    var token = await NotificationManager().getToken();
    print("token: " + token);
    var user = UserModel(
      id: userCredential.user?.uid ?? "",
      photoUrl: userCredential.user?.photoURL ?? "",
      email: userCredential.user?.email ?? "",
      name: userCredential.user?.displayName ?? "",
      isAllowRequest: true,
      fcmToken: token,
    );
    final docUser = CloudManager.getDoc(CloudManager.USERS, userCredential.user?.uid);
    docUser.set(user.toJson());
    c.setLoading;

    RouteManager.goRouteAndRemoveBefore(RouteName.HOME);
  } catch (e) {
    c.setLoading;
    print(e);
  }
}
