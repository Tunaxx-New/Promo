import 'package:flutter/material.dart';
import 'package:promo/core/getAppInfo.dart';

class AppVersionText extends StatelessWidget {
  const AppVersionText({
    super.key,
    this.padding = const EdgeInsets.only(top: 24),
    this.textAlign = TextAlign.center,
  });

  final EdgeInsetsGeometry padding;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getAppInfo(context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: padding,
          child: Text(
            snapshot.data!,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        );
      },
    );
  }
}
