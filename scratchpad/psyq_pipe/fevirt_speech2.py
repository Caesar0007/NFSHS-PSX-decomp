"""fevirt_speech.py phase 2: real inheritance + real constructors, hand tables removed.
  * MobileSpeaker / DispatchSpeaker derive from Speaker (the `_base_Speaker` composition member goes; 548 uses rewritten);
  * retail's Speech::Speech() does  new; [Speaker vptr]; fSub = 0; [derived vptr]; (fCarObj = 0)  -- i.e. inline constructors
    `Speaker() { fSub = 0; }`, `DispatchSpeaker() {}`, `MobileSpeaker() { fCarObj = 0; }` and plain `new` expressions;
  * the three 31-slot tables at the end of speech.cpp and their externs are deleted."""
import glob
import re

R = 'C:/Temp/nfs4-decomp/recon/game/common/'
NL = chr(10)


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


h = rd('speech_types.h')
for cls, ctor in (('MobileSpeaker', '    MobileSpeaker() { fCarObj = 0; }'), ('DispatchSpeaker', '    DispatchSpeaker() {}')):
    a = 'struct %s {' % cls + NL + '    Speaker _base_Speaker;' + NL
    assert h.count(a) == 1, cls
    h = h.replace(a, 'struct %s : public Speaker {' % cls + NL + '    /* inline ctor: retail\'s Speech::Speech() shows it expanded in place */' + NL + ctor + NL)
a = '#include "speech_speaker_virtuals.inc"' + NL
assert h.count(a) == 1
h = h.replace(a, '    Speaker() { fSub = 0; }   /* inline: retail stores the Speaker table, zeroes fSub, then stores the derived table */' + NL + a)
wr('speech_types.h', h)

tot = 0
for f in sorted(glob.glob(R + '*.cpp') + glob.glob(R + '*.h')):
    s = open(f, encoding='utf-8').read()
    if '_base_Speaker' not in s:
        continue
    o = s
    s = re.sub(r'\(([^()]+?)->_base_Speaker\)\.', r'\1->', s)
    s = re.sub(r'\(([^()]+?)\._base_Speaker\)\.', r'\1.', s)
    s = s.replace('->_base_Speaker.', '->').replace('._base_Speaker.', '.')
    s = re.sub(r'&\(?([A-Za-z_][\w\[\]>\-\.]*?)->_base_Speaker\)?(?![\w.])', r'(Speaker *)\1', s)
    s = re.sub(r'&([A-Za-z_][\w\[\]>\-\.]*?)\._base_Speaker(?![\w.])', r'(Speaker *)&\1', s)
    if s != o:
        tot += o.count('_base_Speaker') - s.count('_base_Speaker')
        open(f, 'w', encoding='utf-8', newline='').write(s)
print('_base_Speaker uses rewritten:', tot)

s = rd('speech.cpp')
old = re.search(r'  DispatchSpeaker \*dispatch =\s*\(DispatchSpeaker \*\)__builtin_new\(sizeof\(DispatchSpeaker\)\);\n(?:  dispatch->[^\n]*\n){3}', s)
assert old, 'dispatch block'
s = s.replace(old.group(0), '  DispatchSpeaker *dispatch = new DispatchSpeaker;' + NL)
old = re.search(r'    MobileSpeaker \*mobile =\s*\(MobileSpeaker \*\)__builtin_new\(sizeof\(MobileSpeaker\)\);\n(?:    mobile->[^\n]*\n){4}', s)
assert old, 'mobile block'
s = s.replace(old.group(0), '    MobileSpeaker *mobile = new MobileSpeaker;' + NL)
a = s.index('const __vtbl_ptr_type MobileSpeaker_vtable[31]')
b = s.index('};', s.index('const __vtbl_ptr_type Speaker_vtable[31]')) + 2
s = s[:a] + '/* (2026-09-20) the three hand-written 31-slot tables that stood here are gone: the compiler emits them. */' + s[b:]
wr('speech.cpp', s)
x = rd('speech_externs.h')
x = re.sub(r'^extern const __vtbl_ptr_type \w+_vtable\[\] __asm__\("[^"]*"\);\n', '', x, flags=re.M)
wr('speech_externs.h', x)
