/* syslib/psx/libpad/MCXMAIN.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libpad.lib(MCXMAIN.OBJ): the controller-exchange state machine -- the five step functions
 *   the SIO engine (PADMAIN::_padSioMain) dispatches through padIntFunc[_padSioState]:
 *     _padIntInit    select the controller / multitap, issue the first byte
 *     _padIntQuery   send the poll/config opcode, read the reply header low nibble
 *     _padIntRecvId  read the device id, derive the byte count (multitap-aware)
 *     _padIntRecvHdr read+validate the 0x5A acknowledge header
 *     _padIntRecvData stream the payload bytes (multitap: across all sub-ports), then advance port
 *   Each takes the per-port info block in $a0 and returns a SIO step code (<0 = bus error).
 *   _padFuncGetTxd is called with TWO args here (info, align) -- so its target (_pad_getbyte) is
 *   really 2-arg; Ghidra drops the second.  JOY_DATA reached through _padSioRegs (cf. PADMAIN). */

extern int      (*_padFuncSendAuto)(unsigned char *info);
extern int      (*_padFuncGetTxd)(unsigned char *info, int align);
extern int      (*_padFuncCurrLimit)(unsigned char *info);
extern unsigned (*_padFuncRecvAuto)(unsigned char *info);
extern unsigned char *(*_padFuncNextPort)(int flag);
extern unsigned (*_padFuncClrCmdNo)(unsigned char *info);

extern unsigned _padSioRW(unsigned char *dev, unsigned arg2);   /* PADMAIN @0x80105128 */
extern unsigned _padSioRW2(unsigned char *dev, int tx);         /* PADMAIN @0x80105300 */
extern void     _padClrIntSio0(void);                           /* PADMAIN @0x80105538 */
extern void     _padWaitRXready(void);                          /* PADMAIN @0x801055C8 */
extern unsigned setRC2wait(int ticks);                          /* WAITRC2 @0x8010BFE8 */

extern int            _padModeMtap;
extern int            _padSioChan;
extern int            _padChanStart;
extern int            _padGunExec;
extern void          (*_padFuncGetGunPos)(void);
extern void          (*_padFuncSetGunPort)(void);
extern unsigned char *_padInfoDir;
extern int            _padFixResult[2];
extern unsigned char     *_padSioRegs;                              /* @0x80137CDC -> 0x1F801040 */
#define JOY_DATA8 (*(volatile unsigned char *)(_padSioRegs))

/* @0x8013C308 : originally a 12-byte block (3 words); the oracle addresses each word via its OWN
 * independent lui/lw pair (no shared base register cached across a call/branch) -- e.g.
 * _padIntRecvId materializes &_padMtapFlag (@0x8013C310) via a plain direct-load macro at entry
 * and a SEPARATE direct-store macro for &_padMtapCount (@0x8013C308) later, never a persisting
 * base pointer. Modeling them as one C array let gcc CSE a shared base into a callee-saved reg
 * (s2) across the intervening _padSioRW2 call -> extra frame slot the oracle doesn't pay
 * (_padIntRecvId 32-byte/4-saved-reg frame vs oracle's 24-byte/2-saved-reg). Split into three
 * independent statics (still ST_BSS-forced so none becomes gp-relative -- see DSCB.c's identical
 * trick) to match the oracle's per-access addressing. */
#define ST_BSS  __attribute__((section(".bss")))
#define ST_DATA __attribute__((section(".data")))
static int _padMtapCount ST_BSS;                       /* @0x8013C308 */
static int _padMtapDataReg ST_DATA = 0x1F801040;        /* @0x8013C30C : JOY_DATA mmio base (real image bytes) */
static int _padMtapFlag ST_BSS;                         /* @0x8013C310 */

/* @0x8010C0A8 : _padIntInit -- begin the exchange (issue 0x01 select).
 * MATCH (w48-a4, 6 -> PASS 18/18): NAMED TEMPS + LOAD-BEFORE-STORE ORDER.  The oracle loads the
 * rx pointer into $v1 (`lw $v1,0x3C($s0)`) and sets $a1 BEFORE storing the call's return value to
 * _padMtapFlag, so $v0 still holds that return value when the store macro runs.  Writing the store
 * as the first statement (`_padMtapFlag = _padFuncSendAuto(info);`) frees $v0 early and gcc then
 * reloads the rx pointer INTO $v0 after the store -- same 18 instructions, wrong order and wrong
 * register.  Splitting the call result and the deref into named locals and placing the deref
 * BEFORE the global store reproduces the oracle exactly.  (Catalog: "load-before-store ordering
 * steers the backward scan"; the `sb $zero,0($v1)` is the jal's delay slot on both sides.)
 * Falsified: `*rx = 0;` before the flag store (5 diffs @19/18, an extra insn); rx as a bare local
 * with the flag store still first (6). */
