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
    
    init(actorDetail: ActorModel) {
        self.actorDetail = actorDetail
    }
    
    var getActorWork: String {
        actorDetail.knownForDepartment ?? ""
    }
    
    var getActorGender: String {
        if actorDetail.gender == 1 {
           return "Feminino"
        } else {
           return "Masculino"
        }
    }
    
    var getActorBirthday: String {
        actorDetail.birthday ?? ""
    }
    
    var getActorPlaceOfBirth: String {
        actorDetail.placeOfBirth ?? ""
    }
    
    var getSociaMediaCount: Int {
        socialMedia.count
    }
    
    var getSocialMediaCellSize: CGSize {
        CGSize(width: 40, height: 40)
    }
    
    
}
