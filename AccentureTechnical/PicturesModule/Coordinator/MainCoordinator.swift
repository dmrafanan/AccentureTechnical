//
//  MainCoordinator.swift
//  AccentureTechnical
//
//  Created by Daniel Marco Rafanan on 7/21/22.
//

import Foundation
import UIKit

class MainCoordinator:Coordinator{
    var navigationController: UINavigationController
    
    init(navigationController:UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = PictureListViewController(viewModel: PictureListViewModel(coordinator: self, urlCache: CacheService.shared.urlCache))
        
        navigationController.setViewControllers([vc], animated: false)
    }
    func showPictureDetailWith(image:UIImage){
        let vc = PictureDetailViewController(image: image)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
