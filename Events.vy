# @version 0.2.8

event Transfer:
    sender: indexed(address)
    receiver: indexed(address)
    value: indexed(uint256)

@external
def transferEther(_receiver: address, _value: uint256):
    log Transfer(msg.sender, _receiver, _value)

