package com.example.kortobaa_ecommerce

import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    private val CHANNEL = "order_methods"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "confirmOrder") {

                val paymentUrl : String? = call.argument<String>("paymentUrl");

                val openURL = Intent(Intent.ACTION_VIEW)
                openURL.data = Uri.parse(paymentUrl)
                startActivity(openURL)
            } else {
                result.notImplemented()
            }
        }
    }


}
