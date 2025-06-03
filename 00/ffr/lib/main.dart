import 'dart:async';

import 'package:ffr/firebase_options.dart';
import 'package:ffr/repository.dart';
import 'package:ffr/views/message_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'views/auth_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AuthRepository authRepository = AuthRepository(FirebaseAuth.instance);

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Screen(authRepository: authRepository),
    );
  }
}

class Screen extends StatefulWidget {
  const Screen({super.key, required this.authRepository});

  final AuthRepository authRepository;
  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  late ValueNotifier<bool> loggedIn;

  @override
  void initState() {
    super.initState();
    loggedIn = ValueNotifier<bool>(widget.authRepository.currentUser != null);

    // Listen to authentication state changes
    widget.authRepository.authStateChanges.listen(onAuthStateChanged);
  }

  Future<void> onAuthStateChanged(User? user) async {
    if (user == null) {
      loggedIn.value = false;
    } else {
      loggedIn.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Flutter Demo Home Page'),
      ),
      body: Stack(
        children: [
          MessageView(),
          AuthView(
            loggedIn: loggedIn,
            authRepository: widget.authRepository,
          ),
        ],
      ),
    );
  }
}


