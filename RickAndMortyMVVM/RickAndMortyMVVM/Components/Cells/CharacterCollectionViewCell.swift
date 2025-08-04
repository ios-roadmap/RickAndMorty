//
//  CharacterCollectionViewCell.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import UIKit
import Kingfisher

final class CharacterCollectionViewCell: UICollectionViewCell {

    static let identifier = "CharacterCollectionViewCell"

    // MARK: - Subviews

    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 17, weight: .bold)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private lazy var locationTitleLabel = UILabel()
    private lazy var locationSubtitleLabel = UILabel()
    private lazy var originTitleLabel = UILabel()
    private lazy var originSubtitleLabel = UILabel()

    private lazy var locationStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private lazy var originStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private lazy var mainStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.distribution = .equalSpacing
        sv.alignment = .top
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        locationSubtitleLabel.text = nil
        originSubtitleLabel.text = nil
    }

    // MARK: - Configuration

    func configure(with model: RMCharacter) {
        if let url = URL(string: model.image ?? "") {
            imageView.kf.setImage(with: url)
        }
        nameLabel.text = model.name

        locationTitleLabel.text    = "Last known location:"
        locationSubtitleLabel.text = model.location?.name ?? "-"

        originTitleLabel.text      = "First seen in:"
        originSubtitleLabel.text   = model.origin?.name ?? "-"
    }

    // MARK: - Private helpers

    private func setupViews() {
        locationTitleLabel = makeInfoTitleLabel()
        locationSubtitleLabel = makeInfoSubtitleLabel()
        originTitleLabel = makeInfoTitleLabel()
        originSubtitleLabel = makeInfoSubtitleLabel()
        
        locationStack.addArrangedSubview(locationTitleLabel)
        locationStack.addArrangedSubview(locationSubtitleLabel)

        originStack.addArrangedSubview(originTitleLabel)
        originStack.addArrangedSubview(originSubtitleLabel)

        mainStack.addArrangedSubview(imageView)
        mainStack.addArrangedSubview(nameLabel)
        mainStack.addArrangedSubview(locationStack)
        mainStack.addArrangedSubview(originStack)
        
        contentView.addSubview(mainStack)

        // Constraints
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }

    private func makeInfoTitleLabel() -> UILabel {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .secondaryLabel
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }

    private func makeInfoSubtitleLabel() -> UILabel {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 14)
        lbl.textColor = .label
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
}
