//
//  VitrinVC.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/16/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import UIKit

class VitrinVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        requestData()
        
    }
    
    
    public func requestData(){
        
        //        self.loading.onNext(true)
        APIManager.requestData(url: "/movie/movie/list/tagid/1", method: .get, parameters: nil, completion: { (result) in
            //            self.loading.onNext(false)
            
            switch result {
            case .success(let data) :
                
                                var json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                               let x = json?["data"] as! [Any]
                ////                x[0].rawData
                ////                print(x[0].raw ?? "asd")
                //
                                if let xxx = try? JSONSerialization.data(withJSONObject: x.first, options: .prettyPrinted){
                                    do {
                                                     let decodedResponse = try? JSONDecoder().decode(VitrinItem.self, from: xxx)
                                                     print(decodedResponse)
                                                 }
                                                 catch {
                                                     print(error)
                                                     
                                                 }
                                }
                
                
                
                
             
                
                //                let decoder = JSONDecoder()
                //                let message = try decoder.decode(Message.self, from: json)
                //
                //                let xt = try? VitrinItem(from: data as! Decoder) as? VitrinItem
                
                
                //                    print(xt?.list.first.self)
                
                //                    let o = xt?.list.first
                //
                //                    switch o {
                //                    case .poster(let q ):
                //                        print(q)
                //                    case .movie(let w):
                //                        print(w)
                //                    }
                
                //                    print(GenericItem.Type)
                
                
                
                
                //                self.albums.onNext(albums)
            //                self.tracks.onNext(tracks)
            case .failure(let failure) :
                switch failure {
                case .connectionError: break
                    //                    self.error.onNext(.internetError("Check your Internet connection."))
                    
                //                    self.error.onNext(.serverMessage(errorJson["message"].stringValue))
                default: break
                    //                    self.error.onNext(.serverMessage("Unknown Error"))
                }
            }
        })
        
    }
    
    
}