extern int _padIntInit(unsigned char *info)
{
    int flag = _padFuncSendAuto(info);
    unsigned char *rx = *(unsigned char **)(info + 0x3c);

    _padMtapFlag = flag;
    *rx = 0;
    return (int)_padSioRW(info, 0xfffffffe);
}

/* @0x8010C0F0 : _padIntQuery -- send the command opcode (default 0x42 = poll).
 * MATCH (w48-a4, 8 -> PASS 54/54): the opcode select is TWO FULL CALLS, not a ternary/if-else
 * value-select feeding one call (catalog w41 "a value-select ternary in a CALL ARGUMENT should
 * be TWO FULL CALLS cross-jump-merged").  The oracle's tail is `bnez $v0,L / addu $a0,$s0,$zero`
 * then `j Lcall / li $a1,66` with the other arm's `lbu $a1,0x36($s0)` falling into a SHARED `jal`
 * -- i.e. cross_jump merged two identical calls and the constant lives in the `j` delay slot.
 * ARM ORDER is load-bearing: the `!= 0` arm must be written FIRST (the `== 0` arm first gives
 * 7 diffs @55/54, one insn over).  A single call with a selected value can never reach it: the
 * ternary and the if/else both CSE the second `info[0x36]` read into the tested register
 * (`addu $a1,$v0,$zero`, 8 diffs @52/54, two insns SHORT), and forcing the re-read with a
 * volatile view gets the load but adds an `andi $a1,$v0,255` promotion mask (10 @54/54);
 * `op = info[0x36]; if (op == 0) op = 0x42;` is worse still (12). */
extern unsigned _padIntQuery(unsigned char *info)
{
    if (_padSioChan == _padChanStart) {
        if (_padGunExec != 0) {
            _padFuncGetGunPos();
            _padFuncSetGunPort();
        }
    }
    if (_padMtapFlag != 0) {
        _padFuncSendAuto(*(unsigned char **)(info + 0xc));
        _padFuncSendAuto(*(unsigned char **)(info + 0xc) + 0xf0);
    }
    if (info[0x36] != 0)
        return _padSioRW2(info, info[0x36]);
    return _padSioRW2(info, 0x42);
}

/* @0x8010C1C8 : _padIntRecvId -- read the device id; derive the multitap byte count. */
extern int _padIntRecvId(unsigned char *info)
{
    unsigned r;
    if (_padMtapFlag != 0) {
        _padFuncSendAuto(*(unsigned char **)(info + 0xc) + 0x1e0);
        _padFuncSendAuto(*(unsigned char **)(info + 0xc) + 0x2d0);
    }
    r = _padSioRW2(info, (info[0x36] == 0) ? _padModeMtap : 0);
    if ((int)r >= 0) {
        unsigned lo = r & 0xf;
        if ((r & 0xf0) == 0) {
            r = 0xfffffff7;
        } else {
            _padMtapCount = lo << 1;
            r = 0;
            if (lo == 0) {
                _padMtapCount = 0x20;
                r = 0;
            }
        }
    }
    return (int)r;
}

