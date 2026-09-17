"""Class (b) Stage 2b (2026-09-17).  Facts (probes build/psyq/probe/vt3-vt7.i): cc1plus 2.8 emits an
out-of-line copy of EVERY inline member (used or not, in-class or `inline` out-of-class) of a class
whose key function is defined in the TU; a non-member `static inline` helper gets no copy.  Retail
aihigh.obj has no SetState/GetCarObj copies, aistate.obj no Idle-ctor copy, aih_btcperp.obj no
HumanPerp-ctor copy -- while the vtable-needed inline virtual dtors ARE there (so it is not
-fno-implement-inlines, which drops those too).  Model: SetState/GetCarObj = non-member inline
helpers; the Idle / HumanPerp inline ctors are defined where they are used, out of the key TU's view.
Also: every AI object's .rodata opens with the unreferenced "SimpleMem" literal (expansion-time, in
the first non-leaf function) -> rows move 16 bytes down (aih_traf 12: its coorddef initializer sits
between the literal and the 8-aligned vtable)."""
import json
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


# ---------------------------------------------------- 1. SetState / GetCarObj -> non-member helpers
OLD_MEMBERS = ('    Car_tObj *GetCarObj() { return carObj_; }\n'
               '    void StateExecute();\n'
               '    void SetState(AIState_Base *newState, stateType_t newStateType) {\n'
               '        AIState_Base *oldState = state_;\n'
               '        if (oldState != (AIState_Base *)0) {\n'
               '            delete oldState;   /* virtual ~AIState_Base with __in_chrg 3 */\n'
               '        }\n'
               '        state_ = newState;\n'
               '        stateType_ = newStateType;\n'
               '    }\n'
               '};\n')
NEW_MEMBERS = ('    void StateExecute();\n'
               '};\n'
               '\n'
               '/* Non-member inline helpers, not members: retail aihigh.obj (the key-function TU of AIHigh_Base,\n'
               '   ~AIHigh_Base) carries no out-of-line SetState/GetCarObj copies, and cc1plus 2.8 always emits\n'
               '   copies of a key-function class\'s inline MEMBERS there (probe build/psyq/probe/vt3.i). */\n'
               'static inline void AIHigh_SetState(AIHigh_Base *high, AIState_Base *newState, stateType_t newStateType) {\n'
               '    AIState_Base *oldState = high->state_;\n'
               '    if (oldState != (AIState_Base *)0) {\n'
               '        delete oldState;   /* virtual ~AIState_Base with __in_chrg 3 */\n'
               '    }\n'
               '    high->state_ = newState;\n'
               '    high->stateType_ = newStateType;\n'
               '}\n'
               'static inline Car_tObj *AIHigh_GetCarObj(AIHigh_Base *high) { return high->carObj_; }\n')
for h in ('aih_hierarchy_types.h', 'aih_btccop_types.h'):
    s = rd(h)
    assert s.count(OLD_MEMBERS) == 1, h
    s = s.replace(OLD_MEMBERS, NEW_MEMBERS)
    wr(h, s)

CALL_SS = re.compile(r'(\b(?:this|\w+)\s*->\s*|\b)SetState\(')
CALL_GC = re.compile(r'(\(?[\w\[\]\.]+(?:\s*->\s*|\.)?)?(?:this\s*->\s*)?GetCarObj\(\)')


def fix_calls(s):
    # X->SetState(a, b)  /  SetState(a, b)   ->  AIHigh_SetState(X, a, b)  /  AIHigh_SetState(this, a, b)
    def r1(m):
        recv = m.group(1).strip()
        recv = recv[:-2].strip() if recv.endswith('->') else 'this'
        return f'AIHigh_SetState({recv}, '
    s, n1 = CALL_SS.subn(r1, s)
    # X->GetCarObj()  /  this->GetCarObj()  ->  AIHigh_GetCarObj(X)  /  AIHigh_GetCarObj(this)
    def r2(m):
        return m.group(0)
    out = []
    n2 = 0
    for line in s.split('\n'):
        while 'GetCarObj()' in line:
            i = line.index('GetCarObj()')
            j = i
            # walk back over the receiver expression: `expr->` or `this->`
            k = i
            assert line[k - 2:k] == '->', line
            k -= 2
            depth = 0
            while k > 0:
                c = line[k - 1]
                if c in ')]':
                    depth += 1
                elif c in '([':
                    if depth == 0:
                        break
                    depth -= 1
                elif depth == 0 and not (c.isalnum() or c in '_.>-'):
                    break
                k -= 1
            recv = line[k:i - 2]
            line = line[:k] + f'AIHigh_GetCarObj({recv})' + line[i + len('GetCarObj()'):]
            n2 += 1
        out.append(line)
    return '\n'.join(out), n1, n2


TUS = ['aihigh', 'aih_basicperp', 'aih_basiccop', 'aih_btccop', 'aih_btcperp', 'aih_cop', 'aih_hum',
       'aih_opp', 'aih_play', 'aih_traf']
