
import 'package:flutter/cupertino.dart';

class TextScaleNormalLayout extends StatelessWidget {

  final Widget child;
  const TextScaleNormalLayout({
    Key? key,
    required this.child,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    return MediaQuery(
        data: data.copyWith(textScaleFactor: 1),
        child: child
    );
  }

}