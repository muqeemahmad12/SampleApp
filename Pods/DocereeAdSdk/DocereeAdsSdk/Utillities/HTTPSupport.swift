//
//  HTTPSupport.swift
//  Asset Tracker
//
//  Created by DK on 29/09/20.
//

import Foundation

struct HTTPMethod {
	static let get = "GET"
	static let post = "POST"
	static let put = "PUT"
    static let delete = "DELETE"
}

struct HTTPHeaderKey {
	static let contentType = "Content-Type"
	static let authorization = "Authorization"
    static let platform = "Platform"
}

struct HTTPHeaderValue {
	static let applicationJson = "application/json"
}

extension HTTPHeaderValue {
    static var platformInfo: String {
        return "iOS 13.0"
//        return UIApplication.osName + ";" + UIApplication.buildVersion
    }

}

enum HttpMethod: String {
    case get
    case post
}

func getHost(type: EnvironmentType) -> String?{
    switch type {
    case .Dev:
        return "dev-bidder.doceree.com"
    case .Local:
        return "10.0.3.2"
    case .Qa:
        return "qa-bidder.doceree.com"
    case .Prod:
        return "bidder.doceree.com"
    }
}

func getDocTrackerHost(type: EnvironmentType) -> String?{
    switch type {
    case .Dev:
        return "dev-tracking.doceree.com"
    case .Local:
        return "10.0.3.2"
    case .Qa:
        return "qa-tracking.doceree.com"
    case .Prod:
        return "tracking.doceree.com"
    }
}

enum Methods{
    case GetImage
    case AdBlock
}

func getPath(methodName: Methods) -> String{
    switch methodName{
    case .GetImage:
        return "/v1/adrequest"
    case .AdBlock:
        return "/saveadblockinfo"
    }
}
