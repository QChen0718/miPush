
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPluginMipush {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_mipush');

  // static Future<String> get platformVersion async {
  //   final String version = await _channel.invokeMethod('getPlatformVersion');
  //   return version;
  // }
  static init() async{
    await _channel.invokeMethod("init");
  }
  static setLoginIn({String userId}) async{
    await _channel.invokeMethod("loginIn",{
      "userId":userId
    });
  }
  static setLoginOut({int userId}) async{
    await _channel.invokeMethod("loginOut",{
      "userId":userId
    });
  }
}
