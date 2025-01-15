import Photos
import Flutter

class PhotoGalleryHandler: NSObject {
    static let shared = PhotoGalleryHandler()
    
    private override init() {}
    
    func getPhotosInAlbum(albumId: String, result: @escaping FlutterResult) {
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
        
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = false
        
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "com.yourapp.photoProcessing", attributes: .concurrent)
        
        assets.enumerateObjects(options: .concurrent) { (asset, index, stop) in
            dispatchGroup.enter()
            queue.async {
                self.requestImageData(for: asset, using: imageManager, options: options) { data, uti, orientation, info in
                    defer { dispatchGroup.leave() }
                    
                    guard let data = data else {
                        print("Error processing asset at index \(index)")
                        return
                    }
                    
                    let fileName = "\(UUID().uuidString).\(self.getFileExtension(from: uti))"
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
        
        dispatchGroup.notify(queue: .main) {
            print("photos list length:", photosList.count)
            result(photosList)
        }
    }
    
    private func requestImageData(for asset: PHAsset, using imageManager: PHCachingImageManager, options: PHImageRequestOptions, completion: @escaping (Data?, String?, UIImage.Orientation, [AnyHashable: Any]?) -> Void) {
        if #available(iOS 13, *) {
            imageManager.requestImageDataAndOrientation(for: asset, options: options) { data, uti, cgOrientation, info in
                let uiOrientation = UIImage.Orientation(cgOrientation) ?? .up
                completion(data, uti, uiOrientation, info)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func getFileExtension(from uti: String?) -> String {
        switch uti {
        case "public.jpeg":
            return "jpg"
        case "public.png":
            return "png"
        case "public.heic":
            return "heic"
        default:
            return "jpg"
        }
    }
}

extension UIImage.Orientation {
    init?(_ cgOrientation: CGImagePropertyOrientation) {
        switch cgOrientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        @unknown default: return nil
        }
    }
}

