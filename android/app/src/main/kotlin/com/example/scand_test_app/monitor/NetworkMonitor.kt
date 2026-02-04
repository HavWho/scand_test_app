package com.example.scand_test_app.monitor

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities

class NetworkMonitor(
    private val context: Context,
    private val onEvent: (Map<String, Any>) -> Unit
) {
    private val cm =
        context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

    private val callback = object : ConnectivityManager.NetworkCallback() {
        override fun onAvailable(network: Network) = emit()
        override fun onLost(network: Network) = emit()
    }

    fun start() {
        cm.registerDefaultNetworkCallback(callback)
        emit()
    }

    fun stop() {
        cm.unregisterNetworkCallback(callback)
    }

    private fun emit() {
        val caps = cm.getNetworkCapabilities(cm.activeNetwork)

        val value = mapOf(
            "isOnline" to (caps != null),
            "type" to when {
                caps?.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) == true -> "wifi"
                caps?.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) == true -> "cellular"
                else -> "unknown"
            }
        )

        onEvent(
            mapOf(
                "type" to "network",
                "value" to value
            )
        )
    }

    fun currentState(): Map<String, Any> {
        val caps = cm.getNetworkCapabilities(cm.activeNetwork)
        return mapOf(
            "isOnline" to (caps != null),
            "type" to when {
                caps?.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) == true -> "wifi"
                caps?.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) == true -> "cellular"
                else -> "unknown"
            }
        )
    }
}