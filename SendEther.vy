# @version 0.2.8
from . import ReceiveEther as OtherContract


interface ReceiveEther:
    def greet(message: String[50]) -> String[100]: pure


@external
@payable
def sendEther(to: address, message: String[50]):
    OtherContract(to).greet(message)
    send(to, msg.value)