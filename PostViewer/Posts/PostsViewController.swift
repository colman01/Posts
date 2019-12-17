//
//  PostsViewController.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 14.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var dataItems: [ClientModel] = []
    
    var viewModel = PostViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupSubsciption()
        setupTable()
    }
    
    
    //MARK:- Setup
    
    fileprivate func setupSubsciption() {
        viewModel.viewDidAppearSubject.subscribe(onNext: {
        }, onError: { (Error) in
        }, onCompleted: {
            self.dataItems = self.viewModel.posts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) {
        }.disposed(by: disposeBag)
    }
    
    
    fileprivate func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    // MARK:- Data Source Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = self.dataItems[indexPath.row]
        cell.textLabel?.text = item.body
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