tot1 = tot2 = 0
for c in TUS:
    s = rd(c + '.cpp')
    s, n1, n2 = fix_calls(s)
    tot1 += n1
    tot2 += n2
    wr(c + '.cpp', s)
    print('calls', c, n1, n2)
assert tot1 == 57 and tot2 == 14, (tot1, tot2)

# ---------------------------------------------------- 2. Idle / HumanPerp inline ctors out of the key TU's view
s = rd('aistate_classes.h')
s = subn(s, r'    AIState_Idle\(Car_tObj \*carObj\) : AIState_Base\(carObj\) \{\}[^\n]*\n',
         '    AIState_Idle(Car_tObj *carObj);   /* inline, defined in aih_hierarchy_types.h: retail aistate.obj (the key TU, Execute) has NO copy */\n',
         1, tag='Idle ctor decl')
wr('aistate_classes.h', s)
IDLE_DEF = ('\n/* AIState_Idle\'s empty inline ctor lives HERE, not in aistate_classes.h: aistate.obj (Idle\'s key-function\n'
            '   TU) carries no out-of-line copy, which cc1plus 2.8 would emit for any inline member it can see. */\n'
            'inline AIState_Idle::AIState_Idle(Car_tObj *carObj) : AIState_Base(carObj) {}\n')
for h in ('aih_hierarchy_types.h', 'aih_btccop_types.h'):
    s = rd(h)
    s = subn(s, r'#include "aistate_classes.h"\n', '#include "aistate_classes.h"\n' + IDLE_DEF, 1, tag='Idle def ' + h)
    wr(h, s)
HP_INLINE = '    AIHigh_BTC_HumanPerp(Car_tObj *carObj) : AIHigh_BTC_Perp(carObj) {}\n'
for h in ('aihigh_types.h', 'aih_btcperp_types.h'):
    s = rd(h)
    s = subn(s, re.escape(HP_INLINE), '    AIHigh_BTC_HumanPerp(Car_tObj *carObj);\n', 1, tag='HumanPerp decl ' + h)
    if h == 'aihigh_types.h':
        s = subn(s, r'(struct AIHigh_BTC_HumanPerp : public AIHigh_BTC_Perp \{\n(?:[^\n]*\n)*?\};\n)',
                 r'\1' + '/* defined only for aihigh (its sole user): aih_btcperp.obj, HumanPerp\'s key TU, has no copy */\n'
                 'inline AIHigh_BTC_HumanPerp::AIHigh_BTC_HumanPerp(Car_tObj *carObj) : AIHigh_BTC_Perp(carObj) {}\n',
                 1, tag='HumanPerp def')
    wr(h, s)

# ---------------------------------------------------- 3. "SimpleMem" heads
FIRST = {'aihigh': 'void AIHigh_StartUp(void)', 'aih_basicperp': 'void AIHigh_BasicPerp::CheckForCrimes()',
         'aih_basiccop': 'AIHigh_BasicCop::AIHigh_BasicCop(Car_tObj *carObj,int copIndex) : AIHigh_Base(carObj)',
         'aih_btccop': 'AIHigh_BTC_Cop::AIHigh_BTC_Cop(Car_tObj *carObj,int copIndex) : AIHigh_BasicCop(carObj,copIndex)',
         'aih_btcperp': 'void AIHigh_BTC_Perp::ReleaseCops()', 'aih_play': 'int AIHigh_Player::CheckIfABlockadeCanBeSetup()',
         'aih_hum': 'void AIHigh_Human::HighExecute()', 'aih_opp': 'int AIHigh_Opponent::DoRearEnder()',
         'aih_cop': 'AIHigh_Cop::AIHigh_Cop(Car_tObj *carObj,int copIndex) : AIHigh_BasicCop(carObj,copIndex)',
         'aih_traf': 'AIHigh_Traffic::CheckForCops(int *closestDistance)'}
for c, sig in FIRST.items():
    s = rd(c + '.cpp')
    i = s.index(sig)
    j = s.index('{', i) + 1
    s = (s[:j] + '\n  /* retail: this object\'s .rodata opens with the UNREFERENCED "SimpleMem" tag (expansion-time literal of the\n'
         '     first non-leaf function, ahead of the vtable batch) */\n  if (0) sprintf((char *)0,"SimpleMem");\n' + s[j:])
    inc = [m.end() for m in re.finditer(r'^#include[^\n]*\n', s, M)][-1]
    s = s[:inc] + 'extern "C" int sprintf(char *, const char *, ...);\n' + s[inc:]
    wr(c + '.cpp', s)
print('SimpleMem heads added')

# ---------------------------------------------------- 4. rows
p = 'C:/Temp/nfs4-decomp/linkers/nfs4_recon.rodata_placement.json'
rows = json.load(open(p))
for r in rows:
    tu = r['obj'].split('/')[-1][:-6]
    if tu in TUS:
        d = 12 if tu == 'aih_traf' else 16
        r['base'] -= d
        r['size'] += d
        r['end'] = r['base'] + r['size']
        print('row', tu, hex(r['base']), hex(r['size']))
json.dump(rows, open(p, 'w'), indent=1)
