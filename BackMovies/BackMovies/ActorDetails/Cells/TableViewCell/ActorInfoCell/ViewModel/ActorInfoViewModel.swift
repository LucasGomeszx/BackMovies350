//
//  ActorInfoViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/04/23.
//

import Foundation

class ActorInfoViewModel {
    
    private var actorDetail: ActorModel
    private var socialMedia: [String] = ["Insta", "Face"]
    private let defauldReturn: String = "indisponível"
    
    init(actorDetail: ActorModel) {
        self.actorDetail = actorDetail
    }
    
    var getActorWork: String {
        guard let work = actorDetail.knownForDepartment else {return defauldReturn}
        if work == "" {
            return defauldReturn
        }else {
            return work
        }
    }
    
    var getActorGender: String {
        if actorDetail.gender == 1 {
           return "Feminino"
        } else {
           return "Masculino"
        }
    }
    
    var getActorBirthday: String {
        guard let bir = actorDetail.birthday else {return defauldReturn}
        if bir == "" {
            return defauldReturn
        }else {
            return bir
        }
    }
    
    var getActorPlaceOfBirth: String {
        guard let place = actorDetail.placeOfBirth else {return defauldReturn}
        if place == "" {
            return defauldReturn
        }else {
            return place
        }
    }
    
    var getSociaMediaCount: Int {
        socialMedia.count
    }
    
    var getSocialMediaCellSize: CGSize {
        CGSize(width: 40, height: 40)
    }
    
    
}
