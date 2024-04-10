//
//  SocialData.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/4/24.
//

import Foundation
import SwiftUI
import UIKit

struct SocialData: Identifiable {
    let id = UUID()
    let nameSocial: String
    let urlSocial: String
    let imageSocial: [String]
}
