import 'package:flutter/material.dart';

import '../../../models/message.dart';
import '../../ui_configurator/ui_configurator.dart';
import '../../widgets/message_bubble.dart';

class MainChatBlock extends StatefulWidget {
  const MainChatBlock(
      this.chatUiConfigurator, this.scrollController, this.messages,
      {super.key});
  final ChatUiConfigurator chatUiConfigurator;
  final ScrollController scrollController;
  final List<Message> messages;

  @override
  State<MainChatBlock> createState() => _MainChatBlockState();
}

class _MainChatBlockState extends State<MainChatBlock> {
  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return Expanded(
      child: Container(
        decoration:
            widget.chatUiConfigurator.chatFieldConfig.backgroundDecoration,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 8.0,
            bottom: (viewInsets.bottom > 0) ? 8.0 : 5.0,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                  controller: widget.scrollController,
                  itemCount: widget.messages.length,
                  itemBuilder: (context, index) {
                    final message = widget.messages[index];
                    return Row(
                      mainAxisAlignment:
                          (message.direction == MessageDirection.output)
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                      children: [
                        MessageBubble(
                            message: message,
                            chatUiConfigurator: widget.chatUiConfigurator),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
