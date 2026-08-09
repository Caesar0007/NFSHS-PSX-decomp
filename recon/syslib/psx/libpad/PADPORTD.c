/* syslib/psx/libpad/PADPORTD.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libpad.lib(PADPORTD.OBJ): the DIRECT-mode pad driver -- PadInitDirect plus the seven helper
 *   functions it installs into the global dispatch table (_padFunc*) that PADENTRY/PADMAIN/PADCMD
 *   call through.  PadInitDirect wires the table, lays out the two per-port info blocks (0xF0 bytes
 *   each), points each port at the caller's PADL data buffer (pad1/pad2), and arms the VSync engine.
 *
 *   Dispatch wiring (PadInitDirect):
 *     _padFuncNextPort  = _pad_failall      _padFuncClrInfo  = _pad_reset_state
 *     _padFuncGetTxd    = _pad_getbyte      _padFuncCurrLimit= _pad_filter
 *     _padFuncPtr2Port  = _pad_port_to_slot _padFuncPort2Info= _pad_get_port
 *     _padFuncClrCmdNo  = _pad_shift        _padInfoDir      = _pad_info
 *
 *   The per-port info block is addressed by raw byte offset (union-overloaded across libpad objs; see
 *   PADCMD.cpp for the field map).  HW SIO0 register reached through _padSioRegs (cf. PADMAIN). */

extern void _padInitDirSeq(void);                 /* PADSEQD @0x8010A0B0 */
extern void _dirFailAuto(unsigned char *info);    /* PADSEQD @0x8010A434 */
extern int  _padInitSioMode(unsigned char *info); /* PADMAIN @0x80104D2C */
extern void _padSetVsyncParam(void);              /* PADMAIN @0x80104A1C */
extern void bzero(void *p, unsigned n);           /* libc C40 @0x8010A540 */

/* ---- libpad state globals (defined in PAD.OBJ data) ------------------------------------------ */
extern int            _padIntExec;
extern int            _padModeMtap;
extern int            _padSioChan;
extern int            _padChanStop;   /* loop-again bound (==2 direct driver); @0x800fdf84 */
extern int            _padSioState;
extern int            _padTotalCurr;
extern unsigned char *_padInfoDir;
extern int            _padFixResult[2];
extern unsigned char     *_padSioRegs;                /* @0x80137CDC -> 0x1F801040 SIO0 block */
#define JOY_CTRL (*(volatile unsigned short *)(_padSioRegs + 0x0a))

/* dispatch slots (this obj installs the direct-mode handlers below into them) */
extern unsigned char *(*_padFuncNextPort)(int flag);
extern void           (*_padFuncClrInfo)(unsigned char *info);
extern int            (*_padFuncGetTxd)(unsigned char *info, int align);
extern void           (*_padFuncCurrLimit)(unsigned char *info);
extern int            (*_padFuncPtr2Port)(unsigned char *info);
extern unsigned char *(*_padFuncPort2Info)(int slot);
extern unsigned       (*_padFuncClrCmdNo)(unsigned char *info);

/* ---- this obj's .bss: two per-port info blocks + their receive/scratch buffers --------------- */
static unsigned char _pad_rxbuf[2][0x23];          /* @0x80147570 : per-port SIO receive buffer */
static unsigned char _pad_buf2[2][0x23];           /* @0x801475B8 : per-port scratch buffer */
static unsigned char _pad_info[2 * 0xf0 + 0x40];   /* @0x80147600 : 2 info blocks (+0x40 slack: the
                                                      init bzero over-clears 0x40 bytes past the end) */

/* forward declarations */
extern unsigned char *_pad_failall(int flag);
extern void           _pad_reset_state(unsigned char *info);
extern int            _pad_getbyte(unsigned char *info, int align);
extern void           _pad_filter(unsigned char *info);
extern int            _pad_port_to_slot(unsigned char *p);
extern unsigned char *_pad_get_port(int slot);
extern unsigned       _pad_shift(unsigned char *info);

