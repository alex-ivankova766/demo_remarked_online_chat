import 'dart:async';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remarked_online_chat/models/message.dart';
import 'package:remarked_online_chat/services/api_client.dart';
import 'package:remarked_online_chat/services/credentials.dart';
import 'package:remarked_online_chat/ui_components/ui_configurator/ui_configurator.dart';
import 'package:remarked_online_chat/ui_components/widgets/info_snack_bar.dart';
import 'package:uuid/uuid.dart';

import 'widgets/main_block.dart';

ApiClient apiClient = ApiClient();

class ChatRoomScreen extends StatefulWidget {
  ChatRoomScreen(
      {required this.credentials,
      this.chatUiConfigurator = const ChatUiConfigurator(),
      super.key}) {
    apiClient.credentials = credentials;
  }
  final ChatUiConfigurator chatUiConfigurator;
  final Credentials credentials;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  final FocusNode _focusNode = FocusNode();
  bool emojiShowing = false;
  double keyboardHeight = 250;
  bool isKeyboardWasOpen = false;
  late Timer timer;

  @override
  void initState() {
    _loadAllMessages().then((_) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (_messages.isEmpty) {
          _loadAllMessages();
        } else {
          _loadNewMessages();
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    _focusNode.dispose();
    messageController.dispose();
    _scrollController.dispose();
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

  Future<void> _sendMessage() async {
    final message = Message(
        createdAt: DateTime.now(),
        content: messageController.text,
        channel: MessageChannel.onlinechat,
        direction: MessageDirection.output,
        recipient: '',
        sender: widget.credentials.phone,
        point: widget.credentials.point,
        uuid: const Uuid().v4());
    setState(() {
      _messages.add(message);
    });
    messageController.clear();
    _scrollToBottom();
    message.id = await apiClient.sendMessage(message);
    if (message.id == null) {
      _showInfo('Сообщение не отправлено');
      setState(() {
        _messages.removeLast();
      });
      messageController.text = message.content;
      _scrollToBottom();
      return;
    }
  }

  void _showInfo(String info) {
    InfoSnackBar(context, info);
  }

  void _changeEmojiVisible() {
    setState(() {
      emojiShowing = !emojiShowing;
    });
  }

  Future<void> _loadNewMessages() async {
    List<Message> messagesFromApi =
        await apiClient.fetchNewMessages(_messages.last.id);
    if (messagesFromApi.isEmpty) {
      return;
    }

    Set<Message> setMessagesFromApi = Set.from(messagesFromApi);
    Set<Message> setMessagesOnPhone = Set.from(_messages);

    Set<Message> onlyNewMessages =
        setMessagesFromApi.difference(setMessagesOnPhone);

    List<Message> onlyNewMessagesList = onlyNewMessages.toList();
    setState(() {
      _messages.addAll(onlyNewMessagesList);
    });
    _scrollToBottom();
  }

  Future<void> _loadAllMessages() async {
    List<Message> messagesFromApi = await apiClient.fetchMessages();
    if (messagesFromApi.isEmpty) {
      return;
    }
    messagesFromApi.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    setState(() {
      _messages.addAll(messagesFromApi);
    });
    _scrollToBottom();
  }

  _onBackspacePressed() {
    messageController
      ..text = messageController.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: messageController.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _focusNode.unfocus();
          setState(() {
            emojiShowing = false;
            isKeyboardWasOpen = false;
          });
        },
        child: SafeArea(
            child: PopScope(
                canPop: !emojiShowing,
                onPopInvoked: (didPop) {
                  if (didPop) {
                    return;
                  }
                  setState(() {
                    emojiShowing = false;
                    isKeyboardWasOpen = false;
                  });
                },
                child: Scaffold(
                    backgroundColor: widget
                        .chatUiConfigurator.messageFieldConfig.backgroundColor,
                    appBar: AppBar(
                      centerTitle:
                          widget.chatUiConfigurator.appBarConfig.isTitleCenter,
                      title: widget.chatUiConfigurator.appBarConfig.title,
                      actions: widget.chatUiConfigurator.appBarConfig.actions,
                    ),
                    body: Column(children: [
                      MainChatBlock(widget.chatUiConfigurator,
                          _scrollController, _messages),
                      Container(
                          color: widget.chatUiConfigurator.messageFieldConfig
                              .containerColor,
                          height: 73,
                          child: Row(mainAxisSize: MainAxisSize.max, children: [
                            const SizedBox(
                              width: 12,
                            ),
                            // SizedBox(
                            //   height: 28,
                            //   width: 28,
                            //   child: FittedBox(
                            //       fit: BoxFit.fill,
                            //       child: IconButton(
                            //         onPressed: () {
                            //           if (!emojiShowing) {
                            //             if (isKeyboardWasOpen) {
                            //               _focusNode.unfocus();
                            //             }
                            //             Future.delayed(
                            //                 const Duration(milliseconds: 200),
                            //                 _changeEmojiVisible);
                            //           } else {
                            //             _changeEmojiVisible();
                            //             if (isKeyboardWasOpen) {
                            //               _focusNode.requestFocus();
                            //             }
                            //           }
                            //         },
                            //         icon: SvgPicture.string(
                            //           widget.chatUiConfigurator
                            //               .messageFieldConfig.svgIconAddFile,
                            //           height: 100,
                            //           width: 100,
                            //         ),
                            //       )),
                            // ),
                            Expanded(
                                child: Container(
                              color: widget.chatUiConfigurator
                                  .messageFieldConfig.containerColor,
                              constraints: BoxConstraints(
                                  minHeight: widget
                                      .chatUiConfigurator
                                      .messageFieldConfig
                                      .heightSendMessageBlock),
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  top: 16, bottom: 16, right: 12, left: 4),
                              child: TextFormField(
                                  onTap: () {
                                    setState(() {
                                      if (MediaQuery.of(context)
                                              .viewInsets
                                              .bottom !=
                                          0.0) {
                                        keyboardHeight = MediaQuery.of(context)
                                            .viewInsets
                                            .bottom;
                                      }
                                      emojiShowing = false;
                                      isKeyboardWasOpen = true;
                                    });
                                  },
                                  focusNode: _focusNode,
                                  style: widget.chatUiConfigurator
                                      .messageFieldConfig.textStyle,
                                  controller: messageController,
                                  textInputAction: TextInputAction.newline,
                                  minLines: 1,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        if (!emojiShowing) {
                                          if (isKeyboardWasOpen) {
                                            _focusNode.unfocus();
                                          }
                                          Future.delayed(
                                              const Duration(milliseconds: 150),
                                              _changeEmojiVisible);
                                        } else {
                                          _changeEmojiVisible();
                                          if (isKeyboardWasOpen) {
                                            _focusNode.requestFocus();
                                          }
                                        }
                                      },
                                      icon: SvgPicture.string(
                                          widget
                                              .chatUiConfigurator
                                              .messageFieldConfig
                                              .svgIconEmojiSend,
                                          height: widget
                                              .chatUiConfigurator
                                              .messageFieldConfig
                                              .sizeSendMessageIcon
                                              .height,
                                          width: widget
                                              .chatUiConfigurator
                                              .messageFieldConfig
                                              .sizeSendMessageIcon
                                              .width,
                                          fit: BoxFit.contain),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 11, horizontal: 20),
                                    filled: true,
                                    fillColor: widget.chatUiConfigurator
                                        .messageFieldConfig.backgroundColor,
                                    hintText: 'Сообщение',
                                    hintStyle: widget.chatUiConfigurator
                                        .messageFieldConfig.hintTextStyle,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  )),
                            )),
                            Container(
                                decoration: widget.chatUiConfigurator
                                    .messageFieldConfig.decorationSendMessage,
                                height: widget
                                    .chatUiConfigurator
                                    .messageFieldConfig
                                    .sizeSendMessageContainer
                                    .height,
                                width: widget
                                    .chatUiConfigurator
                                    .messageFieldConfig
                                    .sizeSendMessageContainer
                                    .width,
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
                                    height: widget
                                        .chatUiConfigurator
                                        .messageFieldConfig
                                        .sizeSendMessageIcon
                                        .height,
                                    width: widget
                                        .chatUiConfigurator
                                        .messageFieldConfig
                                        .sizeSendMessageIcon
                                        .width,
                                    fit: BoxFit.contain,
                                  ),
                                )),
                            const SizedBox(
                              width: 12,
                            ),
                          ])),
                      emojiShowing
                          ? SizedBox(
                              height: keyboardHeight,
                              child: EmojiPicker(
                                key: UniqueKey(),
                                textEditingController: messageController,
                                onBackspacePressed: _onBackspacePressed,
                                config: Config(
                                  columns: 7,
                                  emojiSizeMax: 32 *
                                      (foundation.defaultTargetPlatform ==
                                              TargetPlatform.iOS
                                          ? 1.30
                                          : 1.0),
                                  verticalSpacing: 0,
                                  horizontalSpacing: 0,
                                  gridPadding: EdgeInsets.zero,
                                  initCategory: Category.RECENT,
                                  bgColor: widget.chatUiConfigurator
                                      .messageFieldConfig.containerColor,
                                  indicatorColor: Colors.blue,
                                  iconColor: Colors.grey,
                                  iconColorSelected: Colors.blue,
                                  backspaceColor: Colors.blue,
                                  skinToneDialogBgColor: Colors.white,
                                  skinToneIndicatorColor: Colors.grey,
                                  enableSkinTones: true,
                                  recentTabBehavior: RecentTabBehavior.RECENT,
                                  recentsLimit: 28,
                                  replaceEmojiOnLimitExceed: false,
                                  noRecents: Text(
                                    'Часто используемые',
                                    style: widget.chatUiConfigurator
                                        .messageFieldConfig.hintTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  loadingIndicator: const SizedBox.shrink(),
                                  tabIndicatorAnimDuration: kTabScrollDuration,
                                  categoryIcons: const CategoryIcons(),
                                  buttonMode: ButtonMode.MATERIAL,
                                  checkPlatformCompatibility: true,
                                ),
                              ))
                          : const SizedBox()
                    ])))));
  }
}
