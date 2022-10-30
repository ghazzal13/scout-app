import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential
  final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

  if (userCredential.additionalUserInfo?.isNewUser == true) {
    createUser(
        name: userCredential.additionalUserInfo?.profile!['given_name'],
        email: userCredential.additionalUserInfo?.profile!['email'],
        address: 'undefine');
  }
  return userCredential;
}

Future createUser({
  required String? name,
  required String? email,
  required String? address,
}) async {
  Map<String, dynamic> user = {
    'image': 'https://i.stack.imgur.com/l60Hf.png',
    'uid': _auth.currentUser!.uid,
    'name': name,
    'email': email,
    'address': address,
  };
  await _firestore.collection("users").doc(_auth.currentUser!.uid).set(user);
}
