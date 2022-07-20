//
//  Coordinator.swift
//  AccentureTechnical
//
//  Created by Daniel Marco Rafanan on 7/20/22.
//

import Foundation
import UIKit

protocol Coordinator:AnyObject{
    var navigationController: UINavigationController { get set }
    
    func start()
}
