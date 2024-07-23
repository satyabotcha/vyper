# @version 0.2.8

# state variables
holderBalance: HashMap[address, uint256]
spendingAllowed: public(HashMap[address, HashMap[address, uint256]]) # keep track of how much the owner approved for each spender
coinsInCirculation: public(uint256)


# constants
TOKEN_NAME: constant(String[20]) = "DanCoin"
TOKEN_SYMBOL: constant(String[5]) = "DC"
TOTAL_SUPPLY: constant(uint256) = 100


# events
event Transfer:
    _from: indexed(address)
    _to: indexed(address)
    _value: uint256

event Approval:
    _owner: indexed(address)
    _spender: indexed(address)
    _value: uint256

@external
def __init__():
    self.coinsInCirculation = 0


@external
@payable
def deposit():
    # check if the total coins in circulation reached the total supply
    if  as_wei_value((TOTAL_SUPPLY - self.coinsInCirculation), "ether")  < msg.value :
        raise "cannot issue more tokens"

    # add/update the token holder balance
    self.holderBalance[msg.sender] = self.holderBalance[msg.sender] + msg.value

    # update the coin in circulaton variable
    self.coinsInCirculation += msg.value

    # log the transfer event
    log Transfer(0x0000000000000000000000000000000000000000, msg.sender, msg.value)



# function to check the name of the token
@external
@view
def name() -> String[20]:
    return (TOKEN_NAME)

# function to check the name of the token symbol
@external
@view
def symbol() -> String[5]:
    return (TOKEN_SYMBOL)

# function to check the total supply of this token
@external
@view
def totalSupply() -> uint256:
    return (TOTAL_SUPPLY)


# function to check balance of the holder
@external
@view
def balanceOf(_owner: address) -> uint256:
    return self.holderBalance[_owner]

# function to transfer tokens from the holder to another address
@external
def  transfer(_to: address, _value: uint256) -> bool:
    # fetch the current balance of the sender
    senderBalance: uint256 = self.holderBalance[msg.sender]
    
    # check if they have sufficent balance
    if senderBalance < _value:
        raise "insufficent balance"
    
    # balance is available -> procced to transfer
    send(_to, _value)

    # deduct the money from their account
    self.holderBalance[msg.sender] = senderBalance - _value

    # update the receivers balance 
    self.holderBalance[_to] = self.holderBalance[_to] + _value

     # log the transfer event
    log Transfer(msg.sender, _to, _value)

    return True


# function that allows how much can a 3rd party (exchanges) spend on behalf of the owner
@external
def approve(_spender: address, _value: uint256) -> bool:

    # add the transaction to apporved hashmap -> Alice approves Bob to spend X amount of tokens on behalf of her
    self.spendingAllowed[msg.sender][_spender] = _value

    # log the approval event
    log Approval(msg.sender, _spender, _value)

    return True

# function to check how much the 3rd party (exchanges)can spend on behalf of the owner as approved by the "approved" function
@view
@external
def allowance(_owner: address, _spender: address) -> uint256:
    return (self.spendingAllowed[_owner][_spender])

# function which transfers token "from" address "to" any address as long as the amount does not exceed the approved account
@external
def  transferFrom(_from:address, _to: address, _value: uint256) -> bool:

    # fetch the current balance of the token holder
    senderBalance: uint256 = self.holderBalance[_from]
    
    # check if they have sufficent balance
    if senderBalance < _value:
        raise "insufficent balance"
    
    # balance is available -> procced to allowance check

    # check if the token holder approved the transaction
    if self.spendingAllowed[_from][_to]  != _value or self.spendingAllowed[_from][_to] < _value:
        raise "transaction not approved"

    # transaction approved
    send(_to, _value)

    # remove the allowance for the spender
    self.spendingAllowed[_from][_to] = empty(uint256)

    # deduct the money from their account
    self.holderBalance[msg.sender] = senderBalance - _value

    # log the transfer event
    log Transfer(_from, _to, _value)

    return True