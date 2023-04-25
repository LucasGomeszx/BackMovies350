//
//  ActorTopTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

class ActorTopTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioContentLabel: UILabel!
    
    static let identifier: String = "ActorTopTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    public func setUpCell(actor: ActorModel) {
        
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        actorImage.layer.cornerRadius = 15
        actorImage.clipsToBounds = true
        actorNameLabel.text = "Matthew McConaughey"
        actorNameLabel.textAlignment = .center
        actorNameLabel.textColor = .white
        bioLabel.text = "Biografia: "
        bioLabel.textColor = UIColor(named: "TextColor")
        bioContentLabel.text = "Matthew David McConaughey (Uvalde, 4 de novembro de 1969) é um ator, produtor, realizador, cenógrafo e professor estadunidense vencedor do Oscar de Melhor Ator. Além de fazer uma ponta em The Wolf of Wall Street (2013), participou como protagonista tanto na série de sucesso da HBO, True Detective, recebendo ótimas críticas, como no premiado filme Dallas Buyers Club (2013). Por seu desempenho, Matthew foi aclamado pela crítica especializada, levando, entre tantos outros prêmios, o Oscar de Melhor Ator, Globo de Ouro de Melhor Ator em filme dramático e SAG Award de Melhor Ator."
        bioContentLabel.textColor = UIColor(named: "TextColor")
    }

}
