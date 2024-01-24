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
const String defaultSvgIconSendEmoji =
    '''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M9.97506 18.3334C14.5774 18.3334 18.3084 14.6024 18.3084 10C18.3084 5.39765 14.5774 1.66669 9.97506 1.66669C5.37268 1.66669 1.64172 5.39765 1.64172 10C1.64172 14.6024 5.37268 18.3334 9.97506 18.3334Z" stroke="#998FA9" stroke-width="1.25" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M6.0083 13.3333C6.8833 14.5916 8.34997 15.4166 9.99997 15.4166C11.65 15.4166 13.1083 14.5916 13.9916 13.3333" stroke="#998FA9" stroke-width="1.25" stroke-linecap="round" stroke-linejoin="round"/>
<circle cx="7.49996" cy="8.33333" r="0.833333" fill="#998FA9"/>
<circle cx="12.5" cy="8.33333" r="0.833333" fill="#998FA9"/>
</svg>
''';
const String defaultSvgIconAddFile =
    '''<svg width="28" height="28" viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M7 14H21" stroke="#998FA9" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M14 21V7" stroke="#998FA9" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/>
</svg>

''';
const BoxDecoration defaultDecorationSendMessage =
    BoxDecoration(color: Color.fromRGBO(249, 1, 2, 1), shape: BoxShape.circle);
const Size defaultSizeSendMessageContainer = Size(40, 40);
const Size defaultSizeSendMessageIcon = Size(20, 20);
const double defaultHeightSendMessage = 72;
const double defaultRelativeMessageBubbleWidth = 315 / 390;
const int defaultTextFieldsMinLines = 1;
const int defaultTextFieldsMaxLines = 3;
const TextInputAction defaultTextInputAction = TextInputAction.newline;
