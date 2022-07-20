//
//  PictureTableViewCellViewModel.swift
//  AccentureTechnical
//
//  Created by Daniel Marco Rafanan on 7/21/22.
//

import Foundation
import UIKit

protocol PictureTableViewCellViewModelDelegate{
    func updateImage(_ image:UIImage)
    func updateText(_ text:String)
}

class PictureTableViewCellViewModel{
    private let urlCache: NSCache<NSURL, AnyObject>
    private var imageURL:URL?
    
    init(cache:NSCache<NSURL, AnyObject>){
        self.urlCache = cache
    }
    
    var delegate:PictureTableViewCellViewModelDelegate?
        
    //Cache image to avoid UI bugs when cells are being dequeued eg. scrolling fast
    func setup(with pictureModel:PictureModel){
        delegate?.updateText(pictureModel.title ?? "")
        guard let urlString = pictureModel.url else { return }
        guard let url = URL(string: urlString) else { return }
        imageURL = url
        let placeHolderImage = UIImage(named: "no image available") ?? UIImage()
        delegate?.updateImage(placeHolderImage)
        if let imageFromCache = urlCache.object(forKey: url as NSURL){
            let image = (imageFromCache as? UIImage) ?? placeHolderImage
            delegate?.updateImage(image)
        }else{
            delegate?.updateImage(placeHolderImage)
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                DispatchQueue.main.async {
                    
                    guard let data = data else {
                        self?.delegate?.updateImage(placeHolderImage)
                        return
                    }
                    guard let image = UIImage(data: data) else {return}
                    if url == self?.imageURL{
                        self?.delegate?.updateImage(UIImage(data: data) ?? placeHolderImage)
                    }
                    
                    self?.urlCache.setObject(image, forKey: url as NSURL)
                }
            }.resume()
        }
    }
}


