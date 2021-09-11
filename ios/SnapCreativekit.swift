import SCSDKCreativeKit

@objc(SnapCreativekit)
class SnapCreativekit: NSObject {
    var snapAPI: SCSDKSnapAPI?
    
    override init() {
      snapAPI = SCSDKSnapAPI()
    }

    func createPhoto( url: String) -> SCSDKPhotoSnapContent {
        let photoUrl: URL = URL(string: url)!
        let photo = SCSDKSnapPhoto(imageUrl: photoUrl)
        let photoContent = SCSDKPhotoSnapContent(snapPhoto: photo)
        return photoContent
    }
    
    func createVideo( url: String) -> SCSDKVideoSnapContent {
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
    
    func createNoContent(_ sticker: SCSDKSnapSticker?, _ caption: String?, _ attachmentUrl: String?) -> SCSDKNoSnapContent {
        let snap = SCSDKNoSnapContent()
        
        snap.sticker = sticker
        snap.caption = caption
        snap.attachmentUrl = attachmentUrl
        
        return snap
    }
    
    func createLens (_ lensUUID: String,
                    _ caption: String?,
                    _ attachmentUrl: String?,
                    _ launchData: NSDictionary? ) -> SCSDKLensSnapContent {
        let snap = SCSDKLensSnapContent(lensUUID: lensUUID)
        snap.caption = caption
        snap.attachmentUrl = attachmentUrl
        
        if (launchData != nil) {
            let launchDataBuilder = SCSDKLensLaunchDataBuilder()

            for (key, value) in launchData! {
                launchDataBuilder.addNSStringKeyPair(key as! String, value: value as! String)
            }
            snap.launchData = SCSDKLensLaunchData(builder: launchDataBuilder)
        }
        return snap
    }
    
    @objc
    func shareLens(_ uuid: String,
                   options: [String: String]?,
                   launchData: NSDictionary?,
                   resolver resolve: @escaping RCTPromiseResolveBlock,
                   rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        shareMedia(nil, uuid, options, launchData, resolver: resolve, rejecter: reject)
    }
    
    @objc
    func shareSticker(_ url: String,
                      options: [String: String]?,
                      resolver resolve: @escaping RCTPromiseResolveBlock,
                      rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        shareMedia(url, nil, options, nil, resolver: resolve, rejecter: reject)
    }

    @objc
    func shareMedia(_ url: String?,
                   _ uuid: String?,
                   _ options: [String: String]?,
                   _ launchData: NSDictionary?,
                   resolver resolve: @escaping RCTPromiseResolveBlock,
                   rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        let snap: SCSDKSnapContent;
        let caption = options?["caption"] ?? nil
        let attachmentURL = options?["attachmentUrl"] ?? nil
        
        if (url != nil) {
            let sticker = createSticker(url!)

            snap = createNoContent(sticker, caption, attachmentURL)
            
        } else if (uuid != nil) {
            snap = createLens(uuid!, caption, attachmentURL, launchData)
        }
         else {
            snap = createNoContent(nil, caption, attachmentURL)
        }
                
        DispatchQueue.main.async {
            self.snapAPI?.startSending(snap) { [weak self] (error: Error?) in
                if (error != nil) {
                    reject("Error", "Unknown Error: " + error!.localizedDescription, error)
                } else {
                    resolve(nil);
                }
            }
        }
    }
}
