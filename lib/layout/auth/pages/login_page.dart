import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';

import 'package:scout/layout/auth/pages/signup_page.dart';
import 'package:scout/layout/auth/widgets/method.dart';
import 'package:scout/layout/pages/layout_page.dart';
import 'package:scout/layout/widgets/reuse_widget.dart';

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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isPassword = true;

  String messageEmail = '/';
  String sss = '/';
  String messagePassword = '/';
  Future<String> loginUser({email, password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "done";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        messageEmail = 'No user found for that email.';

        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        setState(() {
          messagePassword = 'Wrong password provided for that user.';
        });
        return "Wrong password provided for that user.";
      } else {
        return "Something is Wrong plase try later.";
      }
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
                    'assets/images/backg-1.jpg',
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
                          flex: 4,
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
                                        'SIGN IN',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white.withOpacity(.8),
                                        ),
                                      ),
                                    ),
                                    component(context,
                                        controller: _email,
                                        type: TextInputType.emailAddress,
                                        validate: ValidationBuilder(
                                                requiredMessage:
                                                    'can not be emity')
                                            .email()
                                            .add((_) {
                                          if (messageEmail != '/') {
                                            return messageEmail;
                                          }
                                          return null;
                                        }).build(),
                                        hintText: 'Email...',
                                        prefix: Icons.email_outlined,
                                        textInputAction: TextInputAction.next),
                                    component(
                                      context,
                                      isPassword: isPassword,
                                      controller: _password,
                                      type: TextInputType.text,
                                      validate: ValidationBuilder(
                                              requiredMessage:
                                                  'can not be emity')
                                          .minLength(6)
                                          .add((_) {
                                        if (messagePassword != '/') {
                                          return messagePassword;
                                        }
                                        return null;
                                      }).build(),
                                      hintText: 'Password...',
                                      prefix: Icons.lock_outline,
                                      suffix: isPassword != true
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isPassword = !isPassword;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.visibility_off_outlined,
                                                color: Colors.white
                                                    .withOpacity(.9),
                                              ))
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isPassword = !isPassword;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.visibility_outlined,
                                                color: Colors.white
                                                    .withOpacity(.9),
                                              )),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'Forgotten password!',
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
                                              },
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Create a new Account',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                HapticFeedback.lightImpact();
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignUpPage(),
                                                ));
                                              },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SignInButton(
                                      Buttons.Google,
                                      onPressed: () {
                                        HapticFeedback.lightImpact();

                                        signInWithGoogle().then(
                                          (_) => Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LayoutPage()),
                                            (route) => false,
                                          ),
                                        );
                                      },
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        HapticFeedback.lightImpact();
                                        Fluttertoast.showToast(
                                          msg: 'Sign-In button pressed',
                                        );
                                        if (formkey.currentState!.validate()) {}

                                        messageEmail = '/';

                                        messagePassword = '/';
                                        if (formkey.currentState!.validate()) {
                                          sss = await loginUser(
                                              email: _email.text,
                                              password: _password.text);
                                          if (sss == "done") {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LayoutPage()),
                                                    (route) => false);
                                          } else if (sss ==
                                              "No user found for that email.") {
                                            setState(() {
                                              messageEmail =
                                                  "No user found for that email.";
                                              formkey.currentState!.validate();
                                            });
                                          } else if (sss ==
                                              "Wrong password provided for that user.") {
                                            setState(() {
                                              messagePassword =
                                                  "Wrong password provided for that user.";
                                              formkey.currentState!.validate();
                                            });
                                          } else {
                                            showSnackBar(context,
                                                'Something is wrong plase try later');
                                          }
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
                                          'Sing-In',
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
}
