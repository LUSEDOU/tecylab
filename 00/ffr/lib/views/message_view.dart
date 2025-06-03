import 'dart:async';

import 'package:ffr/repository.dart';
import 'package:ffr/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key, required this.messageRepository});

  final MessageRepository messageRepository;

  static const messageHeight = 100.0;
  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late final List<String> messages;
  // late final Timer _timer;

  void _onNewMessage(String message) {
    print('New message received: $message');
    setState(() {
      messages.add(message);
    });
  }

  @override
  void initState() {
    super.initState();
    messages = [];
    widget.messageRepository.newMessages.listen(_onNewMessage);
  }

  @override
  void dispose() {
    super.dispose();
  }

  // height of each message
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // quantity of messages that the height of the screen can fit
        final messagesPerScreenHeight =
            (constraints.maxHeight / MessageView.messageHeight)
                .floor(); // assuming each message is 50px tall

        return SizedBox(
          width: constraints.maxWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            // generate the list of rivers
            children: List.generate(
              messagesPerScreenHeight,
              (index) => SizedBox(
                height: MessageView.messageHeight.toDouble(),
                child: MessageRiverFlow(
                  screenWidth: constraints.maxWidth,
                  messages: messages,
                  messageHeight: 50.0,
                  initialDelay: Duration(
                    milliseconds: index * 1000, // stagger the start times
                  ),
                  speed: 8000 + (index * 10),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
