//
//  PostsViewModel.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 14.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation
import RxSwift


class PostViewModel {
    
    var posts: [ClientModel] = []
    let disposeBag = DisposeBag()
    let viewDidAppearSubject = PublishSubject<()>()
    
    func viewDidLoad() {
        let client = NetworkManager.shared
        do{
            try client.getDataItems().subscribe(
                onNext: { result in
                    self.posts = result
            },
                onError: { error in
                    print(error)
            }, onCompleted: {
                self.viewDidAppearSubject.onCompleted()
                
            }).disposed(by: disposeBag)
        }
        catch{
        }
        
    }
}
