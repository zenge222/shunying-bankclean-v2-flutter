import 'dart:io';

import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:bank_clean_flutter/pages/common/login/Login.dart';
import 'package:bank_clean_flutter/provides/backAssessment.dart';
import 'package:bank_clean_flutter/provides/materialApply.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/PickerLocalizationsDelegate.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provide/provide.dart';
import 'pages/common/splash/Splash.dart';

/// 利用GlobalKey 处理登录失效
class Router {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  await AmapLocation.instance.init(iosKey: 'd5bc5c8a592d0495dfb8fc2269bc6ba4');
  await AmapCore.init('d5bc5c8a592d0495dfb8fc2269bc6ba4');
  var providers = Providers();
  providers..provide(
      Provider<MaterialApplyProvide>.value(MaterialApplyProvide()))..provide(
      Provider<BackAssessmentProvide>.value(BackAssessmentProvide()));

  runApp(ProviderNode(child: MyApp(), providers: providers));

  ///状态栏透明
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,

    ///这是设置状态栏的图标和字体的颜色
    ///Brightness.light  一般都是显示为白色
    ///Brightness.dark 一般都是显示为黑色
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///初始化路由
    final router = FluroRouter();

    ///注册各个路由
    Routers.configureRouters(router);

    ///赋值到静态对象方便调用
    Application.router = router;
    /* 使用AnnotatedRegion包裹Scaffold，可以使得状态栏颜色改变，有dark和light两种 */
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
//      child: Material(
      child: MaterialApp(
        // 处理token失效设置
        navigatorKey: Router.navigatorKey,
        routes: {'/login': (ctx) => LoginPage()},
        /* debug的图标 */
        debugShowCheckedModeBanner: false,
        title: '金洁士',
        /* 多语言代理 */
        localizationsDelegates: [
          PickerLocalizationsDelegate.delegate, // 如果要使用本地化，请添加此行，则可以显示中文按钮
//        GlobalMaterialLocalizations.delegate,
//        GlobalWidgetsLocalizations.delegate,
        ],
        /* 主题 */
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          /* 当键盘显示 是否重新布局来避免底部被覆盖 默认值为 true */
          resizeToAvoidBottomPadding: false,
          body: SplashPage(),
        ),
      ),
//      ),
    );
  }
}
