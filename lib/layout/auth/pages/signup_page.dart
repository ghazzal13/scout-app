import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scout/layout/auth/pages/login_page.dart';
import 'package:scout/layout/pages/layout_page.dart';

import '../widgets/text_feild.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var formkey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _address = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createUser({
    required String name,
    required String email,
    required String address,
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

  String messageEmail = '/';

  void signUpUser({email, password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        createUser(
          name: _name.text,
          email: _email.text,
          address: _address.text,
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LayoutPage()),
            (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          messageEmail = 'The account already exists for that email.';
        });
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  child: Image.asset(
                    'assets/images/signup.jpg',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 6,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                              child: SizedBox(
                                width: size.width * .9,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: size.width * .15,
                                        bottom: size.width * .1,
                                      ),
                                      child: Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white.withOpacity(.8),
                                        ),
                                      ),
                                    ),
                                    component(
                                      context,
                                      controller: _name,
                                      type: TextInputType.text,
                                      validate: ValidationBuilder(
                                              requiredMessage:
                                                  'can not be emity')
                                          .build(),
                                      hintText: 'User name...',
                                      prefix: Icons.account_circle_outlined,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    component(context,
                                        controller: _email,
                                        type: TextInputType.emailAddress,
                                        validate: ValidationBuilder(
                                                requiredMessage:
                                                    'can not be emity')
                                            .email()
                                            .build(),
                                        hintText: 'Email...',
                                        prefix: Icons.email_outlined,
                                        textInputAction: TextInputAction.next),
                                    component(context,
                                        controller: _password,
                                        type: TextInputType.text,
                                        validate: ValidationBuilder(
                                                requiredMessage:
                                                    'can not be emity')
                                            .build(),
                                        hintText: 'Password...',
                                        prefix: Icons.lock_outline,
                                        textInputAction: TextInputAction.next),
                                    component(
                                      context,
                                      controller: _address,
                                      type: TextInputType.text,
                                      validate: ValidationBuilder(
                                              requiredMessage:
                                                  'can not be emity')
                                          .build(),
                                      hintText: 'Address...',
                                      prefix: Icons.place_outlined,
                                      textInputAction: TextInputAction.done,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'Sign Up With Google',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                HapticFeedback.lightImpact();
                                                Fluttertoast.showToast(
                                                  msg:
                                                      'Forgotten password! button pressed',
                                                );
                                                signInWithGoogle().then(
                                                    (value) => Navigator.of(
                                                            context)
                                                        .push(MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LayoutPage())));
                                              },
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Sign in instead',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                HapticFeedback.lightImpact();
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage(),
                                                ));
                                              },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: size.width * .2),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        HapticFeedback.lightImpact();
                                        Fluttertoast.showToast(
                                          msg: 'Sign-Up button pressed',
                                        );
                                        if (formkey.currentState!.validate()) {
                                          signUpUser(
                                              email: _email.text,
                                              password: _password.text);
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          bottom: size.width * .05,
                                        ),
                                        height: size.width / 8,
                                        width: size.width / 1.25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Text(
                                          'Sing-Up',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
