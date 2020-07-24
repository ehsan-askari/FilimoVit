//
//  VitrinVM.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/18/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import Foundation
import RxSwift

class VitrinVM {
    
    let vitrinItems: PublishSubject<[VitrinItem]> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    
    private var nextEndpoint: String? = nil
    
    func refresh() {
        nextEndpoint = nil
    }
    
    func getVitrinItems() {
        self.isLoading.onNext(true)
        APIManager.request(endpoint: nextEndpoint != nil ? nextEndpoint! : API.Endpoint.vitrin, httpMethod: .get) { (result) in
            self.isLoading.onNext(false)
            switch result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let links = json["links"] as? [String: String], let forward = links["forward"]{
                        self.nextEndpoint = forward.replacingOccurrences(of: API.baseURL.replacingOccurrences(of: "_/", with: ""), with: "")
                    }
                    
                    if let jsonData = json["data"], let data = try? JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted){
                        if let vitrinItems = try? JSONDecoder().decode([VitrinItem].self, from: data){
                            self.vitrinItems.onNext(vitrinItems)
                        }
                    }
                }
            case .failure(let error):
                print(error)
                switch error {
                case .noConnection:
                    self.error.onNext(Message.noConnection)
                default:
                    self.error.onNext(Message.unknown)
                }
            }
        }
    }
    
}
