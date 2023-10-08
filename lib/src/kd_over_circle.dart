import 'package:flutter/material.dart';
import 'kd_tool_manager.dart';

/// 红色浮圈
class KDOVerlayWidget extends StatefulWidget {
  const KDOVerlayWidget({super.key});

  @override
  State<KDOVerlayWidget> createState() => _KDOVerlayWidgetState();
}

class _KDOVerlayWidgetState extends State<KDOVerlayWidget> {
  /// 红色浮圈的位置偏移
  Offset offet = const Offset(10, 80);

  /// 红色浮圈宽高
  final double itemWH = 40.0;

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;

    return Positioned(
      top: offet.dy,
      right: offet.dx,
      child: GestureDetector(
        onDoubleTap: () {
          KDDevToolManager.addOrRemoveDetailOverlay(context);
        },
        onHorizontalDragUpdate: (details) {
          setState(() {
            offet = Offset(
                screenW - details.globalPosition.dx, details.globalPosition.dy);
          });
        },
        onHorizontalDragEnd: (details) {
          bool isLeft = offet.dx < screenW / 2.0;
          setState(() {
            offet = Offset(isLeft ? 10 : screenW - itemWH - 10, offet.dy);
          });
        },
        child: Container(
          width: itemWH,
          height: itemWH,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.red.withOpacity(0.3),
          ),
          child: const Center(
            child: Text(
              "KD",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
