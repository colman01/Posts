//
//  FavPostsViewModel.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 14.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FavPostsViewModel {
    var posts: [ClientModel] = []
    let disposeBag = DisposeBag()
    
    func viewDidLoad() {
        let client = NetworkManager.shared
        do{
            try client.getDataItems().subscribe(
                onNext: { result in
                    self.posts = result
            },
                onError: { error in
                    print(error)
            }).disposed(by: disposeBag)
        }
        catch{  
        }
    }
}
