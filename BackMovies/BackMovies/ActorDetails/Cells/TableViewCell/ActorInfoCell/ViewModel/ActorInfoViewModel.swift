//
//  ActorInfoViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/04/23.
//

import Foundation
import Alamofire

protocol ActorInfoViewModelProtocol: AnyObject {
    func didFetchSocialMediaSuccess()
}

class ActorInfoViewModel {
    
    private var actorDetail: ActorModel
    private var socialMedia: ActorSocialMedia?
    private var actorSociaMedia: [String] = []
    private let defauldReturn: String = "indisponível"
    
    init(actorDetail: ActorModel, delegate: ActorInfoViewModelProtocol) {
        self.actorDetail = actorDetail
        self.delegate = delegate
    }
    
    private weak var delegate: ActorInfoViewModelProtocol?
    
    public func fetchActorSocialMedia() {
        AF.request(Api.getActorSocialMedia(actorId: actorDetail.id ?? 0), method: .get).validate().responseDecodable(of:ActorSocialMedia.self) { response in
            switch response.result {
            case .success(let result):
                self.socialMedia = result
                self.getSocialMedia()
                self.delegate?.didFetchSocialMediaSuccess()
            case .failure(let error):
                print(error)
            }
        }
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
    
    func getSocialMedia() {
        if let facebook = socialMedia?.facebookID {
            actorSociaMedia.append(facebook)
        }
        if let instagram = socialMedia?.instagramID {
            actorSociaMedia.append(instagram)
        }
        if let tiktok = socialMedia?.tiktokID {
            actorSociaMedia.append(tiktok)
        }
        if let twitter = socialMedia?.twitterID {
            actorSociaMedia.append(twitter)
        }
    }
    
    var isNill: Bool {
        guard let social = socialMedia else {return true}
        if social.facebookID == nil && social.instagramID == nil && social.tiktokID == nil && social.twitterID == nil {
            return true
        }else {
            return false
        }
    }
    
    var getSociaMediaCount: Int {
        return actorSociaMedia.count
    }
    
    var getSocialMediaCellSize: CGSize {
        CGSize(width: 40, height: 40)
    }
    
}
