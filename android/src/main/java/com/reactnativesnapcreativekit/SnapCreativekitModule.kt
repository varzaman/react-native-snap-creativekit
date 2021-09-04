package com.reactnativesnapcreativekit

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import com.facebook.react.bridge.*
import com.snapchat.kit.sdk.SnapCreative
import com.snapchat.kit.sdk.creative.media.SnapMediaFactory
import com.snapchat.kit.sdk.creative.media.SnapSticker
import com.snapchat.kit.sdk.creative.models.SnapContent
import com.snapchat.kit.sdk.creative.models.SnapLensContent;
import com.snapchat.kit.sdk.creative.models.SnapLiveCameraContent
import java.io.File
import java.io.FileOutputStream
import java.net.URL

class SnapCreativekitModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String {
      return "SnapCreativekit"
  }

  private fun shareLenses(lensUUID: String, caption: String?, attachmentUrl: String?): SnapLensContent {
    val snap: SnapLensContent = SnapLensContent.createSnapLensContent(lensUUID, null)
    snap.captionText = caption
    snap.attachmentUrl = attachmentUrl

    return snap;
  }

  private fun createSticker(snapFactory: SnapMediaFactory, url: String): SnapSticker? {
    try {
      val file = File(currentActivity?.cacheDir, "sticker.png")
      val uri = URL(url)
      val image = BitmapFactory.decodeStream(uri.openConnection().getInputStream())
      val fileStream = FileOutputStream(file)
      image.compress(Bitmap.CompressFormat.PNG, 100, fileStream)
      fileStream.flush()
      fileStream.close()
      val sticker = snapFactory.getSnapStickerFromFile(file);
      sticker.setHeightDp(image.height.toFloat())
      sticker.setWidthDp(image.width.toFloat())
      return sticker
    } catch (e: Error) {
      throw e;
    }
  }

  private fun shareNonContentSnap(sticker: SnapSticker?, caption: String?, attachmentUrl: String?): SnapLiveCameraContent {
    val snap = SnapLiveCameraContent()
    snap.snapSticker = sticker
    snap.captionText = caption
    snap.attachmentUrl = attachmentUrl

    return snap
  }


  @ReactMethod
  fun shareMedia(url: String?, uuid: String?, options: ReadableMap?, promise: Promise ) {
    try {
      val caption =
        if (options?.hasKey("caption") == true) options.getString("caption") else null
      val attachmentUrl =
        if (options?.hasKey("attachmentUrl") == true) options.getString("attachmentUrl") else null

      val snap: SnapContent
      val snapFactory = currentActivity?.let { SnapCreative.getMediaFactory(it) }
      val api = currentActivity?.let { SnapCreative.getApi(it) }

      snap = if (url != null && snapFactory != null) {
        val sticker = createSticker(snapFactory, url)
        shareNonContentSnap(sticker, caption, attachmentUrl)
      } else if (uuid != null) {
        shareLenses(uuid, caption, attachmentUrl)
      } else {
        shareNonContentSnap(null, null, null)
      }

      api?.send(snap)
      promise.resolve("SUCCESS")
    } catch(e: Exception) {
      promise.reject("CreativeKit Error ", e.localizedMessage)
    }
  }
}
