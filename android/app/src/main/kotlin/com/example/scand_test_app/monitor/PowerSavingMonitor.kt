package com.example.scand_test_app.monitor

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.PowerManager

class PowerSavingMonitor(
    private val context: Context,
    private val onEvent: (Map<String, Any>) -> Unit
) {
    private val powerManager: PowerManager =
        context.getSystemService(Context.POWER_SERVICE) as PowerManager

    private var isRegistered = false

    private val receiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent?.action == PowerManager.ACTION_POWER_SAVE_MODE_CHANGED) {
                emit()
            }
        }
    }

    fun start() {
        if (!isRegistered) {
            val filter = IntentFilter(PowerManager.ACTION_POWER_SAVE_MODE_CHANGED)
            context.registerReceiver(receiver, filter)
            isRegistered = true
        }
        emit()
    }

    fun stop() {
        if (isRegistered) {
            context.unregisterReceiver(receiver)
            isRegistered = false
        }
    }

    fun isEnabled(): Boolean = powerManager.isPowerSaveMode

    private fun emit() {
        onEvent(
            mapOf(
                "type" to "powerSaving",
                "value" to isEnabled()
            )
        )
    }
}
