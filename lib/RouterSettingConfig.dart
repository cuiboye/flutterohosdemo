import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

import 'case/counter_demo.dart';
import 'case/hero_animation.dart';
import 'case/media_query.dart';
import 'flutter_page.dart';

///Router配置信息
class RouterSettingConfig{
  static Map<String,FlutterBoostRouteFactory> getFlutterBoostRouter(){
    return {
      'counter': (settings,isContainerPage, uniqueId) {
        return PageRouteBuilder<dynamic>(
            settings: settings,
            pageBuilder: (_, __, ___) =>
            const CounterPage(title: "Counter Demo"));
      },
      'hero_animation': (settings, isContainerPage,uniqueId) {
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HeroAnimation());
      },
      'mediaquery': (settings,isContainerPage, uniqueId) {
        return PageRouteBuilder<dynamic>(
            settings: settings,
            pageBuilder: (_, __, ___) => MediaQueryRouteWidget(
              params: settings.arguments as Map<dynamic, dynamic>?,
              uniqueId: uniqueId,
            ));
      },

      ///可以在native层通过 getContainerParams 来传递参数
      'flutterPage': (settings,isContainerPage, uniqueId) {
        debugPrint('flutterPage settings:$settings, uniqueId:$uniqueId');
        return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) => FlutterIndexRoute(
            params: settings.arguments as Map<dynamic, dynamic>?,
            uniqueId: uniqueId,
          ),
          // transitionsBuilder: (BuildContext context, Animation<double> animation,
          //     Animation<double> secondaryAnimation, Widget child) {
          //   return SlideTransition(
          //     position: Tween<Offset>(
          //       begin: const Offset(1.0, 0),
          //       end: Offset.zero,
          //     ).animate(animation),
          //     child: SlideTransition(
          //       position: Tween<Offset>(
          //         begin: Offset.zero,
          //         end: const Offset(-1.0, 0),
          //       ).animate(secondaryAnimation),
          //       child: child,
          //     ),
          //   );
          // },
        );
      },
    };
  }
}