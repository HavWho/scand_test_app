package com.example.scand_test_app.monitor

import android.bluetooth.BluetoothAdapter
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build

class BluetoothMonitor(
    private val context: Context,
    private val onEvent: (Map<String, Any>) -> Unit,
) {

    private val adapter: BluetoothAdapter? =
        BluetoothAdapter.getDefaultAdapter()

    private var lastState: String? = null

    private val receiver = object : BroadcastReceiver() {
        override fun onReceive(c: Context?, intent: Intent?) {
            if (intent?.action != BluetoothAdapter.ACTION_STATE_CHANGED) return

            val state = intent.getIntExtra(
                BluetoothAdapter.EXTRA_STATE,
                BluetoothAdapter.ERROR
            )

            val newState = when (state) {
                BluetoothAdapter.STATE_ON -> "on"
                BluetoothAdapter.STATE_OFF -> "off"
                BluetoothAdapter.STATE_TURNING_ON -> "turning_on"
                BluetoothAdapter.STATE_TURNING_OFF -> "turning_off"
                else -> "unknown"
            }

            emitIfChanged(newState)
        }
    }

    fun start() {
        val filter = IntentFilter(BluetoothAdapter.ACTION_STATE_CHANGED)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            context.registerReceiver(receiver, filter, Context.RECEIVER_EXPORTED)
        } else {
            context.registerReceiver(receiver, filter)
        }

        emitIfChanged(getCurrentState())
    }

    fun stop() {
        runCatching {
            context.unregisterReceiver(receiver)
        }
    }

    fun currentState(): Map<String, Any> =
        mapOf("state" to getCurrentState())

    private fun getCurrentState(): String =
        when {
            adapter == null -> "unavailable"
            adapter.isEnabled -> "on"
            else -> "off"
        }

    private fun emitIfChanged(newState: String) {
        if (newState == lastState) return
        lastState = newState

        onEvent(
            mapOf(
                "type" to "bluetooth",
                "value" to newState
            )
        )
    }
}