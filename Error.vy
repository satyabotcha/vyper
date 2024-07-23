# @version 0.2.8

message: public(String[10])
owner: public(address)

@external
def __init__():
    self.message = "Initial"
    self.owner = msg.sender

@internal 
def setMessage(_message: String[10], sender: address):
    # check if the transaction sender is the owner of this contract
    if sender != self.owner:
        # if not raise an error and abort the transaction
        raise "You are not authorised to change the message" 
    self.message = _message 

@external
def callSetMessage(_message: String[10]):
    # if the return value of this function raises an error -> the state is reverted and the transaction is stopped
    self.setMessage(_message, msg.sender)
    self.message = "approved"
