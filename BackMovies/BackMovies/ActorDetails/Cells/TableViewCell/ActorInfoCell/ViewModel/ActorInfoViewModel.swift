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
    
    private var actorDetail: ActorModel?
    private var socialMedia: ActorSocialMedia?
    private var actorSociaMedia: [SocialMedia] = []
    private let defauldReturn: String = "indisponível"
    
    func setupViewModel(actorDetail: ActorModel, delegate: ActorInfoViewModelProtocol) {
        self.actorDetail = actorDetail
        self.delegate = delegate
    }
    
    private weak var delegate: ActorInfoViewModelProtocol?
    
    public func fetchActorSocialMedia() {
        AF.request(Api.getActorSocialMedia(actorId: actorDetail?.id ?? 0), method: .get).validate().responseDecodable(of:ActorSocialMedia.self) { response in
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
        guard let work = actorDetail?.knownForDepartment else {return defauldReturn}
        if work == "" {
            return defauldReturn
        }else {
            return work
        }
    }
    
    var getActorGender: String {
        if actorDetail?.gender == 1 {
            return "Feminino"
        } else {
            return "Masculino"
        }
    }
    
    var getActorBirthday: String {
        guard let bir = actorDetail?.birthday else {return defauldReturn}
        if bir == "" {
            return defauldReturn
        }else {
            return bir
        }
    }
    
    var getActorPlaceOfBirth: String {
        guard let place = actorDetail?.placeOfBirth else {return defauldReturn}
        if place == "" {
            return defauldReturn
        }else {
            return place
        }
    }
    
    func getSocialMedia(index: Int) -> SocialMedia {
        return actorSociaMedia[index]
    }
    
    func getSocialMedia() {
        if let facebook = socialMedia?.facebookID {
            actorSociaMedia.append(SocialMedia(socialMediaType: "facebook", actorSocialMedia: facebook))
        }
        if let instagram = socialMedia?.instagramID {
            actorSociaMedia.append(SocialMedia(socialMediaType: "instagram", actorSocialMedia: instagram))
        }
        if let twitter = socialMedia?.twitterID {
            actorSociaMedia.append(SocialMedia(socialMediaType: "twitter", actorSocialMedia: twitter))
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
        if actorSociaMedia.count == 0 {
            return 1
        }else {
            return actorSociaMedia.count
        }
    }
    
    var getSocialMediaCellSize: CGSize {
        CGSize(width: 40, height: 40)
    }
    var getEmptyCellSize: CGSize {
        CGSize(width: 200, height: 40)
    }
    
    func navegationSocialMedia(index: Int) {
        let socialMedia = actorSociaMedia[index]
        switch socialMedia.socialMediaType {
        case "facebook":
            guard let url = URL(string: Api.facebookLink + (socialMedia.actorSocialMedia ?? "")) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        case "instagram":
            guard let url = URL(string: Api.instagramLink + (socialMedia.actorSocialMedia ?? "")) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        case "twitter":
            guard let url = URL(string: Api.twitterLink + (socialMedia.actorSocialMedia ?? "")) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        default:
            break
        }
        
    }
    
}