/* @0x800FDD28 : PadInitDirect */
extern void PadInitDirect(unsigned char *pad1, unsigned char *pad2)
{
    int p;

    _padIntExec  = 0;
    _padModeMtap = 0;
    _padInitDirSeq();

    _padFuncNextPort  = _pad_failall;
    _padFuncClrInfo   = _pad_reset_state;
    _padFuncGetTxd    = _pad_getbyte;
    _padFuncCurrLimit = _pad_filter;
    _padFuncPtr2Port  = _pad_port_to_slot;
    _padFuncPort2Info = _pad_get_port;
    _padInfoDir       = _pad_info;
    _padFuncClrCmdNo  = _pad_shift;

    bzero(_pad_info + 0x40, 0x1e0);
    *(unsigned char **)(_pad_info + 0x00 + 0x30) = pad1;
    *(unsigned char **)(_pad_info + 0xf0 + 0x30) = pad2;

    for (p = 0; p < 2; p++) {
        unsigned char *info = _pad_info + p * 0xf0;
        unsigned char *padbuf = *(unsigned char **)(info + 0x30);
        int i;
        *(int *)(info + 0x0c) = 0;
        *(unsigned char **)(info + 0x10) = info;        /* self ptr */
        padbuf[0] = 0xff;
        padbuf[1] = 0;
        *(unsigned char **)(info + 0x3c) = _pad_rxbuf[p];
        *(unsigned char **)(info + 0x40) = _pad_buf2[p];
        for (i = 0; i < 6; i++)
            info[0x5d + i] = 0xff;
    }

    _padSetVsyncParam();
    _padIntExec = 1;
}

/* @0x800FDE88 : _pad_reset_state (_padFuncClrInfo) -- wipe a port's transient state.
 * Oracle: addiu v1,a0,93; addiu a1,zero,255; addiu v0,zero,5 (ptr/fill/counter order).
 * Loop: sb a1,0(v1); addiu v0,v0,-1; bgez v0; addiu v1,v1,1 (delay). 6 iters total. */
extern void _pad_reset_state(unsigned char *info)
{
    if (info[0x49] != 0) {
        unsigned char *p = info + 0x5d;
        int fill = 0xff;
        int n = 5;
        info[0x49] = 0;
        info[0x46] = 0;
        *(unsigned short *)(info + 0xe6) = 0;
        *(int *)(info + 0x14) = 0;
        *(int *)(info + 0x18) = 0;
        info[0xe3] = 0;
        info[0xe4] = 0;
        *(unsigned short *)(info + 0xe6) = 0;
        info[0xe9] = 0;
        info[0xea] = 0;
        *(int *)(info + 0x00) = 0;
        *(int *)(info + 0x04) = 0;
        *(int *)(info + 0x08) = 0;
        do { *p++ = (unsigned char)fill; } while (--n >= 0);
    }
}

/* @0x800FDEF0 : _pad_failall (_padFuncNextPort) -- abandon the current port, advance to the next.
 * MATCH (w48-a4, 45 -> 34): the `-9` sentinel is a NAMED LOOP-INVARIANT LOCAL, not a bare
 * literal.  Retail hoists it into a CALLEE-SAVED register (`li $s3,-9` in the prologue,
 * `beq $a1,$s3` inside the loop) and pays for it with a 4th saved reg and a 0x28 frame; a bare
 * `flag != -9` literal is rematerialized in the loop and gives a 0x20 frame with only s0-s2
 * (45 diffs).  Catalog: "a bare hoisted loop-invariant LITERAL is its own allocno -- NAMING it
 * lengthens its range".  Frame, saved-reg set and the sentinel register now all match.
 * RESIDUAL 34 @59/61, two named classes:
 *  (a) the two hoisted global bases use a SEPARATE %hi scratch (`lui $v0; addiu $s1,$v0`) where
 *      retail self-temps (`lui $s1; addiu $s1,$s1`).  Same combine_regs global-destination tie
 *      refusal as _pad_port_to_slot's residual (w47 delete_noop_moves law) -- BOTH bases here,
 *      so this one class accounts for 4 of the diff lines.  Second in-TU instance => a real
 *      class, not a one-off.
 *  (b) retail COPIES the incoming param (`addu $a1,$a0,$zero` at insn 1) and runs the whole loop
 *      off $a1; ours keeps it in $a0.  The w47 opacity fence does NOT force it here (36 both as
 *      an in/out fence and as a use fence) -- unlike _dirSendAuto, where the same fence worked.
 *      NEXT ANGLE: the copy exists because `flag` is REASSIGNED (`flag = 0xffff`) at the loop
 *      bottom, so retail's parm pseudo and the loop variable are distinct; try splitting them in
 *      source (a separate loop variable initialised from the param). */
