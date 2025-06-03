
import 'package:ffr/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  static const messageHeight = 100.0; // height of each message

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // quantity of messages that the height of the screen can fit
        final messagesPerScreenHeight = (constraints.maxHeight / messageHeight)
            .floor(); // assuming each message is 50px tall

        return SizedBox(
          width: constraints.maxWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            // generate the list of rivers
            children: List.generate(
              messagesPerScreenHeight,
              (index) => SizedBox(
                height: messageHeight.toDouble(),
                child: MessageRiverFlow(
                  screenWidth: constraints.maxWidth,
                  messages: List.generate(
                    2,
                    (i) =>
                        'River ${index + 1} - Message ${i + 1} from ${DateTime.now().toLocal()}',
                  ),
                  messageHeight: 50.0,
                  initialDelay: Duration(
                    milliseconds: index * 1000, // stagger the start times
                  ),
                  speed: 8000, // milliseconds
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
