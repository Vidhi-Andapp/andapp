package com.iand.andapp.andapp;
import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
   /* private String CHANNEL = "enc/dec";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        new MethodChannel(flutterEngine.getDartExecutor(), CHANNEL).setMethodCallHandler(
                (methodCall, result) -> {
                    //MainActivity.this.result = result;
                    if(methodCall.method.equals("encrypt")){
                        String data=methodCall.argument("data");
                        String key=methodCall.argument("key");
                        String cipher= null;
                        try {
                            cipher = CryptoHelper.encrypt(data,key);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        result.success(cipher);
                    }else if(methodCall.method.equals("decrypt")){
                        String data=methodCall.argument("data");
                        String key=methodCall.argument("key");
                        String cipher= null;
                        try {
                            cipher = CryptoHelper.decrypt(data,key);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        result.success(cipher);
                       *//* val jsonString=CryptoHelper.decrypt(data,key);
                        result.success(jsonString);*//*
                    }else{
                        result.notImplemented();
                    }
                }
        );
    }*/
}

