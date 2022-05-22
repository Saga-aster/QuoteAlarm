//
//  SceneDelegate.swift
//  QuoteAlarm
//
//  Created by Saga on 2021/10/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func sceneDidBecomeActive(_ scene: UIScene) {

        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getDeliveredNotifications { notifications in

            if notifications != [] ||
                UserDefaults.standard.object(forKey: "FromDidReceive") != nil {

                notificationCenter.removeAllDeliveredNotifications()
                UserDefaults.standard.removeObject(forKey: "FromDidReceive")
                DispatchQueue.main.async {

                    let currentActiveVC = UIApplication.keyWindowTopViewController()
                    if currentActiveVC is QuoteViewController {

                        currentActiveVC?.viewDidLoad()

                    } else {

                        // TopVCを生成してからQuoteVCへ遷移
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let rootVC = storyboard.instantiateViewController(withIdentifier: "TopVC") as! TopViewController
                        self.window?.rootViewController = rootVC
                        self.window?.makeKeyAndVisible()
                        self.window?.rootViewController?.performSegue(withIdentifier: "QuoteVC", sender: nil)

                    }

                }

            }


        }


    }

}

extension UIApplication {
    private var rootViewControllerInKeyWindow: UIViewController? {
        return UIApplication.shared.connectedScenes
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?
            .windows
            .filter { $0.isKeyWindow }
            .first?
            .rootViewController
    }

    class func keyWindowTopViewController(on controller: UIViewController? = UIApplication.shared.rootViewControllerInKeyWindow) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return keyWindowTopViewController(on: navigationController.visibleViewController)
        }

        if let presented = controller?.presentedViewController {
            return keyWindowTopViewController(on: presented)
        }
        return controller
    }

}
