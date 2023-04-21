//
//  ListBookCoordinator.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 21/04/23.
//

import UIKit

class ListBookCoordinator {
   
    weak var controller: UIViewController?
    
    func pushDetailBookViewControntrollerScreen(mode: Books) {
        let commentsService = CommentsService()
        let detailModel = DetailBookViewModel(model: mode, service: commentsService)
        let detailBookViewController = DetailBookViewController(viewModel: detailModel)
        controller?.navigationController?.pushViewController(detailBookViewController, animated: true)
    }
    
    func pushErrorViewControllerScreen() {
        let errorViewController = ErrorViewController()
        errorViewController.delegate = controller as? ListBookViewController
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: errorViewController)
        navBarOnModal.modalPresentationStyle = .overFullScreen
        controller?.navigationController?.present(navBarOnModal, animated: false)
    }
}
