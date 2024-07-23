b: public(bool)
pNum: public(uint256)
nNum: public(int128)
dec: public(decimal)
name: public(String[100])
b32: public(bytes32)
EthAddress: public(address)

@external
def __init__():
    self.b = True
    self.pNum = 212313123213
    self.nNum = -345353
    self.dec = 13.324234242
    self.name = "Ben Awad"
    self.EthAddress = 0x71C7656EC7ab88b098defB751B7401B5f6d8976F
    self.b32 = 0xada1b75f8ae9a65dcc16f95678ac203030505c6b465c8206e26ae84b525cdacb
