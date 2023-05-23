//
//  MainTabController.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 20/03/23.
//

import UIKit

class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let serviceManager = try? ServiceManager(base: "https://64382d9bf3a0c40814acc039.mockapi.io/devpoli/books") else { return }
        let listBookViewModel = ListBookViewModel(service: serviceManager)
        
        let listBook = self.createTabItem(viewController: ListBookViewController(viewModel: listBookViewModel),
                                          title: "Livros",
                                          image: "icone-hoje")
        
        let searchViewModel = SearchBookViewModel(service: serviceManager)
        let searchBook = self.createTabItem(viewController: SearchBookViewController(viewModel: searchViewModel),
                                            title: "Pesquisar",
                                            image: "icone-busca")
        
        viewControllers = [
            listBook,
            searchBook
        ]
        
        if #available(iOS 13.0, *) {
           let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
           tabBarAppearance.configureWithDefaultBackground()
           if #available(iOS 15.0, *) {
              UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
           }
        }
    }
    
    func createTabItem(viewController: UIViewController, title: String, image: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        
        viewController.navigationItem.title = title
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: image)
        //viewController.view.backgroundColor = .white
        
        return navController
    }
    
}
