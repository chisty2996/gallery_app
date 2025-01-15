package com.example.gallery_app.gallery_app

import android.os.Build
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(){
    private val CHANNEL = "photo_gallery_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "getSdkVersion") {
                val sdkVersion = Build.VERSION.SDK_INT
                result.success(sdkVersion)
            }
            else if(call.method == "getImages"){
                val images = getAllImages()
                result.success(images)
            }
            else {
                result.notImplemented()
            }
        }
    }

    private fun getAllImages(): List<Map<String, Any>> {
        val images = mutableListOf<Map<String, Any>>()
        val projection = arrayOf(
            MediaStore.Images.Media._ID,
            MediaStore.Images.Media.BUCKET_ID,
            MediaStore.Images.Media.BUCKET_DISPLAY_NAME,
            MediaStore.Images.Media.DATA
        )
        val sortOrder = "${MediaStore.Images.Media.DATE_ADDED} DESC"
        contentResolver.query(
            MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
            projection,
            null,
            null,
            sortOrder
        )?.use { cursor ->
            val idColumn = cursor.getColumnIndexOrThrow(MediaStore.Images.Media._ID)
            val bucketIdColumn = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.BUCKET_ID)
            val bucketNameColumn = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.BUCKET_DISPLAY_NAME)
            val dataColumn = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
            while (cursor.moveToNext()) {
                val imageMap = mutableMapOf<String, Any>()
                imageMap["path"] = cursor.getString(dataColumn)
                imageMap["albumId"] = cursor.getString(bucketIdColumn)
                imageMap["albumName"] = cursor.getString(bucketNameColumn) ?: "Unknown Album"
                images.add(imageMap)
            }
        }
        return images
    }
}
