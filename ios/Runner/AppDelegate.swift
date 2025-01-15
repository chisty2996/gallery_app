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
        
        let imageManager = PHCachingImageManager()
        let scale = UIScreen.main.scale
        let thumbnailSize = CGSize(width: 150 * scale, height: 150 * scale)
        
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .fastFormat
        options.isSynchronous = false
        
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "com.yourapp.photoProcessing", attributes: .concurrent)
        
        assets.enumerateObjects(options: .concurrent) { (asset, index, stop) in
            dispatchGroup.enter()
            queue.async {
                imageManager.requestImage(for: asset,
                                          targetSize: thumbnailSize,
                                          contentMode: .aspectFill,
                                          options: options) { image, info in
                    defer { dispatchGroup.leave() }
                    
                    guard let image = image else {
                        print("Error processing asset at index \(index)")
                        return
                    }
                    
                    if let data = image.jpegData(compressionQuality: 0.8) {
                        let fileName = "\(UUID().uuidString).jpg"
                        let fileManager = FileManager.default
                        let tempDirectory = fileManager.temporaryDirectory
                        let fileURL = tempDirectory.appendingPathComponent(fileName)
                        
                        do {
                            try data.write(to: fileURL)
                            let photoInfo: [String: Any] = [
                                "path": fileURL.path,
                                "id": asset.localIdentifier,
                                "creationDate": asset.creationDate?.timeIntervalSince1970 ?? 0,
                                "width": asset.pixelWidth,
                                "height": asset.pixelHeight
                            ]
                            photosList.append(photoInfo)
                        } catch {
                            print("Error saving image: \(error)")
                        }
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("photos list length:" ,photosList.count)
            result(photosList)
        }
    }

}
