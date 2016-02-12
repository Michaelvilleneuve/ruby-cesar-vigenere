require_relative 'Cesar'
require_relative 'Vigenere'  

# Decrypt JP's phrase
vigenere = Vigenere.new
result = vigenere.encrypt "phraseaencrypter", with_key = "cle"
#vigenere.decrypt result, with_key = "cle"

vigenere.yield
