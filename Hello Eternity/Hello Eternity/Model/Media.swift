import Foundation
import RealmSwift

class Media: Object {
    @objc dynamic var filePath: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var url: String = ""
    
    @objc dynamic var apod: Apod?
}
