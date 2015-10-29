//
//  RecordedAudio.swift
//  Pitch Perfect1
//
//  Created by CALIN STEFAN on 9/21/15.
//  Copyright © 2015 CALIN STEFAN. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl:NSURL, title:String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