/* @0x8010C288 : _padIntRecvHdr -- read + validate the 0x5A acknowledge byte. */
extern unsigned _padIntRecvHdr(unsigned char *info)
{
    int align = 0;
    unsigned tx, r;
    if ((unsigned)(**(unsigned char **)(info + 0x3c) >> 4) == 8)
        align = (info[0x36] == 0);
    tx = (unsigned)_padFuncGetTxd(info, align);
    r = _padSioRW2(info, tx & 0xff);
    /* NEAR-MISS (4, count-exact 35/35): reorg DUPLICATES the shared tail's `addu $v0,$v1,$zero`
     * return copy into a delay slot; the oracle puts the duplicate in the FIRST branch's slot
     * (beq slot = addu, beqz slot = nop), ours in the SECOND (beq slot = nop, beqz slot = addu).
     * Everything else is byte-identical.  w48-a4 re-swept the whole spelling space at this basin:
     * `&&`-guard block (base), two flat early `return r`s, `||` early-out, goto-out funnel,
     * fully nested ifs, 3-term `&&` with the sign test folded in, opacity fence on r before the
     * chain, use fence BETWEEN the two tests, use fence after them -- ALL NINE compile to the
     * BYTE-IDENTICAL 35 instructions.  jump.c canonicalizes the tail before reorg runs, so no
     * source spelling reaches the fill ORDER; this is the reorg-duplicate-placement class, not a
     * structural or coloring miss.  NEXT ANGLE: reorg processes branches in order and fills the
     * second only after failing the first -- find why the first steal is rejected (`-dR`/reorg
     * trace), or route to the permuter. */
    if (r != 0x5a && r != 0) {
        if ((int)r >= 0)
            return 0xfffffff7;
        return r;
    }
    return r;
}

/* @0x8010C314 : _padIntRecvData -- stream the payload (multitap sub-ports), then advance the port. */
extern unsigned _padIntRecvData(unsigned char *info)
{
    unsigned r;
    int align = 0;

    _padFuncCurrLimit(info);
    if (_padModeMtap != 0 && (int)(**(unsigned char **)(info + 0x3c) >> 4) == 8)
        align = (info[0x36] == 0);

    /* multitap: drive the per-sub-port command bytes */
    if (align != 0) {
        int idx = -1, off = -0xf0;
        do {
            _padMtapCount = _padMtapCount - 1;
            if (_padMtapCount < 1)
                break;
            if (idx >= 0)
                _padFuncCurrLimit(*(unsigned char **)(info + 0xc) + off);
            r = (unsigned)_padFuncGetTxd(info, 1);
            r = _padSioRW2(info, r & 0xff);
            if ((int)r < 0)
                return r;
            r = setRC2wait(0x3c);
            _padClrIntSio0();
            idx = idx + 1;
            if (r == 0)
                return 0xfffffffd;
            off = off + 0xf0;
        } while (idx < 4);
    }

    /* dispatch the auto-recv of the other ports' queued replies */
    if (1 < _padMtapCount) {
        int *fix = &_padFixResult[_padSioChan == 0 ? 1 : 0];
        int base = (_padSioChan == 0) * 0xf0;
        unsigned char *cur = 0;
        do {
            int v = *fix;
            if (v < 0)
                break;
            if (0 < v) {
                cur = *(unsigned char **)(base + _padInfoDir + 0xc) + v * 0xf0 - 0xf0;
                _padFuncRecvAuto(cur);
            }
            v = *fix;
            if (v == 3) {
                _padFuncRecvAuto(cur - 0xf0);
                *fix = 1;
            } else if (v < 4) {
                if (v < 2 && v >= 0) {
                    cur = _padInfoDir + base;
                    _padFuncRecvAuto(cur);
                    _padFuncClrCmdNo(cur);
                    *fix = -1;
                }
            } else if (v == 4) {
                *fix = 3;
            }
            r = (unsigned)_padFuncGetTxd(info, align);
            r = _padSioRW(info, r & 0xff);
            if ((int)r < 0)
                return r;
            r = setRC2wait(0x3c);
            _padClrIntSio0();
            if (r == 0)
                return 0xfffffffd;
            _padMtapCount = _padMtapCount - 1;
        } while (1 < _padMtapCount);
    }

    /* stream the remaining payload bytes into the receive buffer */
    for (;;) {
        _padMtapCount = _padMtapCount - 1;
        if (_padMtapCount < 1) {
            unsigned char len;
            _padWaitRXready();
            len = info[0x44];
            info[0x44] = len + 1;
            (*(unsigned char **)(info + 0x3c))[len] = JOY_DATA8;
            _padFuncNextPort(0);
            return 0;
        }
        r = (unsigned)_padFuncGetTxd(info, align);
        r = _padSioRW(info, r & 0xff);
        if ((int)r < 0)
            break;
        r = setRC2wait(0x3c);
        _padClrIntSio0();
        if (r == 0)
            return 0xfffffffd;
    }
    return r;
}
