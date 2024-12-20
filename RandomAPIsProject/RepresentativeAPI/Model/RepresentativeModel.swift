//
//  RepresentativeModel.swift
//  RandomAPIsProject
//
//  Created by Wesley Keetch on 12/3/24.
//

import Foundation

struct RepresentativeModel: Codable {
    var name: String
    var party: String
    var state: String
    var district: String
    var phone: String
    var office: String
    var link: URL
}

struct RepInfoResults: Codable {
    let results: [RepresentativeModel]
}
