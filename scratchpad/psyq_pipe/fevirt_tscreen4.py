"""fevirt_tscreen.py phase 2d: remaining structural fixes.
  * virtuals introduced BELOW the root, declared first in each introducing class and in retail SLOT order:
      tScreenCarSelect           [10] DrawVideoWall(short) [11] InitializeVideoWall [12] UpdateVideoWall(tCarInfo&)
                                 [13] GetCar(tCarInfo&) [14] AllocateAsyncBuffer [15] FreeAsyncBuffer
      tScreenCarSelectTwoPlayer  [16] TurnOffVideoWall [17] SetDialog      tScreenCarSelectDuel [16] DrawOpponentVideoWall(short)
      tScreenCongrats            [10] CalculatePrizes [11] DrawCongratsMessage = 0 [12] GetCar(tCarInfo&)
      tDialogBase                [10] CalculateDimensions = 0 [11] Draw
  * header facades / inline ctors that still touched `_vf`; extern table lists; two over-eager `&` strips; slot 16/17 sites."""
import glob
import re

R = 'C:/Temp/nfs4-decomp/recon/frontend/common/'
NL = chr(10)


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


def class_virtuals(text, cls, decls, removes):
    m = re.search(r'^struct ' + cls + r'\b[^{;]*\{\n', text, re.M)
    if not m:
        return text, False
    i, depth = m.end(), 1
    while depth:
        depth += text[i] == '{'
        depth -= text[i] == '}'
        i += 1
    body = text[m.end():i]
    for r in removes:
        body = re.sub(r'^[ \t]*' + r + r'[^\n]*\n', '', body, flags=re.M)
    block = '    /* virtuals introduced by this class, in retail slot order (real virtuals since 2026-09-20) */' + NL + ''.join('    ' + d + NL for d in decls)
    return text[:m.end()] + block + body + text[i:], True


SPEC = {
    'tScreenCarSelect': (['virtual void DrawVideoWall(short);', 'virtual void InitializeVideoWall();', 'virtual void UpdateVideoWall(tCarInfo &);',
                          'virtual bool GetCar(tCarInfo &);', 'virtual void AllocateAsyncBuffer();', 'virtual void FreeAsyncBuffer();'],
                         [r'void DrawVideoWall\(short\);', r'void InitializeVideoWall\(\);', r'void UpdateVideoWall\(tCarInfo &\);',
                          r'bool GetCar\(tCarInfo &\);', r'void AllocateAsyncBuffer\(\);', r'void FreeAsyncBuffer\(\);']),
    'tScreenCarSelectTwoPlayer': (['virtual void TurnOffVideoWall();', 'virtual void SetDialog();'], [r'void TurnOffVideoWall\(\);', r'void SetDialog\(\);']),
    'tScreenCarSelectDuel': (['virtual void DrawOpponentVideoWall(short);'], [r'void DrawOpponentVideoWall\(short\);']),
    'tScreenCongrats': (['virtual void CalculatePrizes();', 'virtual void DrawCongratsMessage() = 0;', 'virtual bool GetCar(tCarInfo &);'],
                        [r'void CalculatePrizes\(\);', r'void DrawCongratsMessage\(\);', r'bool GetCar\(tCarInfo &\);']),
}
for h in sorted(glob.glob(R + '*_types.h')):
    t = open(h, encoding='utf-8').read()
    o = t
    for cls, (decls, removes) in SPEC.items():
        if re.search(r'^struct ' + cls + r'\b[^{;]*\{\n', t, re.M) and re.search(removes[0], t):
            t, _ = class_virtuals(t, cls, decls, removes)
    # header facades and inline ctors
    t = re.sub(r'inline void CalculateDimensionsVirtual\(\) \{\n[^}]*\}', 'inline void CalculateDimensionsVirtual() { CalculateDimensions(); }', t)
    t = re.sub(r'inline void ProcessInputVirtual\(tPlayer player, tInputKeyType &key,\s*tMenuCommand &command\) \{\n[^}]*\}',
               'inline void ProcessInputVirtual(tPlayer player, tInputKeyType &key, tMenuCommand &command) { ProcessInput(player, key, command); }', t)
    t = re.sub(r'inline tDialogYesNoTri\(\) \{\n\s*_vf = \(__typeof__\(_vf\)\)&tDialogYesNoTri_vtable;\n\s*\}', 'inline tDialogYesNoTri() {}', t)
    if t != o:
        open(h, 'w', encoding='utf-8', newline='').write(t)
        print('ok', h.replace('\\', '/').split('/')[-1])

s = rd('fedialog_externs.h')
s = re.sub(r'extern __vtbl_ptr_type tDialogBase_vtable\[\][^;]*;[^\n]*\n', '', s)
wr('fedialog_externs.h', s)

s = rd('front.cpp')
s, n = re.subn(r'CarDialog\(\(_vf = \(__typeof__\(_vf\)\)tScreenCarSelectTwoPlayer_vtable, 0\)\)', 'CarDialog(0)', s)
assert n == 1
wr('front.cpp', s)

s = rd('fescreen.cpp')
s, n = re.subn(r'this->GetShapeInfo\(numPermShapes,numSwapShapes,permFileName,swapFileName\);',
               'this->GetShapeInfo(numPermShapes,numSwapShapes,&permFileName,&swapFileName);', s)
assert n == 2, n
wr('fescreen.cpp', s)

s = rd('feapp.cpp')
s, n = re.subn(r'->ProcessInput\(i,keyVal \+ i,command \+ i\);', '->ProcessInput((tPlayer)i,keyVal[i],command[i]);', s)
assert n == 2, n
wr('feapp.cpp', s)

s = rd('screencarselect.cpp')
s, n1 = re.subn(r'\(\*vtbl\[1\]\[6\]\.pfn\)\s*\(vtbl\[1\]\[6\]\.delta \+ -0x14 \+ this->fPermShapes\.fFilename\)', 'this->TurnOffVideoWall()', s)
s, n2 = re.subn(r'\(\*vtbl\[1\]\[7\]\.pfn\)\s*\(vtbl\[1\]\[7\]\.delta \+ -0x14 \+ this->fPermShapes\.fFilename\)', 'this->SetDialog()', s)
print('slot16/17 sites:', n1, n2)
wr('screencarselect.cpp', s)
