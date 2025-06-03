import 'dart:async';

import 'package:ffr/firebase_options.dart';
import 'package:ffr/repository.dart';
import 'package:ffr/views/message_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'views/auth_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AuthRepository authRepository = AuthRepository(FirebaseAuth.instance);
  MessageRepository messageRepository = MessageRepository(
    firebaseDatabase: FirebaseDatabase.instance.ref(),
  );

  runApp(
    MyApp(authRepository: authRepository, messageRepository: messageRepository),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.authRepository,
    required this.messageRepository,
  });

  final AuthRepository authRepository;
  final MessageRepository messageRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Screen(
        authRepository: authRepository,
        messageRepository: messageRepository,
      ),
    );
  }
}

class Screen extends StatefulWidget {
  const Screen({
    super.key,
    required this.authRepository,
    required this.messageRepository,
  });

  final AuthRepository authRepository;
  final MessageRepository messageRepository;
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
          MessageView(messageRepository: widget.messageRepository),
          AuthView(
            loggedIn: loggedIn,
            authRepository: widget.authRepository,
            messageRepository: widget.messageRepository,
          ),
        ],
      ),
    );
  }
}
