package com.wxwx.flutter_kepler;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterKeplerPlugin */
public class FlutterKeplerPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {

  private static com.wxwx.flutter_kepler.FlutterKeplerHandle handle;
  private static MethodChannel channel;
  private FlutterPluginBinding flutterPluginBinding;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    handle = FlutterKeplerHandle.getInstance(registrar.activity());
    channel = new MethodChannel(registrar.messenger(), "flutter_kepler");
    channel.setMethodCallHandler(new FlutterKeplerPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }else if(call.method.equals("initKepler")){
      handle.initKepler(call, result);
    }else if(call.method.equals("keplerLogin")){
      handle.keplerLogin(result);
    }else if(call.method.equals("keplerIsLogin")){
      handle.keplerIsLogin(call, result);
    }else if(call.method.equals("keplerCancelAuth")){
      handle.keplerCancelAuth(call, result);
    } else if(call.method.equals("keplerPageWithURL")){
      handle.openJDUrlPage(call, result);
    } else if(call.method.equals("keplerNavigationPage")){
      handle.keplerNavigationPage(call, result);
    } else if(call.method.equals("keplerOpenItemDetailWithSKU")){
      handle.keplerOpenItemDetail(call, result);
    } else if(call.method.equals("keplerOpenOrderList")){
      handle.keplerOpenOrderList(call, result);
    } else if(call.method.equals("keplerOpenSearchResult")){
      handle.keplerOpenSearchResult(call, result);
    }  else if(call.method.equals("keplerOpenShoppingCart")){
      handle.keplerOpenShoppingCart(call, result);
    } else if(call.method.equals("keplerAddToCartWithSku")){
      handle.keplerAddToCartWithSku(call, result);
    } else if(call.method.equals("keplerFastPurchase")){
      handle.keplerFastPurchase(call, result);
    } else if(call.method.equals("keplerCheckUpdate")){
      handle.keplerCheckUpdate(call, result);
    } else if(call.method.equals("setKeplerProgressBarColor")){
      handle.setKeplerProgressBarColor(call, result);
    } else if(call.method.equals("setKeplerOpenByH5")){
      handle.setKeplerOpenByH5(call, result);
    } else if(call.method.equals("setKeplerJDappBackTagID")){
      handle.setKeplerJDappBackTagID(call, result);
    } else if(call.method.equals("openJDDetailPage")){
      handle.openJDDetailPage(call, result);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    this.flutterPluginBinding = binding;
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    flutterPluginBinding = null;
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    handle = FlutterKeplerHandle.getInstance(binding.getActivity());
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_kepler");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }
}
