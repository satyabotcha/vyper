# @version 0.2.8


event Received:
    sender: indexed(address)
    bal: uint256 # balance of the contract
    value: uint256
    gasLeft: uint256

@external
@pure
def greet(message: String[50]) -> String[100]:
    return (concat("Hello ", message))

# this function will run when 1) there is no other function with the given name 2) when paying/depositing ether to this contract
@external
@payable
def __default__():
    log Received(msg.sender, self.balance, msg.value, msg.gas)

