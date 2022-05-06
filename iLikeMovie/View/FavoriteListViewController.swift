//
//  FavoriteListViewController.swift
//  iLikeMovie
//
//  Created by 민선기 on 2022/05/06.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    let viewModel: MovieListViewModel
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        title = "즐겨찾기"
    }
}
