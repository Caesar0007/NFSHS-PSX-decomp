#!/usr/bin/env python3
"""Fix the DrawQuad after-anchor to match A20's numeric-register asm
($t4 -> $12) -- the only ABI-register-named anchor tree-wide."""
import ast

src = open('tools/build.py', encoding='utf-8', newline='').read()
needle = '\\$t4,0\\(\\$2\\)'
assert src.count(needle) == 1, src.count(needle)
src = src.replace(needle, '\\$12,0\\(\\$2\\)')
ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('anchor updated + parses')
