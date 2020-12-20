import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kepler/flutter_kepler.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterKepler.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate:
                      SliverChildBuilderDelegate(_buildItem, childCount: 1),
                ),
              ],
            )));
  }

  Widget _buildItem(BuildContext context, int index) {
    return Center(
      child: Column(children: <Widget>[
        FlatButton(
          child: Text("初始化开普勒"),
          onPressed: () async {
            try {
              // var waite3s = await FlutterAlibc.openItemDetail(itemID: "12345");
              // 如果什么都不给
              var result = await FlutterKepler.initKepler(
                appKey: "0f777b0b8bc2db2c3105394cb3700111",
                appSecret: "eeac919be32c4cdbaaeca71bf8974112",
                appName: "测试"
              );
              FlutterKepler.setKeplerOpenByH5(isOpenByH5: false);
              print(result);
            } on Exception {}
          },
        ),
        FlatButton(
          child: Text("打开Url"),
          onPressed: () {
            FlutterKepler.keplerPageWithURL(
              url: "https://union-click.jd.com/jdc?e=1&p=AyIGZRtfHAQWBFQZXhIyEgZUGFkVAhADUR5fFwEiQwpDBUoyS0IQWhkeHAxcDUQNQlZNGA5OREdcThkNXg9JHUtCCUZVV1hWC1UaWhYAEgdXH18QBhAEQltXYXtiYiJCMFJ2a3szbzhiQWZYLUM%2FdlBUZw1GKHcDekEiUCt8ZUtBHG8TFGZwBilbLHdYd2VUbx1hXXF3NhosQnV7fzNsOGpdZH4PQz9PclRkN3w4QQFueSVEK3F2SFIQbTltYGV0Ml8vfGFiZAxoB2FaZmEiaCBLdk13N28%2FalxxTyJoIHZ5UnNXczxhYWFCIkEvAQBnNyl%2BDn5jU3wAfjBRfXtgHRwLSFlqdxMXVyUAEwZUHl4VBxIBZRtaFAEWDlQdWhAyIgdUKxp7CxMBVx1eJQATBlUfUhILEAFlG1wUBBsAUhJdFQIQBmUbUxEyT1MNUAJBXVtSZStrFjISN2UbWCUBIlk7GggVVxsFBR41T1pNAAIfHk9sEgVTHFITAhI3VxpaFwA%3D",
            );
          },
        ),
        FlatButton(
          child: Text("打开导航页"),
          onPressed: () {
            FlutterKepler.keplerNavigationPage();
          },
        ),
        FlatButton(
          child: Text("通过SKU打开Kepler单品页"),
          onPressed: () {
            FlutterKepler.keplerOpenItemDetailWithSKU(
              sku: "43684925672",
            );
          },
        ),
        FlatButton(
          child: Text("打开订单列表"),
          onPressed: () {
            FlutterKepler.keplerOpenOrderList();
          },
        ),
        FlatButton(
          child: Text("根据搜索关键字打开搜索结果页"),
          onPressed: () {
            FlutterKepler.keplerOpenSearchResult(
              searchKey: "耐克",
            );
          },
        ),
        FlatButton(
          child: Text("打开购物车界面"),
          onPressed: () {
            FlutterKepler.keplerOpenShoppingCart();
          },
        ),
        FlatButton(
          child: Text("添加到购物车（深圳的加车接口）"),
          onPressed: () async {
            var result = await FlutterKepler.keplerAddToCartWithSku(
              sku: "43684925672",
            );
            print(result.errorCode);
          },
        ),
        FlatButton(
          child: Text("单品详情(3.0.0新增(可唤起惊喜APP))"),
          onPressed: () async {
            var result = await FlutterKepler.openJDDetailPage(
              sukId: "43684925672",
            );
            print(result.toString());
          },
        ),
        FlatButton(
          child: Text("联盟一键加购"),
          onPressed: () async {
            var result = await FlutterKepler.keplerFastPurchase(
              unionID: "",
              appID: "",
              skuID: "",
              refer: "",
              subUnionId: ""
            );
            print(result.toString());
          },
        ),
        // FlatButton(
        //   child: Text("静态化检测更新"),
        //   onPressed: () {
        //     FlutterKepler.keplerCheckUpdate();
        //   },
        // ),
        FlatButton(
          child: Text("登录授权"),
          onPressed: () async {
            var result = await FlutterKepler.keplerLogin();
            print(result.errorCode);
          },
        ),
        FlatButton(
          child: Text("取消授权并且清除登录态"),
          onPressed: () {
            FlutterKepler.keplerCancelAuth();
          },
        ),
        // FlatButton(
        //   child: Text("设置进度条颜色"),
        //   onPressed: () {
        //     FlutterKepler.setKeplerProgressBarColor(color: "##e23b41");
        //   },
        // ),
        FlatButton(
          child: Text("判断是否登录"),
          onPressed: () async {
            var result = await FlutterKepler.keplerIsLogin();
            print(result.errorCode);
          },
        ),
        FlatButton(
          child: Text("是否强制用h5打开"),
          onPressed: () {
            FlutterKepler.setKeplerOpenByH5(isOpenByH5: true);
          },
        ),
      ]),
    );
  }
}
