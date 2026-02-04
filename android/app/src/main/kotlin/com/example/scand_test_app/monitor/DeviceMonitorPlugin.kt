package com.example.scand_test_app.monitor

import android.content.Context
import android.os.Build
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class DeviceMonitorPlugin(
    private val context: Context,
    messenger: BinaryMessenger
) : MethodChannel.MethodCallHandler, EventChannel.StreamHandler {

    private val methodChannel =
        MethodChannel(messenger, "scand_mobile_monitor/methods")

    private val eventChannel =
        EventChannel(messenger, "scand_mobile_monitor/events")

    init {
        methodChannel.setMethodCallHandler(this)
        eventChannel.setStreamHandler(this)
    }

    private var eventSink: EventChannel.EventSink? = null

    private val batteryMonitor = BatteryMonitor(context) { event ->
        sendEvent(event)
    }

    private val networkMonitor = NetworkMonitor(context) { event ->
        sendEvent(event)
    }

    private val powerSavingMonitor = PowerSavingMonitor(context) { event ->
        sendEvent(event)
    }

    private val bluetoothMonitor = BluetoothMonitor(context) { event ->
        sendEvent(event)
    }

    init {
        methodChannel.setMethodCallHandler(this)
        eventChannel.setStreamHandler(this)
    }

    // -----------------------------
    // MethodChannel
    // -----------------------------


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {

            "getDeviceInfo" -> {
                result.success(getDeviceInfo())
            }

            "getCurrentState" -> {
                result.success(getCurrentStateSnapshot())
            }

            "startMonitoring" -> {
                startMonitoring()
                result.success(null)
            }

            "stopMonitoring" -> {
                stopMonitoring()
                result.success(null)
            }

            else -> result.notImplemented()
        }
    }

    // -----------------------------
    // EventChannel
    // -----------------------------

    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    private fun sendEvent(event: Map<String, Any>) {
        eventSink?.success(event)
    }

    // -----------------------------
    // Monitoring
    // -----------------------------

    private fun startMonitoring() {
        batteryMonitor.start()
        networkMonitor.start()
        powerSavingMonitor.start()
        bluetoothMonitor.start()
    }

    private fun stopMonitoring() {
        batteryMonitor.stop()
        networkMonitor.stop()
        powerSavingMonitor.stop()
        bluetoothMonitor.stop()
    }

    // -----------------------------
    // Snapshot
    // -----------------------------

    private fun getDeviceInfo(): Map<String, Any> =
        mapOf(
            "vendor" to Build.MANUFACTURER,
            "model" to Build.MODEL,
            "osName" to "Android",
            "osVersion" to Build.VERSION.RELEASE
        )

    private fun getCurrentStateSnapshot(): Map<String, Any> =
        mapOf(
            "deviceInfo" to getDeviceInfo(),
            "battery" to batteryMonitor.currentState(),
            "network" to networkMonitor.currentState(),
            "powerSaving" to powerSavingMonitor.isEnabled(),
            "bluetooth" to bluetoothMonitor.currentState()
        )
}