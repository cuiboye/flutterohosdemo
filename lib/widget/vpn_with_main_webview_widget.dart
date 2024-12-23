import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoduledemo/utils/vpn_with_webview_utils.dart';

class VPNWithMainWebviewWidget extends StatelessWidget {
  final OnTap onTap;
  final BuildContext buildContext;
  const VPNWithMainWebviewWidget({super.key, required this.onTap,required this.buildContext});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.only(left: 20,right: 20),
      child: Column(
        children: [
          Text('hello'),
          Text('hello'),
          Text('hello'),
          Text('hello'),
          Text('hello'),
          Text('hello'),
          Text('hello'),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
            onTap(buildContext);
          }, child: Text('同意'))
        ],
      ),
    );
  }
}
