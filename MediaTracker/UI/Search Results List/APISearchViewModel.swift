//
//  APISearchViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation
import Alamofire

class APISearchViewModel<WrapperModel, ResultModel>: NetworkListViewModel<String, WrapperModel, ResultModel> where WrapperModel: Codable, ResultModel: Identifiable, ResultModel: SimpleCellViewModelMappable {

}
