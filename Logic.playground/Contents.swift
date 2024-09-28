import UIKit

func threeHandWidthsBag(v1: Int, w1: Int, v2: Int, w2: Int,
               maxW: Int) -> Int {
    if w1 + w2 <= maxW { //take both
        return v1 + v2
    }
    
    if w1 > maxW && w2 > maxW { //too weak to take any of items
        return 0
    }
    
    if w1 <= maxW && w2 <= maxW { //can't take both items, but you're able to choose the best value
        return v1 > v2 ? v1 : v2
    }
    
    return w1 <= maxW ? v1 : v2 //can't take both items, you can only carry the item that weight <= maxW
}

threeHandWidthsBag(v1: 10, w1: 5, v2: 6,  w2: 4, maxW: 8)
threeHandWidthsBag(v1: 10, w1: 5, v2: 6,  w2: 4, maxW: 9)
threeHandWidthsBag(v1: 10, w1: 2, v2: 11, w2: 3, maxW: 1)
threeHandWidthsBag(v1: 15, w1: 2, v2: 20, w2: 3, maxW: 2)
threeHandWidthsBag(v1: 2,  w1: 5, v2: 3,  w2: 4, maxW: 5)
threeHandWidthsBag(v1: 4,  w1: 3, v2: 3,  w2: 4, maxW: 4)
threeHandWidthsBag(v1: 3,  w1: 5, v2: 3,  w2: 8, maxW: 10)
threeHandWidthsBag(v1: 3,  w1: 6, v2: 3,  w2: 6, maxW: 10)
threeHandWidthsBag(v1: 3,  w1: 6, v2: 4,  w2: 6, maxW: 10)
 
