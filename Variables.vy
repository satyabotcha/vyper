# @version 0.2.8

TOTAL_SUPPLY: constant(uint256) = 21000000 # value cannot be changed
totalSupply: public(uint256)
totalCirculation: public(uint256)

name: public(String[10]) # public: anyone can call and view this value
password: String[20] #private: the value can only be modified within this contract

@external
def __init__():
    self.totalSupply = TOTAL_SUPPLY


@external
@payable
def issueMoney() -> uint256:
    self.totalCirculation -= 1
    return 1




