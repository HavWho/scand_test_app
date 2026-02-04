package com.example.scand_test_app.monitor

import android.bluetooth.BluetoothAdapter
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Context.RECEIVER_EXPORTED
import android.content.Intent
import android.content.IntentFilter
import android.os.Build

class BluetoothMonitor(
    private val context: Context,
    private val onEvent: (Map<String, Any>) -> Unit,
) {

    private val receiver = object : BroadcastReceiver() {
        override fun onReceive(c: Context?, intent: Intent?) {
            when (intent?.action) {
                BluetoothAdapter.ACTION_STATE_CHANGED -> {
                    val state = intent.getIntExtra(
                        BluetoothAdapter.EXTRA_STATE,
                        BluetoothAdapter.ERROR,
                    )

                    val value = when (state) {
                        BluetoothAdapter.STATE_ON -> "on"
                        BluetoothAdapter.STATE_OFF -> "off"
                        BluetoothAdapter.STATE_TURNING_ON -> "turning_on"
                        BluetoothAdapter.STATE_TURNING_OFF -> "turning_off"
                        BluetoothAdapter.STATE_CONNECTING -> "connecting"
                        BluetoothAdapter.STATE_CONNECTED -> "connected"
                        else -> "unknown"
                    }

                    onEvent(
                        mapOf(
                            "type" to "bluetooth",
                            "value" to value
                        )
                    )
                }
            }
        }
    }
    private val adapter: BluetoothAdapter? =
        BluetoothAdapter.getDefaultAdapter()

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

    fun currentState(): Map<String, Any> =
        mapOf(
            "state" to when {
                adapter == null -> "unavailable"
                adapter.isEnabled -> "on"
                else -> "off"
            }
        )

    private fun emit() {
        onEvent(
            mapOf(
                "type" to "bluetooth",
                "value" to currentState()["state"]!!
            )
        )
    }
}