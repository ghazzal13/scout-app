import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scout/bloc_observer.dart';
import 'package:scout/cubit/cubit.dart';
import 'package:scout/cubit/states.dart';
import 'package:scout/layout/auth/pages/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:scout/layout/pages/layout_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => PlayersCubit()),
      ],
      child: BlocConsumer<PlayersCubit, PlayersStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return const LayoutPage();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    }
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return const LoginPage();
                },
              ),
            );
          }),
    );
  }
}

// /*
// Platform  Firebase App Id
// web       1:453196205507:web:ece4328a98bff7691cc176
// android   1:453196205507:android:d687f1222ce85d1d1cc176
// ios       1:453196205507:ios:18deb9fdafe9ee041cc176
// macos     1:453196205507:ios:18deb9fdafe9ee041cc176
// */

