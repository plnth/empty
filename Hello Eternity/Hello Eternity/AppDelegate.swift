import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initializeRealm()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = MainModuleBuilder.createMainModule()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        debugPrint(NSHomeDirectory())
        
        return true
    }
    
    private func initializeRealm() {
        if let realm = try? Realm() {
            guard realm.isEmpty else { return }
        }
    }
}

