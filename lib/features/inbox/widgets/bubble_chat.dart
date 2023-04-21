import 'package:flutter/material.dart';

import '../../../common/is_dark.dart';
import '../../../constants/sizes.dart';

class BubbleShape extends CustomPainter {
  final Color color;

  const BubbleShape({Key? key, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final bubbleSize = Size(size.width, size.height * 0.8);
    final fillet = bubbleSize.width * 0.03;
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(bubbleSize.width, bubbleSize.height - fillet)
      ..quadraticBezierTo(bubbleSize.width + 1.4 * fillet,
          bubbleSize.height + 2.0, bubbleSize.width - fillet, bubbleSize.height)
      ..lineTo(fillet, bubbleSize.height)
      ..quadraticBezierTo(0, bubbleSize.height, 0, bubbleSize.height - fillet)
      ..lineTo(0, fillet)
      ..quadraticBezierTo(0, 0, fillet, 0)
      ..lineTo(bubbleSize.width - fillet, 0)
      ..quadraticBezierTo(bubbleSize.width, 0, bubbleSize.width, fillet)
      ..lineTo(bubbleSize.width, fillet);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BubbleChat extends StatefulWidget {
  const BubbleChat({Key? key, required this.textEditingController})
      : super(key: key);

  final TextEditingController textEditingController;

  @override
  State<BubbleChat> createState() => _BubbleChatState();
}

class _BubbleChatState extends State<BubbleChat> {
  final _scrollController = ScrollController();

  void _onChange() {
    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent,
    );
  }

  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(_onChange);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onChange);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Expanded(
      child: Stack(
        children: [
          CustomPaint(
            painter: BubbleShape(
                color: isDark ? Colors.grey.shade600 : Colors.white),
            child: Container(height: 60.0),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size10,
              ),
              child: SizedBox(
                height: 45.0,
                child: TextField(
                  controller: widget.textEditingController,
                  minLines: null,
                  maxLines: null,
                  expands: true,
                  scrollController: _scrollController,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "Send a message..."),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
