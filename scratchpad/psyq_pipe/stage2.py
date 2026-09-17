"""Class (b) Stage 2: the AIHigh hierarchy becomes real C++ virtuals.

Retail facts (romdis.py / vtdump.py, 2026-09-17): AIHigh tables are {null, HighExecute, dtor,
CheckForCrimes (perps) | FreezeAndEndChase (cops)}; ~AIHigh_Base is the only out-of-line dtor of
the Base chain; user-declared EMPTY dtors (BasicPerp, Player, Human, Opponent, HumanPerp) store a
vtable then jal ~Base; compiler-synthesised dtors (BasicCop, BTC_Cop, HumanCop, Wingman, Cop,
Traffic, None, BTC_Perp) store nothing; BTC_Perp's ctor is inline `{ caught_ = 1; }`, HumanPerp's
inline `{ hudActivated_ = 0; originalActivationCop_ = 0; }`; AIState_None / AIHigh_None are
declared before the derived hierarchy so aihigh's vtable batch comes out
[BTC_Perp][None][Base][AIState_None][AIState_Base] (reverse declaration order)."""
import re

D = 'C:/Temp/nfs4-decomp/recon/game/common/'
M = re.M


def rd(f):
    return open(D + f, encoding='utf-8').read()


def wr(f, s):
    open(D + f, 'w', encoding='utf-8', newline='').write(s)


def subn(s, pat, rep, n, flags=0, tag=''):
    c = len(re.findall(pat, s, flags))
    assert c == n, (tag or pat[:70], c, n)
    return re.sub(pat, rep, s, flags=flags)


def drop(s, text, tag=''):
    assert s.count(text) == 1, (tag or text[:70], s.count(text))
    return s.replace(text, '')


def cut(s, start, end, keep_end=True):
    a = s.index(start)
    b = s.index(end, a)
    return s[:a] + (s[b:] if keep_end else s[b + len(end):])


# ------------------------------------------------------------------ headers
HDRS = ['aih_hierarchy_types.h', 'aih_btccop_types.h', 'aihigh_types.h', 'aih_btcperp_types.h',
        'aih_cop_types.h', 'aih_traf_types.h', 'aih_hum_types.h', 'aih_opp_types.h',
        'aih_basicperp_types.h', 'aih_play_types.h', 'aih_basiccop_types.h']
