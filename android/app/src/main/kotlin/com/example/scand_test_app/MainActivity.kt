package com.example.scand_test_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.example.scand_test_app.monitor.DeviceMonitorPlugin

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        DeviceMonitorPlugin(
            context = applicationContext,
            messenger = flutterEngine.dartExecutor.binaryMessenger
        )
    }
}
