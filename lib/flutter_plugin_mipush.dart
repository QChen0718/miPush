
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPluginMipush {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_mipush');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  static init() async{
    await _channel.invokeMethod("init");
  }
  /// 传递 类型的参数
  static Future<String> sendMiPushData(String app_id, String app_key,String user_phone) async {
    Map<String, String> params = Map<String, String>();
    params['app_id'] = app_id;
    params['app_key'] = app_key;
    params['user_phone'] = user_phone;
    return await _channel.invokeMethod("sendMiPushData", params);
  }
  // 添加别名
  static Future<String> setAliasName(String aliasName) async{
    return await _channel.invokeMethod("setAliasName",{
      'userId':aliasName
    });
  }
  // 删除别名
  static Future<String> unAliasName(String aliasName) async{
    return await _channel.invokeMethod("unAliasName",{
      'userId':aliasName
    });
  }
}
