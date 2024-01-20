import 'package:flutter/material.dart';

const BoxDecoration defaultBackgroundDecoration = BoxDecoration(
    gradient: LinearGradient(colors: [
  Color.fromRGBO(255, 175, 189, 1),
  Color.fromRGBO(255, 195, 160, 1)
]));

const Color defaultInputMessageBackgroundColor =
    Color.fromRGBO(243, 244, 248, 1);
const Color defaultOutputMessageBackgroundColor = Colors.white;
const Color defaultInputMessageTextColor = Colors.black;
const Color defaultOutputMessageTextColor = Colors.black;
const Color defaultTextFieldContainerColor = Color.fromRGBO(248, 249, 252, 1);
const Color defaultTextFieldBackgroundColor = Colors.white;
const Text defaultAppBarTitle = Text('Screen from Package');
const bool defaultIsAppBarTitleCenter = true;
const String defaultSvgIconSendMessage =
    '''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M15.0583 7.975L9.99998 2.91667L4.94165 7.975" stroke="white" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M10 17.0833V3.05833" stroke="white" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''';
const BoxDecoration defaultDecorationSendMessage =
    BoxDecoration(color: Color.fromRGBO(249, 1, 2, 1), shape: BoxShape.circle);
const Size defaultSizeSendMessageContainer = Size(40, 40);
const Size defaultSizeSendMessageIcon = Size(20, 20);
const double defaultHeightSendMessage = 72;
const double defaultRelativeMessageBubbleWidth = 315 / 390;
const int defaultTextFieldsMinLines = 1;
const int defaultTextFieldsMaxLines = 3;
const TextInputAction defaultTextInputAction = TextInputAction.newline;