extern unsigned char *_pad_failall(int flag)
{
    unsigned char *ret;
    int noport = -9;

    do {
        unsigned char *info = _pad_info + _padSioChan * 0xf0;
        if (flag != noport) {
            if (flag == 0)
                _padFixResult[_padSioChan] = 0;
            else {
                _dirFailAuto(info);
                _pad_shift(info);
            }
        }
        _padSioState = 0;
        JOY_CTRL = 0;
        _padSioChan = _padSioChan + 1;
        ret = (unsigned char *)1;
        if (_padSioChan <= _padChanStop)
            ret = (unsigned char *)(unsigned long)
                  _padInitSioMode(_pad_info + _padSioChan * 0xf0);
        flag = 0xffff;
    } while (ret == 0);
    return ret;
}
/* @0x800FDFE4 : _pad_shift (_padFuncClrCmdNo) -- consume the queued command byte.
 * MATCH: b declared unsigned (not unsigned char) to suppress the andi 0xff mask on return;
 * lbu already zero-extends, so unsigned is semantically correct and oracle has no mask. */
extern unsigned _pad_shift(unsigned char *info)
{
    unsigned b = info[0x36];
    info[0x36] = 0;
    info[0x37] = (unsigned char)b;
    return b;
}

/* @0x800FDFF4 : _pad_getbyte (_padFuncGetTxd) -- next byte to clock out for the current command.
 *   `align` (2nd dispatch arg) is unused in direct mode.
 * MATCH (w48-a4, 40 -> 20 diffs): the mode dispatch is a REAL 2-case `switch`, and the arm order
 * is 0 / 'M' / default.  Proof in the oracle: `beqz $a1,<case0>` then `li $v0,77;
 * beq $a1,$v0,<caseM>` then an UNCONDITIONAL `j <default>` -- a bare 2-node linear chain with no
 * bound test and ALL THREE bodies out-of-line, which is gcc-2.8's 2-case switch lowering and is
 * unreachable from an if/else-if cascade (that inlines case 0 as the fall-through and inverts the
 * first test to `bnez`).  Two more facts landed with it: writing the guard byte as
 * `*(info + idx + 0x57)` (base operand FIRST) gives the oracle's `addu $v0,$a0,$v1` where
 * `info[0x57 + idx]` gives the reversed `addu $v0,$v1,$a0`; and the 'M' arm returns 0xff while
 * the other two return 0, which is what lets cross_jump fold the 'M' arm's tail into case 0's
 * shared `lbu $v0,0($v0)` (the oracle's `j .L800FE058`) while the default arm keeps its own copy.
 * RESIDUAL 20 @51/47: the 4 extra instructions are jump.c RETURN-THREADING -- this fn is a
 * frameless leaf, so every `return` site gets its own threaded `jr $ra; nop` pair, where retail
 * keeps ONE shared epilogue block reached by `j .L800FE0A8` from all four exits.  Not reachable
 * from source: a single-`return` funnel with `goto out` threads identically (20 @51), and a
 * per-fn -fno-delayed-branch splice is worse (28 @55).  Same family as the epilogue/slot lane
 * (a10/a6).  Falsified at this basin: if/else-if with the corrected arm order (26 @47 -- count
 * exact but the dispatch provably wrong), nested `if (idx < 6) { if (...) }` (26), `int mode`
 * temp for the switch selector (22), default-arm via a `buf` local instead of a direct return
 * (20, identical). */
