"""Real C++ virtuals, step 1 (2026-09-19): the AIDataRecord family (one TU, six classes) -- replaces
recon/game/common/vtables_aidatarecord.cpp (hand tables) and the manual `_vf` dispatch in aidatarecord.cpp.
Retail evidence:
  * vtables 0x8005542C..0x800554C4 in order CarTracking, CurveSpeedTable, TrackCurve, BestLine, AccTable, base
    = REVERSE declaration order  =>  classes are declared base, AccTable, BestLine, TrackCurve, CurveSpeedTable, CarTracking;
  * slots: [1] dtor, [2] Setup, CarTracking adds [3] Get  => `virtual ~AIDataRecord_t(); virtual void Setup();`
    and `virtual int Get(int)` in CarTracking only;
  * the five derived dtors (0x8006D514..) have no vptr store and no delete tail: they are SYNTHESIZED (the classes
    declare no destructor); with CarTracking's inline Get they form the deferred-inline tail of the object.
Other TUs' private copies of these structs keep the `_vf` data member: same layout, and none of them dispatches."""
import json
import os
import re

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


h = rd('recon/game/common/aidatarecord_types.h')
a = h.index('struct AIDataRecord_t {')
b = h.index('typedef int CarLogic_tObservations')
NEWH = '''/* Real virtuals since 2026-09-19.  Declaration ORDER is retail evidence: g++ 2.8 emits the vtables at finish_file in
 * reverse declaration order and retail has CarTracking, CurveSpeedTable, TrackCurve, BestLine, AccTable, base.
 * The vptr follows the data members (old g++ ABI), where the hand-written `_vf` member used to be.
 * The derived classes declare NO destructor: retail's are the compiler-synthesized ones (no vptr store). */
struct AIDataRecord_t {
    int numElements_, bSize_;
    char name_[64];
    char *dataBuffer_, *preAllocatedBuffer_;
    AIDataRecord_RecordMethod_t recordMethod_;
    AIDataRecord_t(AIDataRecord_WhichRecord_t which, char *name);
    virtual ~AIDataRecord_t();
    int AddRecordToCollection();
    int RemoveRecordFromCollection();
    static void StartUp1();
    static void StartUp2();
    static void CleanUp1();
    static void CleanUp2();
    virtual void Setup();
    int Load();
    int SaveAndPurge();
};

struct AIDataRecord_AccTable_t : public AIDataRecord_t {
    int scale_;
    AIDataRecord_AccTable_t(char *name, int n, AIDataRecord_WhichRecord_t which);
    int Get(int i);
    void Setup();
};

struct AIDataRecord_BestLine_t : public AIDataRecord_t {
    AIDataRecord_BestLine_t(AIDataRecord_WhichRecord_t which);
};

struct AIDataRecord_TrackCurve_t : public AIDataRecord_t {
    AIDataRecord_TrackCurve_t(AIDataRecord_WhichRecord_t which);
    int Get(int i);
};

struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {
    AIDataRecord_CurveSpeedTable_t(char *name, AIDataRecord_WhichRecord_t which);
    int Get(int i);
    void Upgrade(int i);
};

struct AIDataRecord_CarTracking_t : public AIDataRecord_t {
    /* record method not implemented: always 0.  Inline => part of the object's deferred-inline tail (0x8006D50C). */
    virtual int Get(int slice) { return 0; }
};

'''
wr('recon/game/common/aidatarecord_types.h', h[:a] + NEWH + h[b:])

s = rd('recon/game/common/aidatarecord.cpp')
s, n = re.subn(r'  this->_vf = \(__vtbl_ptr_type \(\*\) \[3\]\)AIDataRecord_\w+_vtable;\n', '', s)
assert n == 6, n
old = ('      (*(*recordCollection[recordLoop]->_vf)[2].pfn)' + NL +
       '        ((char *)recordCollection[recordLoop] +' + NL +
       '         (*recordCollection[recordLoop]->_vf)[2].delta);' + NL)
assert s.count(old) == 1
s = s.replace(old, '      recordCollection[recordLoop]->Setup();' + NL)
for nm in ('AIDataRecord_BestLine', 'AIDataRecord_TrackCurve'):
    old = ('    (*(*%s->_vf)[1].pfn)' % nm + NL + '      ((char *)%s + (*%s->_vf)[1].delta,3);' % (nm, nm) + NL)
    assert s.count(old) == 1, nm
    s = s.replace(old, '    delete %s;' % nm + NL)
cut = s.index('/* ---- Get__26AIDataRecord_CarTracking_ti  [@0x8006d50c] ---- */')
end = s.index('/* end of aidatarecord.cpp */')
s = (s[:cut] +
     '/* The object ends with the deferred-inline tail: Get__26AIDataRecord_CarTracking_ti (in-class inline) and the five' + NL +
     ' * compiler-SYNTHESIZED derived destructors (0x8006D514..0x8006D5B4) -- none of them has source here. */' + NL + NL + s[end:])
s = s.replace('(composition-modeled inheritance, manual _vf vtable dispatch)', '(real inheritance, real C++ virtuals since 2026-09-19)')
wr('recon/game/common/aidatarecord.cpp', s)

x = rd('recon/game/common/aidatarecord_externs.h')
x, n = re.subn(r'/\* ---- aidatarecord\.obj manual vtable symbols \(cross-TU data\) ---- \*/\nextern __vtbl_ptr_type AIDataRecord_t_vtable\[\][^;]*;\n', '', x)
assert n == 1
wr('recon/game/common/aidatarecord_externs.h', x)
os.remove(R + 'recon/game/common/vtables_aidatarecord.cpp')

p = R + 'linkers/nfs4_recon.rodata_placement.json'
rows = json.load(open(p))
for r in rows:
    if r['obj'].endswith('game/common/aidatarecord.cpp.o'):
        r['end'] = 0x800554C4
        r['size'] = r['end'] - r['base']
json.dump(rows, open(p, 'w'), indent=1)
