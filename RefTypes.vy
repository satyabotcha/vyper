# @version 0.2.8

# group multiple variables
struct Person:
    name: String[100]
    age: uint256

# lists with postive integer type -> which can hold 10 values at most
nums: public(uint256[10])

# hash map  with key and value -> HashMap[key, value]
myMap: public(HashMap[address, uint256])

personMap: public(HashMap[String[100], uint256])

person: public(Person)

@external
def __init__():
    self.nums[0] = 100
    self.nums[1] = 101
    self.myMap[msg.sender] = 98
    self.person.name = "Ben Awad"
    self.person.age = 24
    self.personMap["angel"] = 54
