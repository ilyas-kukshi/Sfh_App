package com.nexsolve.sfh

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.net.Uri.*
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val upiChannel = "upi_payment/init";

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Register the method channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, upiChannel).setMethodCallHandler { call, result ->
            if (call.method == "init") {
                val upiLink = call.argument<String>("upiLink")
                println(upiLink);
                if (upiLink != null) {
                    initiateUpiPayment(this@MainActivity, upiLink)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "UPI link not provided", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun initiateUpiPayment(context: Context, upiLink: String) {
        try {
            val uri = parse(upiLink)
            val intent = Intent(Intent.ACTION_VIEW, uri)
            if (intent.resolveActivity(context.packageManager) != null) {
                context.startActivity(intent)
            } else {
                // Handle the case where no UPI app is available
                // You may want to prompt the user to install a UPI app
                println("No upi app found")
                Toast.makeText(context, "No UPI app found", Toast.LENGTH_SHORT).show()
            }
        } catch (e: Exception) {
            // Handle any exceptions, e.g., UPI app not installed
            e.printStackTrace()
        }
    }
}
