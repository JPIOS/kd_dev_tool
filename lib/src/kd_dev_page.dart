import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'kd_tool_manager.dart';
import 'dart:math';

/// 显示详情
class KDDevToolAlertPage extends StatefulWidget {
  const KDDevToolAlertPage({super.key});

  @override
  State<KDDevToolAlertPage> createState() => _KDDevToolAlertPageState();
}

class _KDDevToolAlertPageState extends State<KDDevToolAlertPage> {
  double height = 300.0;

  @override
  void initState() {
    KDDevToolManager.callBack = () {
      setState(() {});
    };
    super.initState();
  }

  @override
  void dispose() {
    KDDevToolManager.callBack = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    return Positioned(
        left: 0,
        right: 0,
        bottom: 10,
        child: Container(
          color: Colors.white,
          height: height,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      var copyValue = KDDevToolManager.logList.toString();
                      ClipboardData data = ClipboardData(text: copyValue);
                      Clipboard.setData(data);
                    },
                    child: Container(
                        color: Colors.white,
                        width: 100,
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: const Text("发送/复制")),
                  ),
                  GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        height = screenH - details.globalPosition.dy;
                        height = max(height, 40);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.red.withOpacity(0.3),
                      height: 40,
                      width: 100,
                      child: const Text(
                        "^",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        KDDevToolManager.logList.clear();
                      });
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.white,
                      height: 40,
                      width: 100,
                      child: const Icon(
                        Icons.delete,
                        size: 18,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.separated(
                    itemCount: KDDevToolManager.logList.length,
                    separatorBuilder: (e, index) => const Divider(),
                    itemBuilder: (context, index) {
                      var log = KDDevToolManager.logList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 3),
                        child: Text(log.toString()),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