for h in HDRS:
    s = rd(h)
    s = re.sub(r'^[ \t]*AIHigh_\w+\(\) \{\}[ \t]*\n', '', s, flags=M)
    s = re.sub(r'^#ifdef NFS4_AIH_\w+_OWNER_DTOR\n[ \t]*~AIHigh_\w+\(\);\n#endif\n', '', s, flags=M)
    s = re.sub(r'^#(?:define|undef) NFS4_AIH_\w+_OWNER_DTOR\n', '', s, flags=M)
    s = re.sub(r'^[ \t]*~AIHigh_(?:BTC_Cop|BTC_HumanCop|BTC_Wingman|Traffic|Cop|BasicCop)\(\);[ \t]*\n', '', s, flags=M)
    if h in ('aih_hierarchy_types.h', 'aih_btccop_types.h'):
        s = subn(s, r'    int schedulingOff_, lastTrafficTriggerCheckSlice_;\n    __vtbl_ptr_type \(\*_vf\)\[3\];\n',
                 '    int schedulingOff_, lastTrafficTriggerCheckSlice_;\n', 1, tag='Base _vf ' + h)
        s = subn(s, r'    ~AIHigh_Base\(\);\n',
                 '    virtual void HighExecute() = 0;\n    virtual ~AIHigh_Base();\n', 1, tag='Base dtor ' + h)
        s = subn(s, r'    AIHigh_BasicPerp\(Car_tObj \*carObj\);\n',
                 '    AIHigh_BasicPerp(Car_tObj *carObj);\n    ~AIHigh_BasicPerp() {}\n', 1, tag='BasicPerp ' + h)
        s = subn(s, r'    void CheckForCrimes\(\);', '    virtual void CheckForCrimes();', 1, tag='CheckForCrimes ' + h)
        s = subn(s, r'    AIHigh_Player\(Car_tObj \*carObj\);\n',
                 '    AIHigh_Player(Car_tObj *carObj);\n    ~AIHigh_Player() {}\n', 1, tag='Player ' + h)
        s = subn(s, r'    AIHigh_BTC_HumanCop \*originalActivationCop_;\n',
                 '    AIHigh_BTC_HumanCop *originalActivationCop_;\n'
                 '    AIHigh_BTC_Perp(Car_tObj *carObj) : AIHigh_BasicPerp(carObj) { caught_ = 1; }\n', 1, tag='BTC_Perp ' + h)
        s = subn(s, r'    void FreezeAndEndChase\(\);\n    void HudOff\(\);',
                 '    virtual void FreezeAndEndChase();\n    void HudOff();', 1, tag='FreezeAndEndChase ' + h)
    if h == 'aih_hierarchy_types.h':
        s = subn(s, r'#include "aistate_classes.h"\n\n\nstruct AIHigh_Base \{',
                 '#include "aistate_classes.h"\n\n'
                 '/* aihigh.obj-local all-inline classes.  Declared HERE (AIState_None right after the AIState family,\n'
                 '   AIHigh_None right after AIHigh_Base) because cc1plus 2.8 emits a TU\'s vtable batch in REVERSE\n'
                 '   declaration order: retail aihigh .rdata = [BTC_Perp][None][Base][AIState_None][AIState_Base]. */\n'
                 'struct AIState_None : public AIState_Base {\n'
                 '    AIState_None(Car_tObj *carObj) : AIState_Base(carObj) {}\n'
                 '    ~AIState_None() {}\n'
                 '    void Execute() {}\n'
                 '};\n\n'
                 'struct AIHigh_Base {', 1, tag='AIState_None insert')
        s = subn(s, r'        stateType_ = newStateType;\n    \}\n\};\n',
                 '        stateType_ = newStateType;\n    }\n};\n\n'
                 'struct AIHigh_None : public AIHigh_Base {\n'
                 '    AIHigh_None(Car_tObj *carObj) : AIHigh_Base(carObj) {}\n'
                 '    void HighExecute() {}\n'
                 '};\n', 1, tag='AIHigh_None insert')
    if h in ('aihigh_types.h', 'aih_btcperp_types.h'):
        s = subn(s, r'struct AIHigh_BTC_HumanPerp : public AIHigh_BTC_Perp \{\n',
                 'struct AIHigh_BTC_HumanPerp : public AIHigh_BTC_Perp {\n'
                 '    AIHigh_BTC_HumanPerp(Car_tObj *carObj) : AIHigh_BTC_Perp(carObj) {\n'
                 '        hudActivated_ = 0;\n        originalActivationCop_ = (AIHigh_BTC_HumanCop *)0;\n    }\n', 1, tag='HumanPerp ctor ' + h)
        s = subn(s, r'    ~AIHigh_BTC_HumanPerp\(\);', '    ~AIHigh_BTC_HumanPerp() {}', 1, tag='HumanPerp dtor ' + h)
    if h == 'aihigh_types.h':
        s = cut(s, 'struct AIState_None : public AIState_Base {', 'extern __vtbl_ptr_type AIHigh_None_vtable[];', keep_end=True)
        s = cut(s, 'extern __vtbl_ptr_type AIHigh_None_vtable[];', '/* Exact foreign class layouts', keep_end=True)
    wr(h, s)
    print('header', h, 'ok')

# ------------------------------------------------------------------ externs
for h in ['aih_basiccop', 'aih_basicperp', 'aih_btccop', 'aih_btcperp', 'aih_cop', 'aih_hum', 'aih_opp',
          'aih_play', 'aih_traf', 'aihigh']:
    f = h + '_externs.h'
    s = rd(f)
    s, n = re.subn(r'^extern __vtbl_ptr_type (?:AIHigh|AIState)_[^\n]*\n', '', s, flags=M)
    wr(f, s)
    print('externs', f, n)

