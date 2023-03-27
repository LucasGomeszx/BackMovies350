//
//  TrailerTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/03/23.
//

import UIKit

class TrailerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var trailerLabel: UILabel!
    @IBOutlet weak var trailerImageView: UIImageView!
    @IBOutlet weak var sinopseLabel: UILabel!
    @IBOutlet weak var sinopseContencLabel: UILabel!
    
    static let identifier: String = "TrailerTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        lineView.backgroundColor = UIColor(named: "LineGray")
        trailerLabel.text = "Treiler:"
        trailerLabel.textColor = UIColor(named: "TextColor")
        sinopseLabel.text = "Sinopse"
        sinopseLabel.textColor = UIColor(named: "TextColor")
        sinopseContencLabel.text = "As reservas naturais da Terra estão chegando ao fim e um grupo de astronautas recebe a missão de verificar possíveis planetas para receberem a população mundial, possibilitando a continuação da espécie. Cooper é chamado para liderar o grupo e aceita a missão sabendo que pode nunca mais ver os filhos. Ao lado de Brand, Jenkins e Doyle, ele seguirá em busca de um novo lar."
        sinopseContencLabel.textColor = UIColor(named: "TextColor")
    }

}
