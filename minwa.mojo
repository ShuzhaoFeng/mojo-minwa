fn fwrite(
    _ptr: Pointer[UInt8], _size: UInt64, _nitems: UInt64, _stream: Pointer[FILE]
) -> UInt64:
    return external_call[
        "fwrite", UInt64, Pointer[UInt8], UInt64, UInt64, Pointer[FILE]
    ](_ptr, _size, _nitems, _stream)

# high-level functions for write and append

fn writefile(x: String, fname: String) -> UInt64:
    let f = File(fname, "w")
    return fwrite(to_char_ptr(x), 1, len(x), f.handle)

fn appendfile(x: String, fname: String) -> UInt64:
    let f = File(fname, "a")
    return fwrite(to_char_ptr(x), 1, len(x), f.handle)

# The code below is selected and extracted from Lukas Hermann's repo at: https://github.com/lsh/shims.

# MIT License
# 
# Copyright (c) 2023 Lukas Hermann
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

alias c_char = UInt8

alias FILE = UInt64

struct File:
    var handle: Pointer[UInt64]
    var fname: Pointer[c_char]
    var mode: Pointer[c_char]

    fn __init__(inout self, _fname: String, _mode: String):
        let fname = to_char_ptr(_fname)
        let mode = to_char_ptr(_mode)
        let handle = fopen(fname, mode)

        self.fname = fname
        self.mode = mode
        self.handle = handle
    
    fn __del__(owned self) raises:
        if self.handle:
            pass
            # TODO: uncomment when external_call resolution bug is fixed
            # let c = fclose(self.handle)
            # if c != 0:
            #     raise Error("Failed to close file")
        if self.fname:
            self.fname.free()
        if self.mode:
            self.mode.free()
        

fn to_char_ptr(s: String) -> Pointer[c_char]:
    """Only ASCII-based strings."""
    let ptr = Pointer[c_char]().alloc(len(s) + 1)
    for i in range(len(s)):
        ptr.store(i, ord(s[i]))
    ptr.store(len(s), ord("\0"))
    return ptr

fn fopen(_filename: Pointer[UInt8], _mode: Pointer[UInt8]) -> Pointer[FILE]:
    return external_call["fopen", Pointer[FILE], Pointer[UInt8], Pointer[UInt8]](
        _filename, _mode
    )

fn fclose(arg: Pointer[FILE]) -> Int32:
    return external_call["fclose", Int32](arg)
