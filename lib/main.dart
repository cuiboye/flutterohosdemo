import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:fluttermoduledemo/RouterSettingConfig.dart';

import 'case/counter_demo.dart';
import 'case/hero_animation.dart';
import 'case/media_query.dart';
import 'flutter_page.dart';

void main(List<String> args) {
  PageVisibilityBinding.instance
      .addGlobalObserver(AppGlobalPageVisibilityObserver());
  CustomFlutterBinding();
  runApp(MyApp());
  print('dartEntrypointArgs: $args');
}

class AppGlobalPageVisibilityObserver extends GlobalPageVisibilityObserver {
  @override
  void onPagePush(Route<dynamic> route) {
    Logger.log(
        'boost_lifecycle: AppGlobalPageVisibilityObserver.onPageCreate route:${route.settings.name}');
  }

  @override
  void onPageShow(Route<dynamic> route) {
    Logger.log(
        'boost_lifecycle: AppGlobalPageVisibilityObserver.onPageShow route:${route.settings.name}');
  }

  @override
  void onPageHide(Route<dynamic> route) {
    Logger.log(
        'boost_lifecycle: AppGlobalPageVisibilityObserver.onPageHide route:${route.settings.name}');
  }

  @override
  void onPagePop(Route<dynamic> route) {
    Logger.log(
        'boost_lifecycle: AppGlobalPageVisibilityObserver.onPageDestroy route:${route.settings.name}');
  }

  @override
  void onForeground(Route route) {
    Logger.log(
        'boost_lifecycle: AppGlobalPageVisibilityObserver.onForeground route:${route.settings.name}');
  }

  @override
  void onBackground(Route<dynamic> route) {
    Logger.log(
        'boost_lifecycle: AppGlobalPageVisibilityObserver.onBackground route:${route.settings.name}');
  }
}

class CustomFlutterBinding extends WidgetsFlutterBinding
    with BoostFlutterBinding {}

class CustomInterceptor1 extends BoostInterceptor {
  @override
  void onPrePush(
      BoostInterceptorOption option, PushInterceptorHandler handler) {
    Logger.log('CustomInterceptor#onPrePush1~~~, $option');
    // Add extra arguments
    option.arguments!['CustomInterceptor1'] = "1";
    super.onPrePush(option, handler);
  }

  @override
  void onPostPush(
      BoostInterceptorOption option, PushInterceptorHandler handler) {
    Logger.log('CustomInterceptor#onPostPush1~~~, $option');
    handler.next(option);
  }
}

class CustomInterceptor2 extends BoostInterceptor {
  @override
  void onPrePush(
      BoostInterceptorOption option, PushInterceptorHandler handler) {
    Logger.log('CustomInterceptor#onPrePush2~~~, $option');
    // Add extra arguments
    option.arguments!['CustomInterceptor2'] = "2";
    if (!option.isFromHost! && option.name == "interceptor") {
      handler.resolve(<String, dynamic>{'result': 'xxxx'});
    } else {
      handler.next(option);
    }
  }

  @override
  void onPostPush(
      BoostInterceptorOption option, PushInterceptorHandler handler) {
    Logger.log('CustomInterceptor#onPostPush2~~~, $option');
    handler.next(option);
  }
}

class CustomInterceptor3 extends BoostInterceptor {
  @override
  void onPrePush(
      BoostInterceptorOption option, PushInterceptorHandler handler) {
    Logger.log('CustomInterceptor#onPrePush3~~~, $option');
    // Replace arguments
    // option.arguments = <String, dynamic>{'CustomInterceptor3': '3'};
    handler.next(option);
  }

  @override
  void onPostPush(
      BoostInterceptorOption option, PushInterceptorHandler handler) {
    Logger.log('CustomInterceptor#onPostPush3~~~, $option');
    handler.next(option);
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Route<dynamic>? routeFactory(RouteSettings settings, bool isContainerPage, String? uniqueId) {
    FlutterBoostRouteFactory? func = RouterSettingConfig.getFlutterBoostRouter()[settings.name!];
    if (func == null) {
      return null;
    }
    return func(settings, isContainerPage, uniqueId);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(routeFactory,
        // 如果自定了appBuilder，需要将传入的参数添加到widget层次结构中去，
        // 否则会导致FluttBoost初始化失败。
        // appBuilder: (child) => MaterialApp(
        //       home: child,
        //     ),
        appBuilder: (child) =>MaterialApp(
          home: child,
          debugShowCheckedModeBanner: true,
          ///必须加上builder参数，否则showDialog等会出问题
          builder: (_, __) {
            return child;
          },
        ),

        interceptors: [
          CustomInterceptor1(),
          CustomInterceptor2(),
          CustomInterceptor3(),
        ]);
  }
}
