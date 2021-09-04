import SCSDKCreativeKit

@objc(SnapCreativekit)
class SnapCreativekit: NSObject {
    var snapAPI: SCSDKSnapAPI?
    
    override init() {
      snapAPI = SCSDKSnapAPI()
    }
    
    @objc(multiply:withB:withResolver:withRejecter:)
    func multiply(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        resolve(a*b)
    }

    func sharePhoto( url: String) -> SCSDKPhotoSnapContent {
        let photoUrl: URL = URL(string: url)!
        let photo = SCSDKSnapPhoto(imageUrl: photoUrl)
        let photoContent = SCSDKPhotoSnapContent(snapPhoto: photo)
        return photoContent
    }
    
    func shareVideo( url: String) -> SCSDKVideoSnapContent {
        let videoUrl: URL = URL(string: url)!
        let video = SCSDKSnapVideo(videoUrl: videoUrl)
        let videoContent = SCSDKVideoSnapContent(snapVideo: video)
        return videoContent
    }
    
    func createSticker(_ url: String) -> SCSDKSnapSticker {
        let stickerImageUrl: URL = URL(string: url)!
        let sticker = SCSDKSnapSticker(stickerUrl: stickerImageUrl, isAnimated: false);

        return sticker
    }
    
    func shareNoContent(_ sticker: SCSDKSnapSticker?, _ caption: String?, _ attachmentUrl: String?) -> SCSDKNoSnapContent {
        let snap = SCSDKNoSnapContent()
        
        snap.sticker = sticker
        snap.caption = caption
        snap.attachmentUrl = attachmentUrl
        
        return snap
    }
    
    func shareLens (_ lensUUID: String, _ caption: String?, _ attachmentUrl: String?) -> SCSDKLensSnapContent {
        let snap = SCSDKLensSnapContent(lensUUID: lensUUID)
        snap.caption = caption
        snap.attachmentUrl = attachmentUrl
        
        return snap
    }

    @objc
    func shareMedia(_ url: String?, uuid: String?, options: [String: String]?,
                    resolver resolve: @escaping RCTPromiseResolveBlock,
                    rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        let snap: SCSDKSnapContent;
        let caption = options?["caption"] ?? nil
        let attachmentURL = options?["attachmentUrl"] ?? nil
        
        if (url != nil) {
            let sticker = createSticker(url!)

            snap = shareNoContent(sticker, caption, attachmentURL)
            
        } else if (uuid != nil) {
            snap = shareLens(uuid!, caption, nil)
        }
         else {
            snap = shareNoContent(nil, caption, attachmentURL)
        }
                
        DispatchQueue.main.async {
            self.snapAPI?.startSending(snap) { [weak self] (error: Error?) in
                if (error != nil) {
                    print(error)
                    reject("Error", "Unknown Error", error)
                } else {
                    resolve(nil);
                }
            }
        }
    }
}
