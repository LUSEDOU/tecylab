import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MessageRiverFlow extends StatefulWidget {
  const MessageRiverFlow({
    super.key,
    this.screenWidth = 800,
    this.messages = const [],
    this.messageHeight = 50.0,
    this.speed = 8000, // milliseconds
    this.initialDelay,
  });

  final double screenWidth;
  final List<String> messages;
  final double messageHeight;
  final double speed; // milliseconds
  final Duration? initialDelay;

  @override
  State<MessageRiverFlow> createState() => _MessageRiverFlowState();
}

class _MessageRiverFlowState extends State<MessageRiverFlow> {
  late final ScrollController _scrollController;
  late final Timer _messageFlowTimer;

  Future<void> initTimer() async {
    // Simulate a message flow by scrolling to the end of the list
    if (widget.initialDelay != null) {
      await Future.delayed(widget.initialDelay!);
    }

    _messageFlowTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_scrollController.hasClients) return;

      // if the amount of pixels scrolled is greater than the max scroll extent, then go to the max scroll extent
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - widget.screenWidth) {
        // If at the end, reset to the start
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: widget.speed ~/ 2),
          curve: Curves.linear,
        );
        return;
      }

      // Move half the screen width to the right
      _scrollController.animateTo(
        _scrollController.position.pixels + widget.screenWidth / 2,
        duration: Duration(milliseconds: widget.speed ~/ 2),
        curve: Curves.linear,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initTimer();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageFlowTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        dragStartBehavior: DragStartBehavior.start,
        itemCount: widget.messages.length,
        controller: _scrollController,
        padding: EdgeInsets.zero,
        separatorBuilder: (_, __) => SizedBox(width: 16.0 * 4),
        itemBuilder: (_, i) {
          return SizedBox(
            height: widget.messageHeight,
            child: Text(
              widget.messages[i],
              style: TextStyle(
                fontSize: widget.messageHeight,
                color: Colors.black87,
              ),
            ),
          );
        },
      ),
    );
  }
}