extern int _pad_getbyte(unsigned char *info, int align)
{
    int idx = info[0x45] - 3;
    unsigned char *buf;
    (void)align;

    switch (info[0x36]) {
    case 0:                                  /* poll: stream the actuator data */
        if (idx < 6 && *(info + idx + 0x57) == 0)
            return 0;
        if (info[0x34] <= idx)
            return 0;
        buf = *(unsigned char **)(info + 0x28);
        break;
    case 'M':                                /* 0x4D align: pad with 0xff */
        if (info[0x35] <= idx)
            return 0xff;
        buf = *(unsigned char **)(info + 0x2c);
        break;
    default:                                 /* fixed command param block */
        if (info[0x35] <= idx)
            return 0;
        return (*(unsigned char **)(info + 0x2c))[idx];
    }
    return buf[idx];
}

/* @0x800FE0B0 : _pad_filter (_padFuncCurrLimit) -- gate the actuators against the current budget.
 * MATCH (w52-a5): the fn is VOID -- the oracle stages NO return value anywhere (every `$v0` it
 * materialises is a store operand: the `li 1` feeding `sb $v0,0x57/0x58`), and both call sites
 * (MCXMAIN _padIntRecvData) discard the result.  The old `unsigned r` funnel emitted a whole
 * shadow dataflow (r=hdr, r=b1&1, r=1, r=_padTotalCurr, r=0) that has no counterpart in retail.
 * MATCH: the credit test is TWO SEPARATE `if (matched)` statements sharing one flag -- retail
 * re-tests `$a2` at .L800FE1D0 after CLEARING it (`addu $a2,$zero,$zero` at .L800FE1CC) on the
 * over-budget path, i.e. `if (m) { if (t<0x3d) total=t; else m=0; } if (m) { ... }`, not the
 * nested `if (m) { if (t<0x3d) { ... } }` shape.
 * MATCH: statement ORDER in the outer-loop head -- the mask default+test come FIRST (retail
 * schedules `matched=0` into the `lw 4($s0)` load-delay slot and `mask=1` into the `beqz` delay
 * slot), and map/dat/i are initialised AFTER the test.
 * MATCH: BLOCK ORDER -- the actuator-map LOOP path is the FALL-THROUGH (`if (e6 != 0 && p28 !=
 * 0)`), the small/fallback path is the `else` pushed out-of-line at .L800FE228; the inverted
 * spelling cost 160 diffs on its own.  MATCH: both search loops are counted `for (i = 0; i <
 * nmask; i++)` with SIGNED counters (retail's `slt`, not `sltu`), and `row += 5` precedes
 * `mode++` so retail's `lbu 0xE9($s0)` leads the outer back-edge test.
 * 201 -> 23.  RESIDUAL 23 @164/159, four named classes: (a) `addu $t2,$t0,$zero` -- cse copies
 * mode's zero into row where retail rematerializes (delete_noop_moves/global-destination tie,
 * w47); (b) the first search loop's entry guard is `slt $v0,i,$t1; beqz` where retail folded it
 * to `beqz $t1` (+1 insn); (c) TWO `j <join>` whose delay slot retail fills with the preceding
 * `sw $vN,%lo(_padTotalCurr)($at)` store -- the maspsx reorder-branch-slot class (both sites
 * DISSOLVE under the cc1_272/GNU-as-reorder lane, verified); (d) the 6-byte tail fill loop is
 * strength-reduced by retail to a walking `info+i` base -- 3 walking-pointer spellings probed,
 * all 31 (worse), so this one is source-resistant at this basin.
 * MATCH (w53-a8, the PADPORTD DUAL-BASIN RESOLUTION -- 23 def / 36 alt -> 23 def / 18 alt,
 * COUNT-EXACT 159/159 on the gcc-2.7.2 rung; the TU's lane-decider, 127 -> 109):
 *   (1) FIRST search loop `i = 0; while (i != nmask)` -- the `!=` bound removes the `slt` entry
 *       guard retail folds away (residual class (b) above), -2 insns.  Guarded do-while forms of
 *       the SAME loop are catastrophic (61/62); the `!=` while is the only shape that lands.
 *   (2) SECOND search loop `k = 0; if (nmask != 0) do { ... k++; } while (k < nmask);` -- 26 -> 24
 *       on the rung, EXACTLY NEUTRAL in the default basin.  (`while (k != nmask)` = 27/26, the
 *       w52-a5 candidate; exit-in-the-middle 44, index-form 36, down-count 42, goto-loop 45.)
 *   (3) nmask's ternary TEST read is the volatile view, the VALUE read plain -- retail LOADS
 *       `info[0x34]` TWICE (`lbu $v0,52($s0)` for the `sltiu ,7` and `lbu $t1,52($s0)` for the
 *       value) where cse gives us one load + `addu $t1,$v1,$zero`.  Same lever/direction as the
 *       w53-a8 MCXMAIN `_padIntQuery` crack: cse never records a volatile MEM, so the plain read
 *       after it is a genuinely fresh load.  24 -> 18 on the rung, neutral (23) in the default
 *       basin.  Volatile-FREE spellings of the same double-read all falsified: use fence on info
 *       (27), identity fence on info inside the guard (21), explicit if/else (27), redundant cast
 *       (24), `(signed char)` test (37).
 * PER-BASIN TU LEDGER after these three: default 139 (unchanged), gcc-2.7.2 rung 109.
 * => the rung is the TU's home; see the wiring note in the report. */
