import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_kit/flutter_chat_ui_kit.dart';

///creates a widget that gives text bubble
class CometChatTextBubble extends StatelessWidget {
  CometChatTextBubble({
    Key? key,
    required this.onTapUrl,
    this.text,
    this.style = const TextBubbleStyle(),
    this.theme,
    this.alignment,
  }) : super(key: key);

  ///[onTapUrl] handle url tap inside message bubble
  final Function(String) onTapUrl;

  ///[text] if message object is not passed then text should be passed
  final String? text;

  ///[style] manages the styling of this widget
  final TextBubbleStyle style;

  ///[theme] sets custom theme
  final CometChatTheme? theme;

  ///[alignment] of the bubble
  final BubbleAlignment? alignment;

  final RegExp _emailRegex = RegExp(
    RegexConstants.emailRegexPattern,
    caseSensitive: false,
  );
  final RegExp _urlRegex = RegExp(RegexConstants.urlRegexPattern);

  final RegExp _phoneNumberRegex =
      RegExp(RegexConstants.phoneNumberRegexPattern);

  TextStyle getTextStyle(
      String word, CometChatTheme _theme, BubbleAlignment? alignment) {
    if (_urlRegex.hasMatch(word) ||
        _emailRegex.hasMatch(word) ||
        _phoneNumberRegex.hasMatch(word)) {
      return TextStyle(
          color: alignment == BubbleAlignment.right
              ? Colors.white
              : _theme.palette.getAccent(),
          fontWeight: _theme.typography.body.fontWeight,
          fontSize: _theme.typography.body.fontSize,
          fontFamily: _theme.typography.body.fontFamily,
          decoration: TextDecoration.underline);
    } else {
      return style.textStyle ??
          TextStyle(
              color: alignment == BubbleAlignment.right
                  ? Colors.white
                  : _theme.palette.getAccent(),
              fontWeight: _theme.typography.body.fontWeight,
              fontSize: _theme.typography.body.fontSize,
              fontFamily: _theme.typography.body.fontFamily);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? _message;
    if (text != null) {
      _message = text;
    }

    if (_message == null) {
      return const SizedBox(height: 0, width: 0);
    }
    CometChatTheme _theme = theme ?? cometChatTheme;

    List<String?> words = [];
    String word = '';
    for (int i = 0; i < _message.length; i++) {
      word += _message[i];
      if (_message[i] == ' ') {
        var wordToAdd = word.trim();
        if (wordToAdd.isNotEmpty) {
          words.add(wordToAdd);
        }
        word = '';
      } else if (_message[i].codeUnits[0] == 10) {
        var wordToAdd = word.trim();
        if (wordToAdd.isNotEmpty) {
          words.add(wordToAdd);
        }
        words.add(null);
        word = '';
      }
    }
    words.add(word.trim());
    return Container(
        height: style.height,
        width: style.width,
        decoration: BoxDecoration(
            border: style.border,
            borderRadius: BorderRadius.circular(style.borderRadius ?? 6),
            color: style.gradient == null
                ? style.background ?? Colors.transparent
                : null,
            gradient: style.gradient),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
          child: RichText(
            text: TextSpan(
                style: style.textStyle ??
                    TextStyle(
                        color: alignment == BubbleAlignment.right
                            ? Colors.white
                            : _theme.palette.getAccent(),
                        fontWeight: _theme.typography.body.fontWeight,
                        fontSize: _theme.typography.body.fontSize,
                        fontFamily: _theme.typography.body.fontFamily),
                children: [
                  for (String? word in words)
                    TextSpan(
                        text: word != null ? '$word ' : '\n',
                        style: getTextStyle(word ?? '', _theme, alignment),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            await onTapUrl(word ?? '');
                          })
                ]),
          ),
        ));
  }
}
