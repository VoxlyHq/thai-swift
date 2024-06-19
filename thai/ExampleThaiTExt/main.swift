import thai

let textProcessor = ThaiTextProcessor()
if let segments = textProcessor.segmentText("ประเทศไทยเป็นประเทศในภูมิภาคเอเชียตะวันออกเฉียงใต้") {
    print(segments.joined(separator: " "))
}//
//  text_segment.swift
//  thai
//
//  Created by Matthew Campbell on 6/19/24.
//

