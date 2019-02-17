//
//  MappingAPISearchViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation
import Alamofire

class MappingAPISearchViewModel<WrapperModel, ResultModel>: MappingNetworkListViewModel<String, WrapperModel, ResultModel>
where ResultModel: Identifiable, ResultModel: SimpleCellViewModelMappable, WrapperModel: Codable  {
	
}
