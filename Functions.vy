# @version 0.2.8

message: public(String[10])
value: public(uint256)

@external # can be called by transactions or other contracts
@pure # cannot read or write data to the blockchain
def simpleFunction (name: String[10], age: uint256, opposite: bool) -> (String[50], uint256, bool):
    return (concat("Hello ", name), age + 10, not opposite)
    
@internal #function can only be called by other functions within this contract
@view #can only read state variables (a.k.a data on blockchain)
def multiply (x: uint256, y: uint256) -> (uint256, bool):
    return (x * y, True)

@external
@view
def calculate(x: uint256, y: uint256) -> (uint256, bool):
    num: uint256 = 0
    b: bool = False
    (num, b) = self.multiply(x, y)
    return (num, b)

@external #can be called by transaction or other contracts + can read and write to blockchain -> cannot accept ether
def updateMessage(_message: String[10]):
    self.message = _message

@external
@payable
def receiveEther():
    self.value = msg.value