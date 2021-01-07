//
//  ApiHelper.swift
//  Kenakata
//
//  Created by Yasin Shamrat on 29/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import Alamofire

class ApiHelperGET {
    var url:String?
    var pagination = false
    var data = [[String: Any]]()
    
    init(url: String,pagination: Bool) {
        self.url = url
        self.pagination = pagination
    }
    
    func fetchData(completion: @escaping (Result<[[String: Any]]>)-> Void) {
        if let url = self.url{
            let request = URLRequest(url: URL(string: url)!)
            DispatchQueue.global(qos: .userInteractive).async {
                Alamofire.request(request).responseJSON { (myresponse) in
                    switch myresponse.result{
                    case .success:
                        if let json = myresponse.result.value as? [[String: Any]] {
                            completion(.success(json))
                        }
                        
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                    
                }
            }
        }
    }
    
}
