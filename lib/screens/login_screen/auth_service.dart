import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  signup() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      //clientId: '676476441933-i2td4ujfceb1srpj6bacvsnrr5o4f32b.apps.googleusercontent.com',
      serverClientId: '676476441933-nssg1pv08knk1vld01tq9ble3efbt0ia.apps.googleusercontent.com',
      scopes: [
      'email',
      ],
    );
    print("scope: " + googleSignIn.scopes.toString());
    print("email: " + (googleSignIn.currentUser?.email ?? ''));
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      print(googleSignInAuthentication.idToken);
      print(googleSignInAuthentication.accessToken);
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result = await auth.signInWithCredential(authCredential);
      // User? user = result.user;

      if (result != null) {
        print(result.toString());
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen

      return result;
    }
  }
}
