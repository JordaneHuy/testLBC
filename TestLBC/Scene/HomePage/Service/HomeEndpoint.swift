//
//  HomeEndpoint.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import Foundation

enum HomeEndpoint: EndpointProtocol {
    
    case getListing
    case getCategories
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListing, .getCategories:
            return .get
        }
    }
    
    var baseURLString: String {
        switch self {
        case .getListing, .getCategories:
            return "https://raw.githubusercontent.com/leboncoin/paperclip/master"
        }
    }
    
    var path: String {
        switch self {
        case .getListing:
            return "/listing.json"
        case .getCategories:
            return "/categories.json"
        }
    }
    
    var headers: [String: Any]? {
        switch self {
        case .getListing, .getCategories:
            return [:]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getListing, .getCategories:
            return [:]
        }
    }
}
