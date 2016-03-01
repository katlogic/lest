local loadstring = loadstring or load
assert("\x4f\x7e" == "O~")
assert("\79\126" == "O~")
assert(loadstring[[return "\xxx"]] == nil)
assert(loadstring[[return "\xxx"]] == nil)
assert(assert(loadstring[[return "abc   \z

   def"]])() == "abc   def")
