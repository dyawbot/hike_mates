package com.carpediemadv.hike_mates
import android.os.Bundle
import android.util.Log

import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.carpediemadv.hike_mates/config";

    override fun onCreate(saveInstanceState : Bundle?){
        super.onCreate(saveInstanceState)
        Log.d("MainActivity", "FlutterActivity created")
        
        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            MethodChannel(messenger, CHANNEL).setMethodCallHandler { call, result ->
                Log.d("MainActivity", "MethodChannel invoked: ${call.method}")
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
