package com.example.scand_test_app.monitor

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Context.RECEIVER_EXPORTED
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build

class BatteryMonitor(
    private val context: Context,
    private val onEvent: (Map<String, Any>) -> Unit
) {
    private val receiver = object : BroadcastReceiver() {
        override fun onReceive(c: Context?, intent: Intent?) {
            val batteryStatus: Intent? =
                IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { intentFilter ->
                    context.registerReceiver(
                        null,
                        intentFilter
                    )
                }

            val level =
                batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1

            val status =
                batteryStatus?.getIntExtra(BatteryManager.EXTRA_STATUS, -1)

            val chargingState = when (status) {
                BatteryManager.BATTERY_STATUS_CHARGING -> "charging"
                BatteryManager.BATTERY_STATUS_FULL -> "full"
                BatteryManager.BATTERY_STATUS_DISCHARGING -> "not_charging"
                BatteryManager.BATTERY_STATUS_NOT_CHARGING -> "not_charging"
                else -> "unknown"
            }

            onEvent(
                mapOf(
                    "type" to "chargePercent",
                    "value" to level
                )
            )

            onEvent(
                mapOf(
                    "type" to "chargingState",
                    "value" to chargingState
                )
            )
        }
    }

    fun start() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.registerReceiver(
                receiver,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED),
                RECEIVER_EXPORTED
            )
        }
    }

    fun stop() {
        context.unregisterReceiver(receiver)
    }

    fun currentState(): Map<String, Any> {
        val batteryStatus: Intent? =
            IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { intentFilter ->
                context.registerReceiver(
                    null,
                    intentFilter
                )
            }

        val level =
            batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1

        val status =
            batteryStatus?.getIntExtra(BatteryManager.EXTRA_STATUS, -1)

        val chargingState = when (status) {
            BatteryManager.BATTERY_STATUS_CHARGING -> "charging"
            BatteryManager.BATTERY_STATUS_FULL -> "full"
            BatteryManager.BATTERY_STATUS_DISCHARGING -> "not_charging"
            BatteryManager.BATTERY_STATUS_NOT_CHARGING -> "not_charging"
            else -> "unknown"
        }
        return mapOf(
            "chargePercent" to level,
            "chargingState" to chargingState
        )
    }
}