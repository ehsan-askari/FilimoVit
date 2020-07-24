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
    
    let reload: PublishSubject<Void> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    
    var vitrinItems: [VitrinItem] = []
    var totalVitrinItemsCount = 0
    
    private var nextEndpoint: String? = nil
    
    
    func refresh() {
        vitrinItems = []
        totalVitrinItemsCount = 0
        nextEndpoint = nil
    }
    
    func isFresh() -> Bool {
        nextEndpoint == nil
    }
    
    func isFinished() -> Bool {
        vitrinItems.count == totalVitrinItemsCount
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
                    
                    if let meta = json["meta"] as? [String: Any], let rowCount = meta["row_count"] as? Int {
                        self.totalVitrinItemsCount = rowCount
                    }
                    
                    if let jsonData = json["data"], let data = try? JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted){
                        
                        if let vitrinItems = try? JSONDecoder().decode([VitrinItem].self, from: data){
                            self.vitrinItems.append(contentsOf: vitrinItems)
                            self.reload.onNext(())
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