extern void _pad_filter(unsigned char *info)
{
    bzero(info + 0x57, 6);

    if (*(unsigned short *)(info + 0xe6) != 0 && *(int *)(info + 0x28) != 0) {
        int nmask = *(volatile unsigned char *)(info + 0x34) < 7 ? info[0x34] : 6;
        int mode = 0;
        if (info[0xe9] != 0) {
            int row = 0;
            do {
                int matched = 0;
                unsigned char mask = 1;
                unsigned char *map;
                unsigned char *dat;
                int i;
                if (*(char *)(row + *(int *)(info + 4) + 2) != 0)
                    mask = 0xff;
                map = info + 0x5d;
                dat = *(unsigned char **)(info + 0x28);
                i = 0;
                while (i != nmask) {
                    if (*map == mode && (*dat & mask) != 0) { matched = 1; break; }
                    map++; dat++;
                    i++;
                }
                if (matched) {
                    int t = _padTotalCurr + *(unsigned char *)(row + *(int *)(info + 4) + 3);
                    if (t < 0x3d)
                        _padTotalCurr = t;
                    else
                        matched = 0;
                }
                if (matched) {
                    unsigned char *m2 = info + 0x5d;
                    unsigned char *flag = info + 0x57;
                    int k;
                    k = 0;
                    if (nmask != 0) {
                        do {
                            if (*m2 == mode) *flag = 1;
                            m2++; flag++;
                            k++;
                        } while (k < nmask);
                    }
                }
                row += 5;
                mode++;
            } while (mode < info[0xe9]);
        }
    } else {
        if (((unsigned char)(info[0xe8] - 4) < 2 || info[0xe8] == 7) &&
            (*(unsigned short *)(info + 0xe6) == 0 && info[0x34] > 1)) {
            if ((**(unsigned char **)(info + 0x28) & 0xc0) == 0x40 &&
                ((*(unsigned char **)(info + 0x28))[1] & 1) != 0 &&
                _padTotalCurr + 10 < 0x3d) {
                info[0x58] = 1;
                info[0x57] = 1;
                _padTotalCurr = _padTotalCurr + 10;
            }
        } else {
            if (info[0xe8] == 3) {
                info[0x57] = 1;
            } else if (*(unsigned short *)(info + 0xe6) == 0) {
                int i;
                for (i = 5; i >= 0; i--)
                    info[0x57 + i] = 1;
            }
        }
    }
}

