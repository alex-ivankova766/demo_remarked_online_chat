import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remarked_online_chat/example/messages.dart';
import 'package:remarked_online_chat/models/message.dart';
import 'package:remarked_online_chat/ui_components/ui_configurator/ui_configurator.dart';
import 'package:remarked_online_chat/ui_components/widgets/info_snack_bar.dart';
import 'package:remarked_online_chat/ui_components/widgets/message_bubble.dart';

List<String> messageResponses = [
  'Ваш ответ принят!',
  'Спасибо!',
  'Конечно!',
  'Внимательно слушаем Вас!',
  'Добрый день!',
  'Здравствуйте!'
];

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen(
      {this.chatUiConfigurator = const ChatUiConfigurator(), super.key});
  final ChatUiConfigurator chatUiConfigurator;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> messages = [];

  @override
  void initState() {
    _loadMessages();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _sendMessage() async {
    final message = Message(
        createdAt: DateTime.now(),
        content: messageController.text,
        channel: MessageChannel.telegram,
        direction: MessageDirection.output,
        recipient: '',
        sender: '',
        point: 0);
    setState(() {
      messages.add(message);
    });
    Random random = Random();
    int randomIndex = random.nextInt(messageResponses.length);
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add(Message(
            createdAt: DateTime.now(),
            content: messageResponses[randomIndex],
            channel: MessageChannel.telegram,
            direction: MessageDirection.input,
            recipient: '',
            sender: '',
            point: 0));
      });
      _scrollToBottom();
    });

    messageController.clear();
    _scrollToBottom();
    // bool isSendSuccess = await apiClient.sendMessage(message.content);
    // if (!isSendSuccess) {
    //   showInfo('Сообщение не отправлено');
    //   setState(() {
    //     messages.removeLast();
    //   });
    //   messageController.text = message.content;
    //   _scrollToBottom();
    //   return;
    // }
  }

  void showInfo(String info) {
    InfoSnackBar(context, info);
  }

  _loadMessages() async {
    // List<Message> _messages = await apiClient.fetchMessages();
    exampleMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    setState(() {
      messages.addAll(exampleMessages);
    });
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;

    return Scaffold(
        backgroundColor:
            widget.chatUiConfigurator.messageFieldConfig.backgroundColor,
        appBar: AppBar(
          centerTitle: widget.chatUiConfigurator.appBarConfig.isTitleCenter,
          title: widget.chatUiConfigurator.appBarConfig.title,
          actions: widget.chatUiConfigurator.appBarConfig.actions,
        ),
        body: SafeArea(
            child: Column(children: [
          Expanded(
            child: Container(
              decoration: widget
                  .chatUiConfigurator.chatFieldConfig.backgroundDecoration,
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
                        controller: _scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return Row(
                            mainAxisAlignment:
                                (message.direction == MessageDirection.output)
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: [
                              MessageBubble(
                                  message: message,
                                  chatUiConfigurator:
                                      widget.chatUiConfigurator),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                color:
                    widget.chatUiConfigurator.messageFieldConfig.containerColor,
                constraints: BoxConstraints(
                    minHeight: widget.chatUiConfigurator.messageFieldConfig
                        .heightSendMessageBlock),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: TextFormField(
                    style:
                        widget.chatUiConfigurator.messageFieldConfig.textStyle,
                    controller: messageController,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      filled: true,
                      fillColor: widget.chatUiConfigurator.messageFieldConfig
                          .backgroundColor,
                      hintText: 'Сообщение',
                      hintStyle: widget
                          .chatUiConfigurator.messageFieldConfig.textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    )),
              )),
              Container(
                  decoration: widget.chatUiConfigurator.messageFieldConfig
                      .decorationSendMessage,
                  height: widget.chatUiConfigurator.messageFieldConfig
                      .sizeSendMessageContainer.height,
                  width: widget.chatUiConfigurator.messageFieldConfig
                      .sizeSendMessageContainer.width,
                  child: IconButton(
                    onPressed: () {
                      if (messageController.text == '') {
                        return;
                      }
                      _sendMessage();
                    },
                    icon: SvgPicture.string(
                      widget.chatUiConfigurator.messageFieldConfig
                          .svgIconSendMessage,
                      height: widget.chatUiConfigurator.messageFieldConfig
                          .sizeSendMessageIcon.height,
                      width: widget.chatUiConfigurator.messageFieldConfig
                          .sizeSendMessageIcon.width,
                      fit: BoxFit.contain,
                    ),
                  )),
              const SizedBox(
                width: 12,
              )
            ],
          ),
        ])));
  }
}
