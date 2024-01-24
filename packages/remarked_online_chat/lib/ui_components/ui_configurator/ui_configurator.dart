import 'package:flutter/material.dart';
import 'package:remarked_online_chat/ui_components/ui_configurator/default_ui_config.dart';

class ChatUiConfigurator {
  const ChatUiConfigurator(
      {this.appBarConfig = const AppBarConfig(),
      this.chatFieldConfig = const ChatFieldConfig(),
      this.messageFieldConfig = const MessageFieldConfig()});

  /// Конфигурации шапки страницы
  final AppBarConfig appBarConfig;

  /// Конфигурации чата
  final ChatFieldConfig chatFieldConfig;

  /// Конфигурации поля ввода сообщения
  final MessageFieldConfig messageFieldConfig;
}

class AppBarConfig {
  const AppBarConfig({
    this.title = defaultAppBarTitle,
    this.isTitleCenter = defaultIsAppBarTitleCenter,
    this.actions = const [],
  });
  final Text title;
  final bool isTitleCenter;
  final List<Widget> actions;
}

class MessageFieldConfig {
  const MessageFieldConfig({
    this.backgroundColor = defaultTextFieldBackgroundColor,
    this.containerColor = defaultTextFieldContainerColor,
    this.textStyle,
    this.hintTextStyle,
    this.svgIconSendMessage = defaultSvgIconSendMessage,
    this.svgIconEmojiSend = defaultSvgIconSendEmoji,
    this.svgIconAddFile = defaultSvgIconAddFile,
    this.decorationSendMessage = defaultDecorationSendMessage,
    this.sizeSendMessageContainer = defaultSizeSendMessageContainer,
    this.sizeSendMessageIcon = defaultSizeSendMessageIcon,
    this.heightSendMessageBlock = defaultHeightSendMessage,
    this.minLines = defaultTextFieldsMinLines,
    this.maxLines = defaultTextFieldsMaxLines,
    this.textInputAction = defaultTextInputAction,
  });

  /// Цвет поля ввода, по умолчанию белый
  final Color backgroundColor;

  /// Цвет контейнера, внутри которого находится поле ввода, по умолчанию
  final Color containerColor;

  /// Стиль текста вводимого сообщения
  final TextStyle? textStyle;

  /// Стиль текста подсказки
  final TextStyle? hintTextStyle;

  /// Svg-код иконки отправки сообщения
  final String svgIconSendMessage;

  /// Svg-код иконки отправки сообщения
  final String svgIconEmojiSend;

  /// Svg-код иконки отправки сообщения
  final String svgIconAddFile;

  /// BoxDecoration контейнера-кнопки отправки сообщения
  final BoxDecoration decorationSendMessage;

  /// Размер контейнера кнопки
  final Size sizeSendMessageContainer;

  /// Размер иконки отправки
  final Size sizeSendMessageIcon;

  /// Общая высота блока отправки сообщения
  final double heightSendMessageBlock;

  /// Действия формы ввода при привышении кол-ва символов в строке
  final TextInputAction textInputAction;

  /// Минимальное кол-во строк поля ввода
  final int minLines;

  /// Максимальное количество строк поля ввода
  final int maxLines;
}

class ChatFieldConfig {
  const ChatFieldConfig({
    this.backgroundDecoration = defaultBackgroundDecoration,
    this.inputMessageBackgroundColor = defaultInputMessageBackgroundColor,
    this.outputMessageBackgroundColor = defaultOutputMessageBackgroundColor,
    this.inputMessageTextColor = defaultInputMessageTextColor,
    this.outputMessageTextColor = defaultOutputMessageTextColor,
    this.relativeMessageBubbleWidth = defaultRelativeMessageBubbleWidth,
    this.inputMessageTextStyle,
    this.outputMessageTextStyle,
  });

  /// BoxDecoration контейнера чата
  final BoxDecoration backgroundDecoration;

  /// Цвет фона окна входящего сообщения
  final Color inputMessageBackgroundColor;

  /// Цвет фона окна исходящего сообщения
  final Color outputMessageBackgroundColor;

  /// Цвет текста входящего сообщения, нужен если не указан стиль
  final Color inputMessageTextColor;

  /// Цвет текста исходящего сообщения, нужен если не указан стиль
  final Color outputMessageTextColor;

  /// Стиль текста входящего сообщения
  final TextStyle? inputMessageTextStyle;

  /// Стиль текста исходящего сообщения
  final TextStyle? outputMessageTextStyle;

  /// Относительная ширина окна сообщения в процентах от ширины экрана от 0 до 1
  final double relativeMessageBubbleWidth;
}
