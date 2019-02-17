//
//  APISearchViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation
import Alamofire

class APISearchViewModel<ResultModel>: NetworkListViewModel<String, ResultModel> where ResultModel: Identifiable, ResultModel: SimpleCellViewModelMappable {

}
