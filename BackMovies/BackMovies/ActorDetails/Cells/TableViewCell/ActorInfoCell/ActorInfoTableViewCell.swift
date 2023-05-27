//
//  ActorInfoTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

enum ActorInfoStrings: String {
    case actorDetailLabel = "Informações pessoais :"
    case knownLabel = "Conhecido(a) por :"
    case genderLabel = "Gênero :"
    case birthLabel = "Nascimento :"
    case countryLabel = "Local de nascimento :"
    case socialMediaLabel = "Redes sociais"
}

class ActorInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var actorDetailLabel: UILabel!
    @IBOutlet weak var knownLabel: UILabel!
    @IBOutlet weak var knownInfoLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderInfoLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var birthInfoLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryInfoLabel: UILabel!
    @IBOutlet weak var socialMediaLabel: UILabel!
    @IBOutlet weak var socialMediaCollectionView: UICollectionView!
    @IBOutlet weak var bottonLineView: UIView!
    
    static let identifier: String = String(describing: ActorInfoTableViewCell.self)
    
    var viewModel: ActorInfoViewModel?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
        configureCollectionView()
    }
    
    public func setUpCell(actor: ActorModel) {
        viewModel = ActorInfoViewModel(actorDetail: actor)
        knownInfoLabel.text = viewModel?.getActorWork
        genderInfoLabel.text = viewModel?.getActorGender
        birthInfoLabel.text = viewModel?.getActorBirthday
        countryInfoLabel.text = viewModel?.getActorPlaceOfBirth
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        topLineView.backgroundColor = .lineGray
        actorDetailLabel.text = ActorInfoStrings.actorDetailLabel.rawValue
        actorDetailLabel.textColor = .white
        knownLabel.text = ActorInfoStrings.knownLabel.rawValue
        knownLabel.textColor = .white
        knownInfoLabel.textColor = .textColor
        genderLabel.text = ActorInfoStrings.genderLabel.rawValue
        genderLabel.textColor = .white
        genderInfoLabel.textColor = .textColor
        birthLabel.text = ActorInfoStrings.birthLabel.rawValue
        birthLabel.textColor = .white
        birthInfoLabel.textColor = .textColor
        countryLabel.text = ActorInfoStrings.countryLabel.rawValue
        countryLabel.textColor = .white
        countryInfoLabel.textColor = .textColor
        socialMediaLabel.text = ActorInfoStrings.socialMediaLabel.rawValue
        socialMediaLabel.textColor = .white
        socialMediaCollectionView.backgroundColor = .clear
        bottonLineView.backgroundColor = .lineGray
    }
    
    private func configureCollectionView() {
        socialMediaCollectionView.delegate = self
        socialMediaCollectionView.dataSource = self
        if let layout = socialMediaCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
        socialMediaCollectionView.register(SocialMediaCollectionViewCell.nib(), forCellWithReuseIdentifier: SocialMediaCollectionViewCell.identifier)
    }
    
}

//MARK: - UICollectionView Delegate, DataSource
extension ActorInfoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getSociaMediaCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SocialMediaCollectionViewCell.identifier, for: indexPath) as? SocialMediaCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel?.getSocialMediaCellSize ?? CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}