/* @0x800FE32C : _pad_port_to_slot (_padFuncPtr2Port) -- info block ptr -> slot id (0x10/0x20).
 * MATCH (w48-a4, 18 -> 6 diffs, count-exact 14/14).  Three cooperating shape facts, read off
 * the oracle:
 *   (1) `i = 0;` is its OWN statement and the loop is a DO/WHILE -- the oracle's bottom test
 *       (`slti $v0,$a1,2; bnez`) with no entry guard is gcc's rotated do-while, and the explicit
 *       `addu $a1,$zero,$zero` at insn 0 is the separate init (a `for(i=0;i<2;i++)` header emits
 *       the counter bump ahead of the compare and inverts the guard polarity: 18 diffs).
 *   (2) the found-arm is `r = slot; goto out;` -- a DEFAULT ASSIGNED BEFORE THE TEST (catalog
 *       w47 "PRE-SET THE DEFAULT BEFORE THE TEST"): its block is a single `(set v0,slot)(jump)`,
 *       so reorg EAGER-STEALS it into the beq's delay slot and retargets the beq straight at the
 *       shared epilogue = the oracle's `beq $a0,$v1 / addu $v0,$a2,$zero`.  A bare `return slot;`
 *       inside the loop instead emits a SECOND `jr ra` block (q3 probe: 10 diffs).
 *   (3) increment order slot, i, info -- info LAST so it lands in the bnez delay slot.
 * RESIDUAL 6 (2 lines), both named gcc mechanisms, neither reachable at this basin:
 *   (a) `lui $v0,%hi; addiu $v1,$v0,%lo` vs oracle's SELF-TEMP `lui $v1; addiu $v1,$v1` --
 *       the {high, lo_sum} pair is one combined qty only when local-alloc's combine_regs may tie
 *       them, and it REFUSES when the lo_sum's destination is a global allocno (w47
 *       delete_noop_moves law); `info` is loop-carried, hence global, hence two registers.
 *   (b) `addiu $a2,$v0,16` vs oracle `addiu $a2,$a2,16` -- cse's canonical-copy pick: `r` OUTLIVES
 *       `slot` (it is read after the loop), so make_regs_eqv makes r's register canonical and the
 *       increment reads it (w47 law, KEEP direction).  Retail's `slot` stays canonical.
 * FALSIFIED at this basin (all whole-TU, other 7 fns unchanged): for-header/while-header (18/12),
 *   `info == p` yoda (12), `&_pad_info[0]` (12), r-as-block-local (7 @15), break+`r=0xff` default
 *   (15 @15), single-variable `slot` doubling as the result (11 @13), increment-order permutations
 *   x3 (6), decl-order permutations x3 (6), opacity fence on r / on slot / after the increment
 *   (16/20/20), `return 0xff;` before the label (5 diffs but 15/14 -- count NOT exact, rejected). */
extern int _pad_port_to_slot(unsigned char *p)
{
    int i = 0;
    int slot = 0x10;
    int r;
    unsigned char *info = _pad_info;
    do {
        r = slot;
        if (p == info)
            goto out;
        slot += 0x10;
        i++;
        info += 0xf0;
    } while (i < 2);
    r = 0xff;
out:
    return r;
}

/* @0x800FE364 : _pad_get_port (_padFuncPort2Info) -- slot id -> info block ptr.
 * Oracle: lui+addiu base once, then addiu v0,v0,0xF0 only if slot&0xF0 != 0 → single base reg. */
extern unsigned char *_pad_get_port(int slot)
{
    unsigned char *p = _pad_info;
    if ((slot & 0xf0) != 0)
        p = p + 0xf0;
    return p;
}
