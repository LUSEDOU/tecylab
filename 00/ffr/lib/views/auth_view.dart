import 'package:ffr/repository.dart';
import 'package:ffr/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  const AuthView({
    super.key,
    required this.loggedIn,
    required this.authRepository,
    required this.messageRepository,
  });

  final ValueNotifier<bool> loggedIn;
  final AuthRepository authRepository;
  final MessageRepository messageRepository;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<bool>(
        valueListenable: loggedIn,
        builder: (context, loggedIn, child) {
          if (loggedIn) {
            return MessageSender(
              authRepository: authRepository,
              messageRepository: messageRepository,
            );
          }

          return AuthDialog(authRepository: authRepository);
        },
      ),
    );
  }
}
