import 'package:ffr/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageSender extends StatefulWidget {
  const MessageSender({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  State<MessageSender> createState() => _MessageSenderState();
}

class _MessageSenderState extends State<MessageSender> {
  late final TextEditingController messageController;
  late final GlobalKey<FormState> _formKey;

  static const List<String> prohibitedWords = ['React', 'Js'];

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _onSendMessage() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    messageController.clear();
    print('Message sent: ${widget.authRepository.currentUser}');

    final message = messageController.text;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Message sent!')));
  }

  static const minWidth = 300.0; // Minimum width for the input field

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If the screen width is less than 300px, show a message
        if (constraints.maxWidth < minWidth) {
          return Center(
            child: Text(
              'Screen too narrow for message input',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final width = constraints.maxWidth * 0.3;

        return SizedBox(
          width: width < minWidth ? minWidth : width,
          child: Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please type a message';
                }

                for (final word in prohibitedWords) {
                  if (value.toLowerCase().contains(word.toLowerCase())) {
                    return 'The message contains prohibited words.';
                  }
                }

                return null;
              },
              decoration: InputDecoration(
                labelText: 'Type your message',
                border: OutlineInputBorder(),
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(CupertinoIcons.arrow_up_circle_fill),
                  onPressed: _onSendMessage,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
