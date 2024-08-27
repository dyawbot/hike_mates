package com.example.hike_mates
import android.os.Bundle

import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.example.hike_mates/config";

    override fun onCreate(saveInstanceState : Bundle?){
        super.onCreate(saveInstanceState)
        
        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            MethodChannel(messenger, CHANNEL).setMethodCallHandler { call, result ->
                if (call.method == "getStyleKey") {
                    val styleKey = BuildConfig.MAP_STYLE_STRING
                    result.success(styleKey)
                } else {
                    result.notImplemented()
                }
            }
        }
    }
   
}
