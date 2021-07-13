import Foundation
import RealmSwift

class Apod: Object {
    @objc dynamic var date: String = ""
    @objc dynamic var explanation: String = ""
    @objc dynamic var hdurl: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var url: String = ""
    
    @objc dynamic var media: Media?
}
