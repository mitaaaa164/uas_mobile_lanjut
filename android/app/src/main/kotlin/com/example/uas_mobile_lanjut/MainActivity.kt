package com.example.uas_mobile_lanjut
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.mita.diginews/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "reverseAndToast") {
                val nim = call.argument<String>("nim")
                
                if (nim != null) {
                    val reversedNim = nim.reversed()
                    
                    Toast.makeText(applicationContext, "NIM Native Kotlin: $reversedNim", Toast.LENGTH_LONG).show()
                    
                    result.success(reversedNim)
                } else {
                    result.error("UNAVAILABLE", "NIM kosong.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}