import Foundation
import LibThai

// Type alias for thchar_t
typealias thchar_t = Int8

class ThaiTextProcessor {
    func segmentText(_ text: String) -> [String]? {
        // Convert Swift String to a C string
        guard let cString = text.cString(using: .utf8) else { return nil }
        
        // Allocate memory for position array
        let maxPositions = 1000 // Assuming a max number of positions
        let positions = UnsafeMutablePointer<Int32>.allocate(capacity: maxPositions)
        defer {
            positions.deallocate()
        }
        
        // Get the length of the input text
        let length = text.lengthOfBytes(using: .utf8)
        
        // Call the libthai function
        let result = th_brk_find_breaks(nil, cString, positions, maxPositions)
        
        // Check for errors
        guard result > 0 else { return nil }
        
        // Convert byte offsets to character indices
        var segments = [String]()
        var lastPosition = 0
        
        for i:Int32 in 0..<result {
            let byteOffset = Int(positions[Int(i)])
            let start = text.utf8.index(text.utf8.startIndex, offsetBy: lastPosition)
            let end = text.utf8.index(text.utf8.startIndex, offsetBy: byteOffset)
            
            if let startIndex = String.Index(start, within: text), let endIndex = String.Index(end, within: text) {
                let segment = String(text[startIndex..<endIndex])
                segments.append(segment)
                lastPosition = byteOffset
            }
        }
        
        return segments
    }
}
