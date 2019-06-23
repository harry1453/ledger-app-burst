#!/usr/bin/env python
# *******************************************************************************
# *   Ledger Blue
# *   (c) 2016 Ledger
# *
# *  Licensed under the Apache License, Version 2.0 (the "License");
# *  you may not use this file except in compliance with the License.
# *  You may obtain a copy of the License at
# *
# *      http://www.apache.org/licenses/LICENSE-2.0
# *
# *  Unless required by applicable law or agreed to in writing, software
# *  distributed under the License is distributed on an "AS IS" BASIS,
# *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# *  See the License for the specific language governing permissions and
# *  limitations under the License.
# ********************************************************************************
from ledgerblue.comm import getDongle
from ledgerblue.commException import CommException
import codecs

textToSign = ""
#while True:
#    data = input("Enter text to sign, end with an empty line : ")
#    if len(data) == 0:
#        break
#    textToSign += data + "\n"
textToSign = input("Enter text: ")
print("textToSign: " + textToSign)

dongle = getDongle(True)
publicKey = dongle.exchange(codecs.decode("8004000000", "hex"))
print("publicKey " + str(codecs.encode(publicKey, "hex")))
try:
    offset = 0
    while offset != len(textToSign):
        if (len(textToSign) - offset) > 255: # if we cannot send everything that is left
            chunk = textToSign[offset: offset + 255] # take next chunk
        else: # we can send everything left
            chunk = textToSign[offset:] # take everything left
        if (offset + len(chunk)) == len(textToSign):
            p1 = "80" # final chunk
        else:
            p1 = "00" # not final chunk
        apdu = "8002"
        apdu += p1
        apdu += codecs.encode(chr(0x00).encode(), "hex").decode()
        apdu += codecs.encode(chr(len(chunk)).encode(), "hex").decode()
        apdu += codecs.encode(chunk.encode("utf-8"), "hex").decode()
        signature = dongle.exchange(codecs.decode(apdu, "hex"))
        offset += len(chunk)
        print("signature " + str(codecs.encode(signature, "hex")))
# publicKey = PublicKey(bytes(publicKey), raw=True)
# signature = publicKey.ecdsa_deserialize(bytes(signature))
# print("verified " + str(publicKey.ecdsa_verify(bytes(textToSign), signature)))
except CommException as comm:
    if comm.sw == 0x6985:
        print("Aborted by user")
    else:
        print("Invalid status " + comm.sw)
