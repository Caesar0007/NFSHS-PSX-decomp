"""Insert CHECKPOINT 2026-09-20j into the NFS4 memory hub (after the 2026-09-20i line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20j' not in s
i = s.index('- CHECKPOINT 2026-09-20i')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-20j (USER: 'continue on vtables' -- RESIDUE SWEEP, vtable work CLOSED in live code): nfs4-decomp `main` = "
    "cbd61d16 (branch wip/vf-pod-copies fast-forwarded; UNPUSHED, 37 ahead of 6871d324), 0 diff (297385/297385), DROPPED 0. "
    "METHOD: sha1 of all 4476 build/recon objects before/after a FULL rebuild -- every step below left them byte-IDENTICAL "
    "(declarative changes only). (1) 19 layout-only surfaces had a hand `__vtbl_ptr_type (*_vf)[N]` pointer member in POD copies of "
    "polymorphic classes: ObjectAnim -> the real root (`virtual ~ObjectAnim(); virtual int Draw(...) = 0;`, derived composition "
    "`_base_ObjectAnim` -> inheritance), AIDataRecord_t -> `virtual ~AIDataRecord_t(); virtual void Setup();`, game-side copies of "
    "tListIterator/tMenuItem/tMenu/tScreen (mmeffect, audiocmn, gmesetup, pausemenu, nfs3) -> a declared-only virtual destructor "
    "(layout-only: the compiler's own vptr lands where `_vf` was; nothing is emitted because no key function is defined there). "
    "(2) stale `extern __vtbl_ptr_type X_vtable[]...;` declarations removed (7 files) + `D_80054F24` extern. (3) dead "
    "`__vtbl_ptr_type *entry/entry10/entry6` + `char *adjusted` carrier locals in femenuoptions.cpp removed. (4) the 14 "
    "`typedef struct __nfs4_vtbl_ptr_t` / `#define __vtbl_ptr_type` blocks removed. (5) 🗑 recon/nfs4_types.h (6481-line monolithic "
    "hand-vtable-era surface) DELETED: an `#error` probe showed only 26 (near-)empty TUs compiled it; 118 include lines dropped; "
    "only fei.cpp (now includes gmesetup_types.h for FEI_tList + GameSetup_tData) and drawdbg (own `u_long` typedef) needed "
    "anything. AGENT_GUIDE.md / build.py comments still mention the file (docs only). New tool: "
    "scratchpad/psyq_pipe/vf_live_census.py (strips comments and `#if 0`, greps `_vf`, `X_vtable`, `__vtbl_ptr_type`, asm `_vt` "
    "labels) = 0 live hits. LEFT (comments only): stale 'manual _vf' prose in file headers / SYM-CODEGEN-CARRIER notes, and the "
    "`#if 0` reference blocks in aih_btccop.cpp. Scripts vfpod1..8.py.\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
