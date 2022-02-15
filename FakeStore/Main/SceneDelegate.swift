//
//  SceneDelegate.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navController = UINavigationController()
        let controller = ViewController(viewModel: ProductsListViewModel(dataSource: ProductsNetworkService(session: URLSession.shared, baseURL: URL(string: "https://fakestoreapi.com/")!, parser: JSONParser()), networkNotifier: ReachabilityNetworkNotifier()))
        navController.viewControllers = [controller]
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

