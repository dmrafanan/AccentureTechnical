//
//  PictureTableViewCell.swift
//  AccentureTechnical
//
//  Created by Daniel Marco Rafanan on 7/21/22.
//

import Foundation
import UIKit

class PictureTableViewCell:UITableViewCell{
    
    
    
    static let reuseIdentifier = "PictureTableViewCellReuseIdentifier"
    
    // MARK: ViewModel
    var viewModel:PictureTableViewCellViewModel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        viewModel = PictureTableViewCellViewModel(cache: CacheService.shared.urlCache)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewModel.delegate = self
        setupUI()
        
    }
    // MARK: UI
    private var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = label.font.withSize(20)
        return label
    }()
    
    private func setupUI(){
        contentView.addSubview(leftImageView)
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            leftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            leftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            leftImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
        ])
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor ,constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(pictureModel:PictureModel){
        viewModel.setup(with: pictureModel)
    }
}
extension PictureTableViewCell:PictureTableViewCellViewModelDelegate{
    func updateImage(_ image: UIImage) {
        leftImageView.image = image
    }
    func updateText(_ text: String) {
        titleLabel.text = text
    }
}
