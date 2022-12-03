import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scout/app_theme.dart';
import 'package:scout/layout/auth/pages/login_page.dart';
import 'package:scout/layout/pages/change_password/change_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '  Settings',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            child: Image.asset(
              'assets/images/settings.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
          Center(
            child: Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                    child: SizedBox(
                      width: size.width * .8,
                      height: size.height * .5,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),

                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: primaryColor),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ChangePasswordScreen()),
                                        (route) => false);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Change Password',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: primaryColor),
                                child: TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut().then(
                                        (value) => Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginPage()),
                                                (route) => false));
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'log out',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     const SizedBox(),
                              //     IconButton(
                              //         onPressed: () {
                              //           navigateTo(context, const WebPage(url: 'github'));
                              //         },
                              //         icon: const FaIcon(
                              //           FontAwesomeIcons.github,
                              //           color: Colors.black,
                              //           size: 35,
                              //         )),
                              //     const SizedBox(
                              //       width: 10,
                              //     ),
                              //     IconButton(
                              //         onPressed: () {
                              //           navigateTo(context, const WebPage(url: 'linkedin'));
                              //         },
                              //         icon: const FaIcon(
                              //             size: 35,
                              //             FontAwesomeIcons.linkedin,
                              //             color: Colors.blue)),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
      //  Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         decoration: const BoxDecoration(color: Colors.black),
      //         child: TextButton(
      //             onPressed: () {
      //               FirebaseAuth.instance.signOut().then((value) =>
      //                   Navigator.of(context).pushAndRemoveUntil(
      //                       MaterialPageRoute(
      //                           builder: (context) => const LoginPage()),
      //                       (route) => false));
      //             },
      //             child: const Text(
      //               'log out',
      //               style: TextStyle(
      //                   color: Colors.red,
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 30),
      //             )),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         decoration: const BoxDecoration(color: Colors.black),
      //         child: TextButton(
      //             onPressed: () {
      //               Navigator.of(context).pushAndRemoveUntil(
      //                   MaterialPageRoute(
      //                       builder: (context) => const ChangePasswordScreen()),
      //                   (route) => false);
      //             },
      //             child: const Text(
      //               'Change Password',
      //               style: TextStyle(
      //                   color: Colors.red,
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 30),
      //             )),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
