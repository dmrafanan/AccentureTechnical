//
//  CacheService.swift
//  AccentureTechnical
//
//  Created by Daniel Marco Rafanan on 7/21/22.
//

import Foundation

class CacheService{
    static let shared = CacheService()
    
    let urlCache = NSCache<NSURL, AnyObject>()
}
