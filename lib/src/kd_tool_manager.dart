import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'kd_dev_page.dart';
import 'kd_over_circle.dart';

class KDDevToolManager {
  /// 打印列表
  static final List<Object> logList = [];

  /// log回调
  static Function()? callBack;

  /// 红色浮圈
  static OverlayEntry? detail;

  /// 是否显示红色浮圈
  static bool isShowDetail = false;

  /// 初始化devTool
  static start(Dio dio,
      {bool isRelease = false, required GlobalKey<NavigatorState> key}) {
    if (isRelease) return;

    dio.interceptors.add(LogInterceptor(
      request: false,
      requestHeader: false,
      responseHeader: false,
      requestBody: true,
      responseBody: true,
      logPrint: (object) {
        logList.add(object);
        callBack?.call();
      },
    ));

    Future.delayed(const Duration(seconds: 5))
        .then((value) => insertOverlay(key));
  }

  /// 在当前窗口添加红色浮圈
  static insertOverlay(GlobalKey<NavigatorState> key) {
    Overlay.of(key.currentContext!).insert(OverlayEntry(
      builder: (context) {
        return const KDOVerlayWidget();
      },
    ));
  }

  /// 添加或者移除红色浮圈
  static addOrRemoveDetailOverlay(BuildContext context) {
    if (isShowDetail) {
      detail!.remove();
      isShowDetail = false;
      return;
    }

    detail ??= OverlayEntry(builder: (context) {
      return const KDDevToolAlertPage();
    });
    isShowDetail = true;
    Overlay.of(context).insert(detail!);
  }
}
