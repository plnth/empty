import UIKit
import RealmSwift

enum StorageProviderError: Error {
    case fetchFailed
    case savingFailed
}

final class StorageDataProvider {
    
    static let shared: StorageDataProvider = StorageDataProvider()
    
    private let mediaFilesProvider = MediaFilesProvider.default
    
    func fetchStoredApods() throws -> [Apod] {
        
        do {
            let realm = try Realm()
            let apods = realm.objects(Apod.self).sorted(byKeyPath: "title")
            return apods.map { $0 }
        } catch {
            throw StorageProviderError.fetchFailed
        }
    }
    
    func newApodItem() throws -> Apod {
        return Apod()
    }
    
    func newMediaItem() throws -> Media {
        return Media()
    }
    
    func fetchApodByTitle(_ title: String) throws -> Apod? {
        
        let predicate = NSPredicate(format: "title CONTAINS %@", title)
        
        do {
            let realm = try Realm()
            return realm.objects(Apod.self).filter(predicate).first
        } catch {
            throw StorageProviderError.fetchFailed
        }
    }
    
    func saveApod(_ apod: Apod, withMedia media: Media, withData data: Data) {
        
        let predicate = NSPredicate(format: "title CONTAINS %@", apod.title)
        
        guard let realm = try? Realm(),
              realm.objects(Apod.self).filter(predicate).isEmpty
              else { return }
        
        let path = self.saveMediaData(media, data)
        apod.media?.filePath = path ?? ""
        
        let item = apod
        item.media = media
        try? realm.write {
            realm.add(item)
        }
    }
    
    func saveMediaData(_ media: Media, _ data: Data) -> String? {
        let path = self.mediaFilesProvider.saveMediaWithPath(mediaData: data, with: media.title)
        return path
    }
    
    func getMediaFileDataForTitle(_ title: String) -> Data? {
        return self.mediaFilesProvider.getMediaFileDataForTitle(title)
    }
    
    func deleteApod(_ apod: Apod) {
        if let realm = try? Realm() {
            try? realm.write {
                realm.delete(apod)
            }
        }
    }
}
