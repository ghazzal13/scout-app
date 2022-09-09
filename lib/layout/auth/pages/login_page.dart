import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:scout/layout/auth/pages/signup_page.dart';

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
                                            .build(),
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
                                          .build(),
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
                                    // component(
                                    //   Icons.lock_outline,
                                    //   'Password...',
                                    //   true,
                                    //   false,
                                    //   context,
                                    //   _password,
                                    //   ValidationBuilder(
                                    //           requiredMessage:
                                    //               'can not be emity')
                                    //       .minLength(6)
                                    //        .build(),
                                    // ),
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
                                    SizedBox(height: size.width * .3),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        HapticFeedback.lightImpact();
                                        Fluttertoast.showToast(
                                          msg: 'Sign-In button pressed',
                                        );
                                        if (formkey.currentState!.validate()) {}
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
