package com.nosh.cricklyzer

import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.cricklyzer.permissions"
    private val STORAGE_PERMISSION_REQUEST = 100
    private val CAMERA_PERMISSION_REQUEST = 101

    private lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "requestStoragePermission" -> {
                    requestStoragePermission(result)
                }
                "checkStoragePermission" -> {
                    result.success(checkStoragePermission())
                }
                "requestCameraPermission" -> {
                    requestCameraPermission(result)
                }
                "checkCameraPermission" -> {
                    result.success(checkCameraPermission())
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun checkStoragePermission(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            // Android 13+ uses READ_MEDIA_IMAGES for images
            ContextCompat.checkSelfPermission(this, Manifest.permission.READ_MEDIA_IMAGES) == PackageManager.PERMISSION_GRANTED
        } else {
            // Android 12 and below use READ_EXTERNAL_STORAGE
            ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED
        }
    }

    private fun requestStoragePermission(result: MethodChannel.Result) {
        if (checkStoragePermission()) {
            result.success(true)
            return
        }

        val permission = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            Manifest.permission.READ_MEDIA_IMAGES
        } else {
            Manifest.permission.READ_EXTERNAL_STORAGE
        }

        ActivityCompat.requestPermissions(this, arrayOf(permission), STORAGE_PERMISSION_REQUEST)
        // Store result for later callback
        pendingResult = result
    }

    private fun checkCameraPermission(): Boolean {
        return ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED
    }

    private fun requestCameraPermission(result: MethodChannel.Result) {
        if (checkCameraPermission()) {
            result.success(true)
            return
        }

        ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.CAMERA), CAMERA_PERMISSION_REQUEST)
        // Store result for later callback
        pendingCameraResult = result
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        when (requestCode) {
            STORAGE_PERMISSION_REQUEST -> {
                val granted = grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED
                pendingResult?.success(granted)
                pendingResult = null
            }
            CAMERA_PERMISSION_REQUEST -> {
                val granted = grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED
                pendingCameraResult?.success(granted)
                pendingCameraResult = null
            }
        }
    }

    companion object {
        private var pendingResult: MethodChannel.Result? = null
        private var pendingCameraResult: MethodChannel.Result? = null
    }
}
