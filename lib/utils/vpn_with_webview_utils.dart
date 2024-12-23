import 'package:flutter/material.dart';

import '../widget/vpn_with_main_webview_widget.dart';

typedef OnTap =  Function(BuildContext context);
/// 弹框工具类
class VPNWithWebviewUtils{
  static Future<void> showMainPrivacyDialog(BuildContext buildContext,String fileName,OnTap onTap) {
    return showYDCDialog(
        context: buildContext,
        builder: (BuildContext context) {
          return VPNWithMainWebviewWidget(onTap: onTap,buildContext: buildContext,);
        });
  }

  static Future<T?> showYDCDialog<T>({
    required BuildContext context,
    bool barrierDismissible = false,
    required WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(child: builder(context)),
              ));
        });
  }
}