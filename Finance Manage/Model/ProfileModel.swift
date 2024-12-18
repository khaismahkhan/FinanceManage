//
//  ProfileModel.swift
//  TheProject
//
//

import Foundation
struct Profile {
    var name: String
    var email: String
    var phone: String
}

class ProfileViewModel: ObservableObject {
    @Published var profile: Profile = Profile(name: "Khaismah Bin Ilyas", email: "kilyas24@fed.idserve.net", phone: "+393274864046")
}
