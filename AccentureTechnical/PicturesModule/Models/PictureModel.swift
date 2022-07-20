//
//  PictureModel.swift
//  AccentureTechnical
//
//  Created by Daniel Marco Rafanan on 7/21/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pictureModel = try? newJSONDecoder().decode(PictureModel.self, from: jsonData)

import Foundation

// MARK: - PictureModel
struct PictureModel: Codable {
    let albumId, id: Int?
    let title: String?
    let url, thumbnailUrl: String?
}
