/* syslib/psx/libpad/PADENTRY.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libpad.lib(PADENTRY.OBJ): the 8 public Pad* API entry points.  Each looks the per-port
 *   controller descriptor up through the global dispatch pointer _padFuncPort2Info(port) (set by the
 *   active pad mode -- direct, SIO, etc.), then reads/writes that descriptor or forwards to the
 *   PADMAIN / PADCMD engines.  PadStartCom/PadStopCom just kick the SIO main loop. */

/* ---- per-port controller descriptor (libpad internal; only the touched fields are named) ------ */
typedef struct _PadDev {
    unsigned short *mode_tbl;     /* +0x00 : mode-id table (PadInfoMode term 4) */
    unsigned char  *act_tbl;      /* +0x04 : actuator table, 5 bytes/entry (PadInfoAct) */
    char            _pad08[0x08]; /* +0x08 */
    struct _PadDev *self;         /* +0x10 : loopback ptr (connected test) */
    char            _pad14[0x1c]; /* +0x14 */
    char           *flag_ptr;     /* +0x30 : ptr to a live status-flag byte */
    unsigned int    status;       /* +0x34 : status word (hi 16 bits = error/connect) */
    unsigned char   connected;    /* +0x38 */
    char            _pad39[0x02]; /* +0x39 */
    char            _pad3b[0x0e]; /* +0x3b */
    unsigned char   state;        /* +0x49 : controller state code */
    char            _pad4a[0x02]; /* +0x4a */
    int             term100;      /* +0x4c : PadInfoMode term 100 */
    char            _pad50[0x93]; /* +0x50 */
    unsigned char   nmode;        /* +0xe3 : mode count */
    unsigned char   mode3;        /* +0xe4 : PadInfoMode term 3 */
    char            _pade5[0x01]; /* +0xe5 */
    unsigned short  modeword;     /* +0xe6 : PadInfoMode term 2 */
    unsigned char   mode1;        /* +0xe8 : PadInfoMode term 1 */
    unsigned char   nact;         /* +0xe9 : actuator count */
} _PadDev;                        /* the touched fields land at their @-offsets above */

/* ---- dispatch pointer + engine entry points (defined by PAD.OBJ / PADMAIN / PADCMD) ----------- */
extern _PadDev *(*_padFuncPort2Info)(int port);       /* @0x80137C8C dispatch slot */
void _padStartCom(void);                             /* PADMAIN @0x80104C1C */
void _padStopCom(void);                              /* PADMAIN @0x80104CE8 */
int  _padSetActAlign(_PadDev *info, unsigned char *data); /* PADCMD @0x80105BF4 */
int  _padSetMainMode(_PadDev *info, int offs, int lock); /* PADCMD @0x80105D40 */
void _padSetAct(_PadDev *info, unsigned char *data, int len); /* PADCMD @0x801055F0 */

/* @0x800EFE60 : PadStartCom
 * MATCH (W80-root): PASS 8/8 with the authentic per-function GCC 2.7.2
 * identity.  The same source on the 2.8-family compiler puts the stack
 * restore in the jr delay slot and leaves a four-diff epilogue. */
void PadStartCom(void) { _padStartCom(); }

/* @0x800EFE80 : PadStopCom -- MATCH 8/8 on the same GCC 2.7.2 identity. */
void PadStopCom(void) { _padStopCom(); }

