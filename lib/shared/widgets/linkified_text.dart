import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkifiedText extends StatelessWidget {
  const LinkifiedText({
    super.key,
    required this.text,
    this.style,
    this.linkStyle,
  });

  final String text;
  final TextStyle? style;
  final TextStyle? linkStyle;

  static final _urlRegex = RegExp(
    r'(https?:\/\/[^\s]+|www\.[^\s]+)',
    caseSensitive: false,
  );

  Future<void> _openUrl(String value) async {
    var url = value;

    if (url.startsWith('www.')) {
      url = 'https://$url';
    }

    final uri = Uri.tryParse(url);

    if (uri == null) return;

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final matches = _urlRegex.allMatches(text);

    if (matches.isEmpty) {
      return Text(text, style: style);
    }

    final spans = <TextSpan>[];
    var currentPosition = 0;

    for (final match in matches) {
      if (match.start > currentPosition) {
        spans.add(TextSpan(text: text.substring(currentPosition, match.start)));
      }

      final url = match.group(0)!;

      spans.add(
        TextSpan(
          text: url,
          style:
              linkStyle ??
              const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
          recognizer: TapGestureRecognizer()..onTap = () => _openUrl(url),
        ),
      );

      currentPosition = match.end;
    }

    if (currentPosition < text.length) {
      spans.add(TextSpan(text: text.substring(currentPosition)));
    }

    return RichText(
      text: TextSpan(
        style: style ?? DefaultTextStyle.of(context).style,
        children: spans,
      ),
    );
  }
}
