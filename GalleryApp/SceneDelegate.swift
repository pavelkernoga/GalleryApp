//
//  SceneDelegate.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ImagesGalleryViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}
