
import Foundation
import UIKit
import os.log

public final class DocereeAdRequest {
    
    private var size: String?
    private var adUnitId: String?
    
    // MARK: Properties
    var requestHttpHeaders = RestEntity()
    var urlQueryParameters = RestEntity()
    var httpBodyParameters = RestEntity()
    var httpBody: Data?
    var isVendorId: Bool = false
    
    // todo: create a queue of requests and inititate request
    public init() {
    }
    
    // MARK: Properties
    private var isPlatformUidPresent: Bool = false
    
    // MARK: Public methods
    internal func requestAd(_ adUnitId: String!, _ size: String!, completion: @escaping(_ results: Results,
                                                                                        _ isRichMediaAd: Bool) -> Void){
        self.adUnitId = adUnitId
        self.size = size
        setUpImage(self.size!, self.adUnitId!){ (results, isRichMediaAd) in
            completion(results, isRichMediaAd)
        }
    }
    
    
    func sendAdImpression(impressionUrl: String) {
        let updatedUrl: String? = impressionUrl
        let url: URL = URL(string: updatedUrl!)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethod.get.rawValue
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // set headers
        for header in requestHttpHeaders.allValues() {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        let task = session.dataTask(with: urlRequest){ (data, response, error) in
            guard data != nil else { return }
            _ = response as! HTTPURLResponse
            print("Test: Send Imressions")
//            print("impression sent. Http Status code is \(urlResponse.statusCode)")
        }
        task.resume()
    }

    internal func setUpImage(_ size: String!, _ slotId: String!, completion: @escaping(_ results: Results, _ isRichmedia: Bool) -> Void){

        guard let appKey = NSKeyedUnarchiver.unarchiveObject(withFile: DocereeAdsIdArchivingUrl.path) as? String else {
            if #available(iOS 10.0, *) {
                os_log("Error: Missing DocereeIdentifier key!", log: .default, type: .error)
            } else {
                // Fallback on earlier versions
                print("Error: Missing DocereeIdentifier key!")
            }
            return
        }
        
        var advertisementId: String?
        advertisementId = getIdentifierForAdvertising()
        if (advertisementId == nil) {
            if #available(iOS 10.0, *) {
                os_log("Error: Ad Tracking is disabled . Please re-enable it to view ads", log: .default, type: .error)
            } else {
                // Fallback on earlier versions
                print("Error: Ad Tracking is disabled . Please re-enable it to view ads")
            }
            return
        }
        if advertisementId != nil {
            let loggedInUser = NSKeyedUnarchiver.unarchiveObject(withFile: Hcp.ArchivingUrl.path) as? Hcp
 
            //        var loggedInUser = DataController.shared.getLoggedInUser()
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let jsonData = try? jsonEncoder.encode(loggedInUser)
            let json = String(data: jsonData!, encoding: .utf8)!
            let data: Data = json.data(using: .utf8)!
            let json_string = String(data: data, encoding: .utf8)!.replacingOccurrences(of: "\n", with: "")
            let ua = UAString.init().UAString()
            
            //header
            //            self.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
            self.requestHttpHeaders.add(value: ua, forKey: Header.header_user_agent.rawValue)
            self.requestHttpHeaders.add(value: advertisementId!, forKey: Header.header_advertising_id.rawValue)
            self.requestHttpHeaders.add(value: self.isVendorId ? "1" : "0", forKey: Header.is_vendor_id.rawValue)
            self.requestHttpHeaders.add(value: DocereeMobileAds.trackingStatus, forKey: Header.header_is_ad_tracking_enabled.rawValue)
            self.requestHttpHeaders.add(value: Bundle.main.displayName!, forKey: Header.header_app_name.rawValue)
            self.requestHttpHeaders.add(value: Bundle.main.bundleIdentifier!, forKey: Header.header_app_bundle.rawValue)
            self.requestHttpHeaders.add(value: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String, forKey: Header.header_app_version.rawValue)
            self.requestHttpHeaders.add(value: sdkVersion, forKey: Header.header_lib_version.rawValue)
            
            // query params
            self.urlQueryParameters.add(value: appKey, forKey: QueryParamsForGetImage.appKey.rawValue) // DocereeAdsIdentifier
            self.urlQueryParameters.add(value: slotId, forKey: QueryParamsForGetImage.id.rawValue)
            self.urlQueryParameters.add(value: size, forKey: QueryParamsForGetImage.size.rawValue)
            self.urlQueryParameters.add(value: "mobileApp", forKey: QueryParamsForGetImage.platformType.rawValue)
            
            if let platformuid = NSKeyedUnarchiver.unarchiveObject(withFile: ArchivingUrl.path) as? String {
                var data: Dictionary<String, String?>
                if loggedInUser?.npi != nil {
                    data = Dictionary()
                    data = ["platformUid": platformuid]
                } else {
                    data = Dictionary()
                    data = ["platformUid": platformuid,
                            "city": loggedInUser?.city,
                            "specialization": loggedInUser?.specialization,]
                }
                let jsonData = try? JSONSerialization.data(withJSONObject: data, options: [])
                let jsonString = String(data: jsonData!, encoding: .utf8)?.toBase64() // encode to base64
                self.urlQueryParameters.add(value: jsonString!, forKey: QueryParamsForGetImage.loggedInUser.rawValue)
                self.isPlatformUidPresent = true
            } else{
                self.urlQueryParameters.add(value: json_string.toBase64()!, forKey: QueryParamsForGetImage.loggedInUser.rawValue)
                self.isPlatformUidPresent = false
            }
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            var components = URLComponents()
            components.scheme = "https"
            components.host = getHost(type: EnvironmentType.Prod)
            components.path = getPath(methodName: Methods.GetImage)
            var queryItems: [URLQueryItem] = []
            for (key, value) in self.urlQueryParameters.allValues(){
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            components.queryItems = queryItems
            var urlRequest = URLRequest(url: (components.url)!)
            
            // set headers
            for header in requestHttpHeaders.allValues() {
                urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
            }
            
            urlRequest.httpMethod = HttpMethod.get.rawValue
            let task = session.dataTask(with: urlRequest) {(data, response, error) in
                guard let data = data else { return }
                let urlResponse = response as! HTTPURLResponse
                if urlResponse.statusCode == 200 {
                    print("Test: Ad Request")
                    do{
                        let adResponseData: AdResponseForPlatform = try JSONDecoder().decode(AdResponseForPlatform.self, from: data)
                        //                    print("getImage response \(adResponseData)")
                        if adResponseData.errMessage != nil && adResponseData.errMessage!.count > 0 {
                            completion(Results(withData: nil, response: response as? HTTPURLResponse, error: DocereeAdRequestError.failedToCreateRequest), adResponseData.isAdRichMedia())
                            return
                        }
                        if !self.isPlatformUidPresent && adResponseData.newPlatformUid != nil {
                            // MARK check zone tag here later on for US based users' response
                            savePlatformuid(adResponseData.newPlatformUid!)
                        }
                        completion(Results(withData: data, response: response as? HTTPURLResponse, error: nil), adResponseData.isAdRichMedia())
                    } catch{
                        completion(Results(withData: nil, response: response as? HTTPURLResponse, error: DocereeAdRequestError.failedToCreateRequest), false)
                    }
                } else {
                    completion(Results(withData: nil, response: response as? HTTPURLResponse, error: DocereeAdRequestError.failedToCreateRequest), false)
                }
            }
            task.resume()
        } else {
            if #available(iOS 10.0, *){
                os_log("Unknown error", log: .default, type: .error)
            } else {
                print("Unknown error")
            }
        }
    }

}
