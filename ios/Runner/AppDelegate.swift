import Flutter
import UIKit
import Photos

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: "photo_gallery_channel",
            binaryMessenger: controller.binaryMessenger
        )
        channel.setMethodCallHandler { call, result in
            switch call.method {
            case "getAlbums":
                self.getAlbums(result: result)
            case "getHighQualityImage":
                guard let assetId = call.arguments as? String else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Asset ID required", details: nil))
                    return
                }
                self.getHighQualityImage(assetId: assetId, result: result)
            case "getPhotosInAlbum":
                if let args = call.arguments as? [String: Any],
                   let albumId = args["albumId"] as? String {
                    self.getPhotosInAlbum(albumId: albumId, result: result)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS",
                                      message: "Album ID is required",
                                      details: nil))
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    private func getAlbums(result: @escaping FlutterResult) {
        let fetchOptions = PHFetchOptions()
        
        let userAlbums = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .any,
            options: fetchOptions
        )
        let smartAlbums = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .any,
            options: fetchOptions
        )
        
        var albumsList: [[String: Any]] = []
        
        userAlbums.enumerateObjects { collection, index, stop in
            if let title = collection.localizedTitle {
                albumsList.append([
                    "id": collection.localIdentifier,
                    "name": title
                ])
            }
        }
        
        smartAlbums.enumerateObjects { collection, index, stop in
            if let title = collection.localizedTitle {
                albumsList.append([
                    "id": collection.localIdentifier,
                    "name": title
                ])
            }
        }
        
        print("Total albums fetched: \(albumsList.count)")
        result(albumsList)
    }
    
    private func getPhotosInAlbum(albumId: String, result: @escaping FlutterResult) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        guard let collection = PHAssetCollection.fetchAssetCollections(
            withLocalIdentifiers: [albumId],
            options: nil
        ).firstObject else {
            result(FlutterError(code: "ALBUM_NOT_FOUND", message: "Album not found", details: nil))
            return
        }

        let assets = PHAsset.fetchAssets(in: collection, options: fetchOptions)
        var photosList: [[String: Any]] = []
        photosList.reserveCapacity(assets.count)
        
        let imageManager = PHCachingImageManager()
        
        // Configure thumbnail size
        let scale = UIScreen.main.scale
        let thumbnailSize = CGSize(width: 200 * scale, height: 200 * scale)
        
        // Start caching thumbnails for visible range
        imageManager.startCachingImages(for: assets.objects(at: IndexSet(0..<min(assets.count, 50))),
                                      targetSize: thumbnailSize,
                                      contentMode: .aspectFill,
                                      options: nil)
        
        let thumbnailOptions = PHImageRequestOptions()
        thumbnailOptions.isNetworkAccessAllowed = true
        thumbnailOptions.deliveryMode = .fastFormat
        thumbnailOptions.isSynchronous = true
        thumbnailOptions.resizeMode = .fast
        
        let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let thumbnailCacheDirectory = cachesDirectory.appendingPathComponent("ThumbnailCache")
        
        try? FileManager.default.createDirectory(at: thumbnailCacheDirectory,
                                               withIntermediateDirectories: true)
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "com.yourapp.photoProcessing", qos: .userInitiated)
        
        queue.async {
            autoreleasepool {
                assets.enumerateObjects { (asset, index, stop) in
                    autoreleasepool {
                        group.enter()
                        
                        // Create thumbnail cache filename
                        let thumbnailFileName = "thumb_\(asset.localIdentifier)"
                            .replacingOccurrences(of: "/", with: "_")
                            .replacingOccurrences(of: "-", with: "_")
                        let thumbnailURL = thumbnailCacheDirectory
                            .appendingPathComponent("\(thumbnailFileName).jpg")
                        
                        // Check if thumbnail already exists
                        if !FileManager.default.fileExists(atPath: thumbnailURL.path) {
                            imageManager.requestImage(
                                for: asset,
                                targetSize: thumbnailSize,
                                contentMode: .aspectFill,
                                options: thumbnailOptions
                            ) { image, info in
                                if let image = image,
                                   let data = image.jpegData(compressionQuality: 0.7) {
                                    try? data.write(to: thumbnailURL)
                                }
                            }
                        }
                        
                        let photoInfo: [String: Any] = [
                            "id": asset.localIdentifier,
                            "path": thumbnailURL.path,  // Path to cached thumbnail
                            "creationDate": asset.creationDate?.timeIntervalSince1970 ?? 0,
                            "width": asset.pixelWidth,
                            "height": asset.pixelHeight
                        ]
                        
                        photosList.append(photoInfo)
                        group.leave()
                    }
                }
            }
            
            group.wait()
            DispatchQueue.main.async {
                print("photos list length:", photosList.count)
                result(photosList)
            }
        }
    }

    // Clean old thumbnail cache files (call this periodically or on app launch)
    private func cleanOldThumbnailCache() {
        let fileManager = FileManager.default
        guard let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        let thumbnailCacheDirectory = cachesDirectory.appendingPathComponent("ThumbnailCache")
        
        guard let files = try? fileManager.contentsOfDirectory(
            at: thumbnailCacheDirectory,
            includingPropertiesForKeys: [.creationDateKey]
        ) else { return }
        
        let oldDate = Date().addingTimeInterval(-7 * 24 * 3600) // 7 days old
        
        for file in files {
            guard let attributes = try? fileManager.attributesOfItem(atPath: file.path),
                  let creationDate = attributes[.creationDate] as? Date,
                  creationDate < oldDate else { continue }
            
            try? fileManager.removeItem(at: file)
        }
    }

    // Method for loading high quality image remains the same
    private func getHighQualityImage(assetId: String, result: @escaping FlutterResult) {
        print("asset id", assetId)
        guard let asset = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil).firstObject else {
            result(FlutterError(code: "ASSET_NOT_FOUND", message: "Asset not found", details: nil))
            return
        }
        
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .highQualityFormat
        options.version = .current
        options.isSynchronous = false // Async for large images
        
        if #available(iOS 13, *) {
            PHImageManager.default().requestImageDataAndOrientation(
                for: asset,
                options: options
            ) { (imageData, dataUTI, orientation, info) in
                guard let data = imageData else {
                    result(FlutterError(code: "LOAD_ERROR", message: "Failed to load image", details: nil))
                    return
                }
                
                let fileName = "\(UUID().uuidString).jpg"
                let tempDirectory = FileManager.default.temporaryDirectory
                let fileURL = tempDirectory.appendingPathComponent(fileName)
                
                do {
                    try data.write(to: fileURL)
                    result(["path": fileURL.path])
                    
                    // Clean up temp file after some time
                    DispatchQueue.global().asyncAfter(deadline: .now() + 60) {
                        try? FileManager.default.removeItem(at: fileURL)
                    }
                } catch {
                    result(FlutterError(code: "SAVE_ERROR", message: "Failed to save image", details: nil))
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
//    private func getPhotosInAlbum(albumId: String, result: @escaping FlutterResult) {
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
//        
//        guard let collection = PHAssetCollection.fetchAssetCollections(
//            withLocalIdentifiers: [albumId],
//            options: nil
//        ).firstObject else {
//            result(FlutterError(code: "ALBUM_NOT_FOUND", message: "Album not found", details: nil))
//            return
//        }
//
//        let assets = PHAsset.fetchAssets(in: collection, options: fetchOptions)
//        var photosList: [[String: Any]] = []
//        
//        let imageManager = PHCachingImageManager()
//        let scale = UIScreen.main.scale
//        let thumbnailSize = CGSize(width: 150 * scale, height: 150 * scale)
//        
//        let options = PHImageRequestOptions()
//        options.isNetworkAccessAllowed = true
//        options.deliveryMode = .fastFormat
//        options.isSynchronous = false
//        
//        let dispatchGroup = DispatchGroup()
//        let queue = DispatchQueue(label: "com.yourapp.photoProcessing", attributes: .concurrent)
//        
//        assets.enumerateObjects(options: .concurrent) { (asset, index, stop) in
//            dispatchGroup.enter()
//            queue.async {
//                imageManager.requestImage(for: asset,
//                                          targetSize: thumbnailSize,
//                                          contentMode: .aspectFill,
//                                          options: options) { image, info in
//                    defer { dispatchGroup.leave() }
//                    
//                    guard let image = image else {
//                        print("Error processing asset at index \(index)")
//                        return
//                    }
//                    
//                    if let data = image.jpegData(compressionQuality: 0.8) {
//                        let fileName = "\(UUID().uuidString).jpg"
//                        let fileManager = FileManager.default
//                        let tempDirectory = fileManager.temporaryDirectory
//                        let fileURL = tempDirectory.appendingPathComponent(fileName)
//                        
//                        do {
//                            try data.write(to: fileURL)
//                            let photoInfo: [String: Any] = [
//                                "path": fileURL.path,
//                                "id": asset.localIdentifier,
//                                "creationDate": asset.creationDate?.timeIntervalSince1970 ?? 0,
//                                "width": asset.pixelWidth,
//                                "height": asset.pixelHeight
//                            ]
//                            photosList.append(photoInfo)
//                        } catch {
//                            print("Error saving image: \(error)")
//                        }
//                    }
//                }
//            }
//        }
//        
//        dispatchGroup.notify(queue: .main) {
//            print("photos list length:" ,photosList.count)
//            result(photosList)
//        }
//    }
}
