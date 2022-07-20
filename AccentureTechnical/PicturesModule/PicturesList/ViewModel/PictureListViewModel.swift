//
//  PicturesViewModel.swift
//  AccentureTechnical
//
//  Created by Daniel Marco Rafanan on 7/21/22.
//

import Foundation
import UIKit

protocol PictureListViewModelDelegate: AnyObject{
    func isGettingPictures(_ isGettingPictures:Bool)
    func didRecieveNewPictureModels()
    func didRecieve(networkError: NetworkError)
}

class PictureListViewModel{
    
    var coordinator: MainCoordinator
        
    private var picturesProvider:PicturesProvider
    
    weak var delegate:PictureListViewModelDelegate?
    
    private let urlCache: NSCache<NSURL, AnyObject>
    
    init(coordinator:MainCoordinator,picturesProvider:PicturesProvider = PicturesDataService(), urlCache: NSCache<NSURL, AnyObject>){
        self.urlCache = urlCache
        self.coordinator = coordinator
        self.picturesProvider = picturesProvider
    }
    
    private(set) var pictureModels:[PictureModel] = []
    
    func getNewPictures(){
        delegate?.isGettingPictures(true)
        picturesProvider.getPictures { [weak self] result in
            DispatchQueue.main.async {
                self?.delegate?.isGettingPictures(false)
                switch result{
                case .success(let pictureModels):
                    self?.pictureModels = pictureModels
                    self?.delegate?.didRecieveNewPictureModels()
                    
                case .failure(let networkError):
                    self?.delegate?.didRecieve(networkError: networkError)
                }
            }
        }
    }
    func tappedCell(at indexPath:IndexPath){
        //Disable tapping when image has not been fetched/cached
        if let image = findImage(for: pictureModels[indexPath.row]){
            coordinator.showPictureDetailWith(image: image)
        }
    }
    private func findImage(for pictureModel:PictureModel) -> UIImage?{
        guard let urlString = pictureModel.url, let url = URL(string: urlString) else { return nil }
        if let image = urlCache.object(forKey: url as NSURL) as? UIImage{
            return image
        }else{
            return nil
        }
    }
}
