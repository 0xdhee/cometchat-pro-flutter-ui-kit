import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_kit/flutter_chat_ui_kit.dart';

///Gives Full Screen image view for passed [messageObject]
class ImageViewer extends StatelessWidget {
  const ImageViewer({
    Key? key,
    required this.messageObject,
    this.backIconColor,
    this.backgroundColor,
  }) : super(key: key);

  final MediaMessage messageObject;

  final Color? backIconColor;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor ?? const Color(0xffFFFFFF),
        iconTheme:
            IconThemeData(color: backIconColor ?? const Color(0xff3399FF)),
      ),
      backgroundColor: backgroundColor ?? const Color(0xffFFFFFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: InteractiveViewer(
              maxScale: 5,
              minScale: 1,
              child: Center(
                child: Image.network(
                  messageObject.attachment!.fileUrl,
                  errorBuilder: (context, object, stackTrace) {
                    return const Center(child: Text("Failed To Load Image"));
                  },
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