# ------------------------------------------------------------------ TUs
CTOR = re.compile(r'^(AIHigh_\w+::AIHigh_\w+\([^)]*\))[ \t]*\n\s*\{\n((?:[^\n]*\n){0,12}?)[ \t]*\(new\(\((AIHigh_\w+) \*\)this\) \3\(([^)]*)\)\);\n'
                  r'(?:\s*this->_vf =\s*\(__vtbl_ptr_type \(\*\) ?\[3\]\)AIHigh_\w+_vtable;[^\n]*\n)?', M)
VF = re.compile(r'^[ \t]*this->_vf =\s*\(__vtbl_ptr_type \(\*\) ?\[3\]\)AIHigh_\w+_vtable;[^\n]*\n', M)
EXT = re.compile(r'^extern __vtbl_ptr_type (?:AIHigh|AIState)_[^\n]*\n', M)
counts = {}
for c in ['aihigh', 'aih_basicperp', 'aih_basiccop', 'aih_btccop', 'aih_btcperp', 'aih_cop', 'aih_hum',
          'aih_opp', 'aih_play', 'aih_traf']:
    f = c + '.cpp'
    s = rd(f)
    s, n1 = CTOR.subn(lambda m: f'{m.group(1)} : {m.group(3)}({m.group(4)})\n{{\n{m.group(2)}', s)
    if c == 'aihigh':
        s = cut(s, 'extern "C" void ___11AIHigh_None(void *);', '/* ---- aihigh.obj-owned globals', keep_end=True)
        s = subn(s, r'[ \t]*newHigh = \(AIHigh_Base \*\)operator new\(0x88\);\s*'
                    r'new\(\(AIHigh_BasicPerp \*\)newHigh\) AIHigh_BasicPerp\(carObj\);\s*'
                    r'newHigh->_vf = \(__vtbl_ptr_type \(\*\) \[3\]\)&AIHigh_kVtbl_80054dcc;\s*'
                    r'\(\(AIHigh_BTC_Perp \*\)newHigh\)->caught_ = 1;\s*'
                    r'\(\(AIHigh_BTC_Perp \*\)newHigh\)->hudActivated_ = 0;\s*'
                    r'\(\(AIHigh_BTC_Perp \*\)newHigh\)->originalActivationCop_ = \(AIHigh_BTC_HumanCop \*\)0x0;\s*'
                    r'newHigh->_vf = \(__vtbl_ptr_type \(\*\) \[3\]\)AIHigh_BTC_HumanPerp_vtable;\n',
                 '        newHigh = new AIHigh_BTC_HumanPerp(carObj);   /* inline HumanPerp/BTC_Perp ctors: caught_/hudActivated_/originalActivationCop_ */\n',
                 1, tag='HumanPerp site')
        s = subn(s, r'[ \t]*/\* vtable entry 2: fn-ptr @ byte \+20, this-delta @ byte \+16 \(byte-base, sec\.3\.12 #10\) \*/\s*'
                    r'\(\*\(int \(\*\*\)\(\.\.\.\)\)\(\(char \*\)highLevelAIObjs\[carLoop\]->_vf \+ 20\)\)\s*'
                    r'\(\(int\)&highLevelAIObjs\[carLoop\]->carObj_ \+\s*'
                    r'\(int\)\*\(short \*\)\(\(char \*\)highLevelAIObjs\[carLoop\]->_vf \+ 16\),3\);\n',
                 '        delete highLevelAIObjs[carLoop];\n', 1, tag='delete site')
        s = subn(s, r'[ \t]*/\* vtable entry 1: fn-ptr @ byte \+12, this-delta @ byte \+8 \(byte-base, sec\.3\.12 #10\) \*/\s*'
                    r'\(\*\(int \(\*\*\)\(\.\.\.\)\)\(\(char \*\)highLevelAIObjs\[carLoop\]->_vf \+ 12\)\)\s*'
                    r'\(\(int\)&highLevelAIObjs\[carLoop\]->carObj_ \+\s*'
                    r'\(int\)\*\(short \*\)\(\(char \*\)highLevelAIObjs\[carLoop\]->_vf \+ 8\)\);\n',
                 '        highLevelAIObjs[carLoop]->HighExecute();\n', 1, tag='HighExecute site')
        s = subn(s, r'/\* ---- _\._15AIHigh_BTC_Perp  AIHigh_BTC_Perp::dtor.*?AIHigh_BTC_Perp::~AIHigh_BTC_Perp\(\)\n\{\n[^\n]*\n\}\n',
                 '', 1, re.S, tag='BTC_Perp dtor copy')
        s = subn(s, r'/\* ---- HighExecute__11AIHigh_None.*?AIHigh_None::~AIHigh_None\(\)\s*\{\s*return;\s*\}\n', '', 1, re.S, tag='None defs')
    if c == 'aih_btccop':
        s = subn(s, r'[ \t]*\(\*\*\(int \(\*\*\)\(\.\.\.\)\)\(\(int\)\*this->_vf \+ 0x1c\)\)\s*'
                    r'\(\(int\)&this->carObj_ \+ \(int\)\*\(short \*\)\(\(int\)\*this->_vf \+ 0x18\)\);\n',
                 '    this->FreezeAndEndChase();\n', 1, tag='FreezeAndEndChase site')
        s = subn(s, r'/\* ---- _\._18AIHigh_BTC_Wingman  AIHigh_BTC_Wingman::dtor.*?AIHigh_BTC_Cop::~AIHigh_BTC_Cop\(\)\n\{\n\}\n', '', 1, re.S, tag='btccop dtors')
    if c == 'aih_btcperp':
        # the manual chain called the BasicPerp ctor directly (BTC_Perp had none); the real base is BTC_Perp
        s = subn(s, r'AIHigh_BTC_AIPerp::AIHigh_BTC_AIPerp\(Car_tObj \*carObj\) : AIHigh_BasicPerp\(carObj\)',
                 'AIHigh_BTC_AIPerp::AIHigh_BTC_AIPerp(Car_tObj *carObj) : AIHigh_BTC_Perp(carObj)', 1, tag='AIPerp base')
        s = subn(s, r'(AIHigh_BTC_AIPerp::AIHigh_BTC_AIPerp\(Car_tObj \*carObj\) : AIHigh_BTC_Perp\(carObj\)\s*\{\s*)this->caught_ = 1;[ \t]*\n',
                 r'\1', 1, tag='AIPerp caught_')
        s = subn(s, r'/\* ---- _\._20AIHigh_BTC_HumanPerp  AIHigh_BTC_HumanPerp::dtor.*?  ___11AIHigh_Base_1arg\(pThis\);\n\n  return;\n\n\}\n', '', 1, re.S, tag='btcperp dtor blocks')
    if c == 'aih_play':
        s = subn(s, r'[ \t]*\(\*\*\(int \(\*\*\)\(\.\.\.\)\)\(\(char \*\)this->_vf \+ 28\)\)\s*'
                    r'\(\(int\)this \+ \*\(short \*\)\(\(char \*\)this->_vf \+ 24\)\);\n',
                 '  this->CheckForCrimes();\n', 1, tag='CheckForCrimes site')
        s = subn(s, r'/\* ---- ___13AIHigh_Player  AIHigh_Player::~AIHigh_Player.*?AIHigh_Player::~AIHigh_Player\(\)\n\{\n[^\n]*\n\}\n', '', 1, re.S, tag='Player dtor')
    if c == 'aih_basicperp':
        s = subn(s, r'/\* The real member destructor restores its own dispatch table.*?AIHigh_BasicPerp::~AIHigh_BasicPerp\(\)\n\{\n[^\n]*\n\}\n', '', 1, re.S, tag='BasicPerp dtor')
    if c in ('aih_basiccop', 'aih_cop', 'aih_traf'):
        cls = {'aih_basiccop': 'AIHigh_BasicCop', 'aih_cop': 'AIHigh_Cop', 'aih_traf': 'AIHigh_Traffic'}[c]
        s = subn(s, cls + r'::~' + cls + r'\(\)\n\{\n\}\n', '', 1, tag='synth dtor ' + c)
    s, n2 = VF.subn('', s)
    s, n3 = EXT.subn('', s)
    counts[c] = (n1, n2, n3)
    wr(f, s)
    print('tu', c, 'ctor chains', n1, 'vf stores', n2, 'externs', n3)
assert sum(v[0] for v in counts.values()) == 11, counts
