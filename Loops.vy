# @version 0.2.8

# assign state variable to an array of legth 10
nums: uint256[3]

@external
def __init__():
    self.nums[0] = 10
    self.nums[1] = 20
    self.nums[2] = 30

@external
@pure 
def ifElse(name: String[10]) -> String[20]: # if/else conditional check
    if name == "ben":
        return "Hello, Ben"
    elif name == "angel":
        return "Hello, Angel "
    else:
        return "Hello, stranger"

@external
@view
def sum() -> (uint256, uint256, uint256):
    x: uint256 = 0
    y: uint256 = 0
    z: uint256 = 0
    for i in [1,2,3]:
        x += convert(i, uint256)
    for num in self.nums:
        y += num
    for i in range(10):
        z += z
    return (x, y, z)