/* @0x800EFEA0 : PadGetState -- map the raw controller state to the public PadState* code.
 *
 * MATCH (W80-root): PASS 48/48 with the authentic per-function GCC 2.7.2
 * identity.  A strict eight-function PADENTRY gate is 8/8 PASS with no
 * scheduling or epilogue intervention; 2.6.0, 2.6.3, 2.7.2 and 970404 all
 * share the retail return shape, while every 2.8-family rung leaves 4 diffs.
 *
 * MATCH (w55-a6, source side): the dispatch is a REAL `switch` with THREE SEPARATE case nodes.
 *   The oracle's tree is the gcc-2.8 balance_case_nodes fingerprint -- root `beq $v1,3`, the
 *   bound test `slti $v0,$v1,4` in its delay slot, left leaf `beq $v1,2`, right leaf
 *   `beq $v1,6`, every body out-of-line, each terminated by `j <default>` (catalog w43
 *   "balance_case_nodes fingerprint PROVES a real switch"; sibling PadInfoMode is the same).
 *   ⚠️ `case 2: case 3: return 1;` does NOT work -- group_case_nodes MERGES adjacent nodes that
 *   share a label into the range 2..3, leaving only 2 nodes, which is a LINEAR chain with a
 *   `slti $v0,$v1,2` range test (20 spliced / 17 @41 unspliced).  The two `return 1;` statements
 *   must be written SEPARATELY so each case gets its own label => 3 nodes => the tree.  cross_jump
 *   then merges the two bodies and reorg steals `li $v0,1` into the case-2 `beq` delay slot while
 *   case 3 keeps the full `j <ret>; li $v0,1` block -- exactly the oracle's .L800EFF44.
 *
 * OLD NOTES (kept for the falsification record; the "FLOOR" verdict is now RETIRED):
 * FLOOR (16 diffs): same duplicate-vs-share tail-merge / branch-polarity class seen throughout
 * this wave (chkRC2wait, _padSetMainMode_snd) -- oracle emits `beq state,K,RETURN_SITE` (jump
 * TO each return literal's own `li v0,K;j common_tail` block) for both the s==2 and s==6 arms,
 * while ours emits `bne state,K,SKIP` (skip-around) for the s==2 arm. Tried+reverted: fully
 * flat guard-chain (if(s==2)return1;if(s==6)return4;) -- drops the oracle's `slti v0,s,4` (s<4)
 * test entirely, worse (17 diffs); explicit `return d->state;` duplicated into the s<4 arm --
 * also worse (26 diffs, breaks the delay-slot-shared slti). Kept the nested if/else-if shape
 * that reproduces the slti test faithfully.
 * w48-a4 RE-GATED + QUANTIFIED THE SPLICE TRADE-OFF (the note above predates it):
 *   WITH the per-fn -fno-delayed-branch splice   = 10 diffs @50/48  (current, best)
 *   WITHOUT it                                   = 16 diffs @44/48
 * The two basins fail in OPPOSITE directions and no source shape bridges them: unspliced, cc1
 * fills the two arm branches exactly like retail (`beq $v1,$v0 / li $v0,1`) but then swaps the
 * epilogue (`lw ra; nop; jr ra; addiu sp` vs retail's `lw ra; addiu sp; jr ra; nop`) and drops
 * the two `j default / nop` block terminators (44 vs 48); spliced, the epilogue is exact but the
 * arm slots go `nop` and the polarity flips to `bne`+skip.  Retail therefore had delayed-branch
 * ON *and* the epilogue shape our reorg will not produce -- i.e. this fn needs the SAME
 * epilogue-swap fix as _padInitDirSeq/_pad_reset_state (w48 a10/a6 assembler lane), not a
 * source change.  Falsified in BOTH basins (8 probes): `goto def;` after the s<4 arm, gotos in
 * both arms, a single trailing `goto def;`, and the plain if/else-if -- all byte-identical
 * (10 spliced / 16 unspliced). */
int PadGetState(int port)
{
    _PadDev *d = _padFuncPort2Info(port);
    if ((d->status & 0xffff0000) != 0 ||
        (d != d->self && d->connected != 0) ||
        *d->flag_ptr != 0) {
        switch (d->state) {
        case 2:
            return 1;
        case 3:
            return 1;
        case 6:
            return 4;
        default:
            break;
        }
    }
    return d->state;
}

/* @0x800EFF60 : PadInfoMode -- query a controller mode property.
 * MATCH (w48-a4, 42 -> PASS 62/62): it is a REAL `switch (term)`, not an if/else-if cascade.
 * The oracle's dispatch is gcc-2.8's balance_case_nodes fingerprint over the 5 case values
 * {1,2,3,4,100}: median pivot `beq $s0,3` at the root, then the bound test `slti $v0,$s0,4`
 * splitting into the {1,2} and {4,100} subtrees, each ending in the shared default -- and every
 * case BODY laid out OUT-OF-LINE, in SOURCE order (1, 2, 3, 4, 100), each terminated by
 * `j <shared epilogue>`.  The if/else-if form inlines the bodies at their tests and inverts the
 * polarity to `bne`+skip (42 diffs, 4 insns short).  A `switch` with a result variable and
 * `break`s is byte-identical to the direct-return form here; direct returns kept as the simpler
 * source.  (Catalog: "collapsed-switch fingerprint", w42/w43.) */
int PadInfoMode(int port, int term, int offs)
{
    _PadDev *d = _padFuncPort2Info(port);

    switch (term) {
    case 1:
        return d->mode1;
    case 2:
        return d->modeword;
    case 3:
        return d->mode3;
    case 4:
        if (offs < 0)
            return d->nmode;
        if (offs < (int)d->nmode)
            return d->mode_tbl[offs];
        return 0;
    case 100:
        return d->term100;
    }
    return 0;
}

/* @0x800F0058 : PadInfoAct -- query an actuator property (5-byte records). */
int PadInfoAct(int port, int actno, int term)
{
    _PadDev *d = _padFuncPort2Info(port);
    if (actno < 0)
        return d->nact;
    if (actno < (int)d->nact) {
        unsigned char *e = d->act_tbl + actno * 5;
        switch (term) {
        case 1: return e[0];
        case 2: return e[1];
        case 3: return e[2];
        case 4: return e[3];
        case 5: return e[4];
        }
    }
    return 0;
}

/* @0x800F012C : PadSetActAlign */
int PadSetActAlign(int port, unsigned char *data)
{
    _PadDev *d = _padFuncPort2Info(port);
    return _padSetActAlign(d, data);
}

/* @0x800F0164 : PadSetMainMode */
int PadSetMainMode(int port, int offs, int lock)
{
    _PadDev *d = _padFuncPort2Info(port);
    return _padSetMainMode(d, offs & 0xff, lock & 0xff);
}

/* @0x800F01AC : PadSetAct */
void PadSetAct(int port, unsigned char *data, int len)
{
    _PadDev *d = _padFuncPort2Info(port);
    _padSetAct(d, data, len);
}
