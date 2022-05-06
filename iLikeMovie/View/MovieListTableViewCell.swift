//
//  MovieListTableViewCell.swift
//  iLikeMovie
//
//  Created by 민선기 on 2022/05/06.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier: String = String(describing: MovieListTableViewCell.self)
    static let height: CGFloat = 100
    
    private var item: MovieItemViewModel!
    private var viewModel: MovieListViewModel!
    private var isFavorite: Bool = false
    
    private let movieImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .heavy)
        label.text = "title"
        return label
    }()
    
    private lazy var favoritesImageView: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentCompressionResistancePriority(.init(rawValue: 800), for: .horizontal)
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = .gray
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didTapFavoriteButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private let director: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.text = "title"
        return label
    }()
    
    private let actors: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.text = "title"
        return label
    }()
    
    private let rating: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.text = "title"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraints()
        //test()
    }
    
    func test() {
        favoritesImageView.tintColor = item.isFavorite ? .systemYellow : .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitle.text = nil
        movieImageView.image = nil
        favoritesImageView.imageView?.image = nil
        director.text = nil
        actors.text = nil
        rating.text = nil
    }
    
    func configure(with item: MovieItemViewModel, viewModel: MovieListViewModel) {
        self.item = item
        self.viewModel = viewModel
        self.isFavorite = item.isFavorite
        
        movieTitle.text = item.title
        director.text = item.director
        actors.text = item.actor
        rating.text = item.userRating
        movieImageView.setImageUrl(item.image)
        
        favoritesImageView.tintColor = item.isFavorite ? .systemYellow : .systemGray
    }
    
}

// MARK: - Objc
extension MovieListTableViewCell {
    @objc private func didTapFavoriteButton(_ sender: UIButton) {
        if item.isFavorite {
            
            viewModel.removeFavorite(with: item)
            
            
        } else {
            
            viewModel.addFavorite(with: item)
        }
        
        item.isFavorite.toggle()
        favoritesImageView.tintColor = item.isFavorite ? .systemYellow : .systemGray
    }
}

// MARK: - Private
extension MovieListTableViewCell {
    private func setUpConstraints() {
        
        let titleStackView = UIStackView(arrangedSubviews: [movieTitle, favoritesImageView])
        titleStackView.axis = .horizontal
        titleStackView.spacing = 8
    
        
        let innerStackView = UIStackView(arrangedSubviews: [titleStackView, director, actors, rating])
        innerStackView.axis = .vertical
        innerStackView.distribution = .equalCentering
        
        let outerStackView = UIStackView(arrangedSubviews: [movieImageView, innerStackView])
        outerStackView.axis = .horizontal
        outerStackView.spacing = 8
        
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(outerStackView)

        NSLayoutConstraint.activate([
            outerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            outerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            outerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            outerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            movieImageView.widthAnchor.constraint(equalToConstant: 80),
            favoritesImageView.widthAnchor.constraint(equalToConstant: 36)
            
        ])
    }
}
