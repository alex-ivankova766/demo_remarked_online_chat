import 'package:flutter/material.dart';
import 'package:remarked_online_chat/models/message.dart';
import 'package:remarked_online_chat/ui_components/ui_configurator/ui_configurator.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key, required this.message, required this.chatUiConfigurator});

  final Message message;
  final ChatUiConfigurator chatUiConfigurator;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final Alignment alignment = (message.direction == MessageDirection.input)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    final Color backgroundColor = (message.direction == MessageDirection.input)
        ? chatUiConfigurator.chatFieldConfig.inputMessageBackgroundColor
        : chatUiConfigurator.chatFieldConfig.outputMessageBackgroundColor;

    final Color textColor = (message.direction == MessageDirection.input)
        ? chatUiConfigurator.chatFieldConfig.inputMessageTextColor
        : chatUiConfigurator.chatFieldConfig.outputMessageTextColor;

    final TextStyle? textStyle = (message.direction == MessageDirection.input)
        ? chatUiConfigurator.chatFieldConfig.inputMessageTextStyle
        : chatUiConfigurator.chatFieldConfig.outputMessageTextStyle;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: size.width *
                chatUiConfigurator.chatFieldConfig.relativeMessageBubbleWidth),
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12.0),
            topRight: const Radius.circular(12.0),
            bottomLeft: (message.direction == MessageDirection.input)
                ? const Radius.circular(0.0)
                : const Radius.circular(12.0),
            bottomRight: (message.direction == MessageDirection.input)
                ? const Radius.circular(12.0)
                : const Radius.circular(0.0),
          ),
        ),
        child: Text(
          message.content,
          style: textStyle ??
              Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: textColor,
                  ),
        ),
      ),
    );
  }
}
