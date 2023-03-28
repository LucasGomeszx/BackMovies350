//
//  ActorInfoTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

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
    
    static let identifier: String = "ActorInfoTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
        configureCollectionView()
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        topLineView.backgroundColor = UIColor(named: "LineGray")
        actorDetailLabel.text = "Informações pessoais :"
        actorDetailLabel.textColor = .white
        knownLabel.text = "Conhecido(a) por :"
        knownLabel.textColor = .white
        knownInfoLabel.text = "Atuação"
        knownInfoLabel.textColor = UIColor(named: "TextColor")
        genderLabel.text = "Gênero :"
        genderLabel.textColor = .white
        genderInfoLabel.text = "Masculino"
        genderInfoLabel.textColor = UIColor(named: "TextColor")
        birthLabel.text = "Nascimento :"
        birthLabel.textColor = .white
        birthInfoLabel.text = "1969-11-04 (53 de Idade)"
        birthInfoLabel.textColor = UIColor(named: "TextColor")
        countryLabel.text = "Local de nascimento :"
        countryLabel.textColor = .white
        countryInfoLabel.text = "Uvalde, Texas, USA"
        countryInfoLabel.textColor = UIColor(named: "TextColor")
        socialMediaLabel.text = "Redes sociais"
        socialMediaLabel.textColor = .white
        socialMediaCollectionView.backgroundColor = .clear
        bottonLineView.backgroundColor = UIColor(named: "LineGray")
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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SocialMediaCollectionViewCell.identifier, for: indexPath) as? SocialMediaCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}
