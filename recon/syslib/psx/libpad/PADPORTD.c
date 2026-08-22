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
static unsigned char _pad_info[2 * 0xf0];          /* @0x80147600 : 2 info blocks, EXACTLY 0x1E0
                                                      bytes -- the next symbol is mutexbuf @0x801477E0
                                                      = 0x80147600 + 0x1E0 (configs/symbol_addrs.txt).
                                                      w59-a7: the old `+0x40` slack existed only to
                                                      cover the mis-transcribed `bzero(_pad_info+0x40,
                                                      0x1E0)`, which really overran into mutexbuf. */

/* forward declarations */
extern unsigned char *_pad_failall(int flag);
extern void           _pad_reset_state(unsigned char *info);
extern int            _pad_getbyte(unsigned char *info, int align);
extern void           _pad_filter(unsigned char *info);
extern int            _pad_port_to_slot(unsigned char *p);
extern unsigned char *_pad_get_port(int slot);
extern unsigned       _pad_shift(unsigned char *info);

/* @0x800FDD28 : PadInitDirect
 * w59-a7: 51 @89/88 -> 36 @88/88 (count-exact).  Four oracle re-reads, one of them a REAL BUG:
 *  (1) ** BUGFIX: `bzero(_pad_info, 0x1E0)` -- the oracle's arg insn is `addu $a0,$s0,$zero`
 *      (s0 == &_pad_info, proven by the neighbouring `sw $s1,48($s0)` = info[0x30]), NOT
 *      `addiu $a0,$s0,0x40`.  The old `_pad_info + 0x40` skipped port 0's first 0x40 bytes AND
 *      ran 0x40 bytes past the array into `mutexbuf` (@0x801477E0 == _pad_info + 0x1E0, so the
 *      array is EXACTLY 2*0xF0 -- the old `+0x40` slack in its declaration existed only to
 *      paper over this).  `addiu $a0,$s0,0x40` DOES appear in the oracle, but LATER: it is the
 *      loop's second induction cursor (below).
 *  (2) ONE WALKING BASE POINTER: retail keeps `&_pad_info` in $s0 and reaches everything by
 *      displacement (`sw $s1,48($s0)`, `sw $s2,288($s0)`), then walks it `addiu $s0,$s0,240`.
 *      Spelling the stores as `_pad_info + 0xf0 + 0x30` lets cse const-fold each into its own
 *      absolute `lui $at,%hi(sym+off); sw` pair.  The base must ALSO be OPAQUE -- the
 *      zero-insn identity fence after `_padInitDirSeq()` is what stops that folding (position
 *      is load-bearing: the same fence at the DECL measures 38, after the call 36).
 *  (3) the padbuf pointer is spelled INLINE at both uses (two `lw $v0,-16($a0)` -- see below).
 *  (4) the 6-byte fill is the sibling _pad_reset_state's do/while idiom, not an index `for`.
 * With those, gcc reproduces retail's SECOND induction cursor `$a0 = info + 0x40` (all five
 * body accesses fold to negative displacements -52/-48/-16/-4/0 off it) and all four givs.
 * RESIDUAL 36 @88/88: a pure 3-WAY s-BAND ROTATION -- ours {pad1=$s0, pad2=$s1, base=$s2},
 * retail {base=$s0, pad1=$s1, pad2=$s2}; every diff line is that rotation plus the prologue
 * save order and the three `addiu sN,sN,240`/giv bumps that follow it.  The base allocno must
 * be assigned FIRST (global.c priority order).  FALSIFIED (w59-a7, all measured): in-loop
 * read-only fence on the base (36, inert); 2-operand read-only fence on pad1+pad2 after their
 * stores (36, inert); identity fence at the decl (38, worse).  => this is the receipted 06E
 * global/local-alloc handout gap; next instrument is allocsim `--want base=$s0` + reqdelta,
 * NOT more spelling sweeps.  Rung ladder re-run at this basin (04Z): 2.7.2 (wired) is optimal
 * -- 2.6.3 = 4/8 PASS w/ _pad_filter 27, 970404 = 2/8, 2.8.0/2.8.1 = 1/8.
 * MATCH (w61-a5, 36 -> PASS 88/88) -- the w59 "06E allocator gap" verdict was WRONG; the s-band
 * rotation was a SOURCE-SHAPE consequence, found by reading the cc1 -dl/-dg dumps (qty272.py,
 * 12A: the 2.7.2 lane is instrument-lit).  Three edits, in this order:
 *  (A) SPLIT THE LOOP CURSOR FROM THE BLOCK-0 BASE (`cur = info;` + the body walks `cur`).
 *      THE MECHANISM (dumps, not guessed): with ONE walking `info`, that pseudo is used in two
 *      blocks => a GLOBAL allocno, so local_alloc runs first and hands the only two remaining
 *      call-crossing LOCAL qtys -- pad1/pad2 -- the numerically-first call-saved regs $s0/$s1
 *      (local-alloc.c find_free_reg is a plain numeric scan once call_used_reg_set is excluded),
 *      and global.c is left with $s2 for the base.  Splitting makes the block-0 base a LOCAL
 *      qty too, with MORE refs than either pad, so local_alloc allocates it FIRST -> $s0, the
 *      pads take $s1/$s2, and the loop cursor coalesces onto the same $s0.  Retail's exact
 *      band, and the whole rotation + prologue-order + giv-bump diff class went with it.
 *      36 -> 16, count-exact 88/88.
 *  (B) MATERIALIZE THE BASE AFTER `_padInitDirSeq()` (decl split from init, 12D): retail's
 *      `lui $s0,%hi(_pad_info)` sits AFTER the jal, i.e. the base pseudo is born after the
 *      call (calls_crossed 2 -> 1).  `unsigned char *info;` + `info = _pad_info;` after the
 *      call.  16 -> 10.  The identity fence must STAY (without it: 20 @90/88 -- cse const-folds
 *      the two `sw` into absolute `lui $at,%hi(sym+off)` pairs again, w59 receipt (2)).
 *  (C) THE `cur += 0xf0` WALK BELONGS IN THE for-HEADER (`for (p = 0; p < 2; p++, cur += 0xf0)`).
 *      As a body statement its bump is emitted with the loop-body insns and lands 4th of the
 *      five bottom bumps; in the header it joins loop.c's giv-update group, which emits
 *      a3/a2/t0/a0 first and leaves the cursor bump LAST -- so reorg steals exactly that one
 *      into the `bnez` delay slot = retail's `bnez $v0,.L800FDE08 / addiu $s0,$s0,0xF0`.
 *      It also fixes the `addiu $a0,$s0,64` preheader position.  10 -> PASS.
 * FALSIFIED at this basin: swapping the rxbuf/buf2 store order (20); a hand-rolled
 * `while (p < 2) { ... p++; }` with the walk in the body (10, identical to the for form). */
extern void PadInitDirect(unsigned char *pad1, unsigned char *pad2)
{
    unsigned char *info;
    unsigned char *cur;
    int p;

    _padIntExec  = 0;
    _padModeMtap = 0;
    _padInitDirSeq();
    info = _pad_info;
    __asm__("" : "=r"(info) : "0"(info));

    _padFuncNextPort  = _pad_failall;
    _padFuncClrInfo   = _pad_reset_state;
    _padFuncGetTxd    = _pad_getbyte;
    _padFuncCurrLimit = _pad_filter;
    _padFuncPtr2Port  = _pad_port_to_slot;
    _padFuncPort2Info = _pad_get_port;
    _padInfoDir       = info;
    _padFuncClrCmdNo  = _pad_shift;

    bzero(info, 0x1e0);       /* BUGFIX (w59-a7): the oracle's arg is `addu $a0,$s0,$zero`
                                    * = &_pad_info, NOT +0x40.  0x1E0 = 2 * 0xF0 = the WHOLE
                                    * two-port array; the old `+ 0x40` both skipped port 0's
                                    * first 0x40 bytes and ran 0x40 bytes past the end. */
    *(unsigned char **)(info + 0x30) = pad1;
    *(unsigned char **)(info + 0xf0 + 0x30) = pad2;

    cur = info;
    for (p = 0; p < 2; p++, cur += 0xf0) {
        unsigned char *q = cur + 0x5d;
        unsigned char fill = 0xff;
        int n = 5;
        *(int *)(cur + 0x0c) = 0;
        *(unsigned char **)(cur + 0x10) = cur;        /* self ptr */
        /* MATCH (w59-a7): the padbuf pointer is spelled INLINE at BOTH uses -- the oracle
         * carries TWO `lw $v0,-16($a0)` because the first `sb` may-alias cur[0x30]; a cached
         * local emits only one load.  Same law as _padRecvAtLoadInfo's rx pointer. */
        (*(unsigned char **)(cur + 0x30))[0] = 0xff;
        (*(unsigned char **)(cur + 0x30))[1] = 0;
        *(unsigned char **)(cur + 0x3c) = _pad_rxbuf[p];
        *(unsigned char **)(cur + 0x40) = _pad_buf2[p];
        /* MATCH (w59-a7): the 6-byte 0xFF fill is the SAME do/while-with-named-fill idiom that
         * seals the sibling _pad_reset_state (forward pointer + down counter); the index form
         * `for (i=0;i<6;i++) cur[0x5d+i]=0xff;` makes gcc reverse the walk. */
        do { *q++ = (unsigned char)fill; } while (--n >= 0);
    }

    _padSetVsyncParam();
    _padIntExec = 1;
}

/* @0x800FDE88 : _pad_reset_state (_padFuncClrInfo) -- wipe a port's transient state.
 * Oracle: addiu v1,a0,93; addiu a1,zero,255; addiu v0,zero,5 (ptr/fill/counter order).
 * Loop: sb a1,0(v1); addiu v0,v0,-1; bgez v0; addiu v1,v1,1 (delay). 6 iters total.
 * MATCH (2026-08-14, 2 @26/26 -> PASS): the fill value is an `unsigned char`, matching both the
 * destination element and the SDK-era source idiom.  Keeping it as `int` let constant propagation
 * rematerialize 255 after the counter's `li`; the narrow local retains the same instruction set
 * while emitting the retail ptr/fill/counter order.  Earlier int-local probes that swapped the
 * fill/count declarations or used zero-instruction fences were neutral or worse. */
extern void _pad_reset_state(unsigned char *info)
{
    if (info[0x49] != 0) {
        unsigned char *p = info + 0x5d;
        unsigned char fill = 0xff;
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
 *      source (a separate loop variable initialised from the param).
 * MATCH (w61-a5, 26 -> 17 @60/61) -- THREE cooperating edits, each measured, each with the
 * gcc mechanism read off the cc1 -dg/-dl dumps (qty272.py at the wired 2.7.2 rung):
 *  (i) `ret` IS THE `else` ARM, not a pre-staged default.  The old `ret = 1;` before the guard
 *      let sched1 hoist the `li` to the TOP of the block (RTL insn 83 landed in the load-delay
 *      slot of `lw _padSioRegs`), so ret's live range spanned every $v0/$v1 local qty in that
 *      block -> `73 conflicts: ... 2 3 ...` in the .greg = a HARD-REG conflict with $v0, and
 *      find_reg had to give ret $a1 (the two `addu` copies, w59's "ret parks in $a1" residual).
 *      Writing `if (...) ret = call(...); else ret = (unsigned char *)1;` puts the `li` in the
 *      guard-branch's delay slot (methodology 5.0c else-in-delay-slot), the conflict disappears
 *      and ret takes retail's $v0 -- both copies gone.  26 -> 20.
 *  (ii) VOID-TAIL FENCE AFTER `flag = 0xffff;` (zero insns) restores retail's whole loop tail.
 *      Without it reorg's BACKWARD scan for the loop-back `beqz` steals the flag store into its
 *      delay slot; that empties the join, so the call arm's `j` has nothing to steal and
 *      relax_delay_slots deletes it (ours: `beqz; li 0xffff`).  The fence walls the backward
 *      scan (06B hard boundary), so reorg instead fills the arm's `j` from the TARGET thread --
 *      copying the flag store into the `j` slot and redirecting past it -- which is exactly
 *      retail's `j; ori [slot]; ori; beqz; nop`.  20 -> 19, +3 insns, count 60/61.
 *  (iii) SPLIT THE CHANNEL READ FROM THE INCREMENT (`chan = _padSioChan; ... chan = chan + 1;
 *      _padSioChan = chan;`) -- the fused `_padSioChan = _padSioChan + 1` keeps the load, the
 *      add and the compare in one dependence chain, so sched1 emits `slt` BEFORE the store
 *      macro; split, the load floats up and the `slt` lands after `sw _padSioChan` = retail.
 *      19 -> 17.  (Same family as catalog B "split the load from the decrement".)
 * FALSIFIED at this basin (all measured, output byte-identical unless noted): flag=0xffff
 *   duplicated into both arms (20, cross_jump merges them back); `int f = flag;` separate loop
 *   var (19); identity fence on flag in the loop (19), before the loop (19); read-only fence on
 *   flag after the tests (36); void fence BEFORE the flag store (20); statement-order sweep of
 *   the state/JOY/chan trio (17 / 19 / 22 / 22); a `sio = _padSioRegs` pointer local to seed the
 *   LUID order of the two loads (17, both placements).
 * RESIDUAL 17 @60/61, TWO named classes:
 *  (a) THE PARM COPY (7 lines): retail copies the incoming `flag` to $a1 (`addu $a1,$a0,$zero`)
 *      and runs both tests off $a1; ours keeps it in $a0.  The .greg shows why no dial reaches
 *      it: `72 preferences: 4` -- the parm pseudo carries a HARD-REG COPY PREFERENCE for $a0
 *      from its own entry copy, and find_reg honours preferences BEFORE the numeric scan (12A),
 *      so neither a priority dial nor any of the six fence/split spellings above can move it.
 *      Retail's pseudo must carry a hard CONFLICT with $a0 that ours lacks.  ANGLE (named, not
 *      floored): the 12A "zero-insn preference killer" -- a device that defines the parm pseudo
 *      by something other than a reg-reg copy from $a0.  Needs the instrument, not spellings.
 *  (b) THE TWO-LOAD LUID TIE (4 lines): retail issues `lw _padSioRegs` then `lw _padSioChan`,
 *      ours the reverse.  Pure sched1 ready-list tie between two independent loads; the source
 *      statement order of the pair does NOT flip it (sweep above), consistent with sched.c's
 *      backward list order.
 *      ** THAT ANGLE IS NOW FALSIFIED (w59-a7 -- all three probes measured 34 @59/61, output
 *      byte-identical): (i) a separate `int f = flag;` loop variable (gcc coalesces it straight
 *      back onto the parm's $a0); (ii) the same split PLUS an identity fence on `f` (the fence
 *      emits nothing and the copy is still deleted); (iii) `int ret` instead of
 *      `unsigned char *ret` with the cast moved to the return (drops the `(unsigned long)`
 *      intermediate -- no change).  RESTATEMENT of the residual: retail parks `ret` in $v0 (so
 *      both `ret = _padInitSioMode(...)` and `return ret` need no move) and PAYS for it with the
 *      entry parm copy + a duplicated `ori $a1,0xFFFF` + a `nop`; ours parks `ret` in $a1, keeps
 *      the parm in $a0 and pays two moves instead (59 vs 61 insns).  ONE allocno decision, not a
 *      source shape => the 06E global/local-alloc gap; instrument = allocsim `--want ret=$v0` +
 *      reqdelta.  Rung ladder re-run at this basin (04Z): wired 2.7.2 is optimal (2.6.3 26,
 *      970404 56, 2.8.0 / 2.8.1 58).
 * QUANTIFIED HARDNESS CERTIFICATE for (a) (w62-a4, gcc-source-cited, 17 unchanged) -- the parm
 * register is NOT reachable by any allocno dial, and the reason is a rule nobody had read:
 *   .greg: pseudo 72 = `flag`, refs 7 / live 13 / calls 0, rank 4, `72 preferences: 4`, conflicts
 *   {73,74,76,77,82,84, hard 2, hard 29} -- $a0 is NOT among its hard conflicts.  find_reg's
 *   copy-preference override (global.c:1033-1075) therefore hands it $a0 and delete_noop_moves
 *   eats retail's `addu $a1,$a0,$zero`.  The two exits are both closed:
 *   (1) `regs_someone_prefers` CANNOT evict $a0 here.  prune_preferences (global.c:865-876) ORs in
 *       each lower-priority conflicting allocno's preferences, but FIRST subtracts the allocno's
 *       OWN preferences whenever `allocno_size[j] <= allocno_size[allocno]` -- and every rival here
 *       is SImode like 72.  So a reg 72 itself prefers can never be pruned away from it.  ** A
 *       LOWER-PRIORITY ALLOCNO'S PREFERENCE CANNOT EVICT A REGISTER THE ALLOCNO ITSELF PREFERS AT
 *       EQUAL SIZE ** -- catalog-row candidate; it kills the whole "give a rival the $a0 copy
 *       preference" family for any parm-copy residual, in-tree and elsewhere.
 *   (2) A HARD CONFLICT with $a0 is the only other route, and the only $a0-live regions in the fn
 *       are the two call-arg setups -- so any source form that keeps `flag` live to one of them
 *       also makes it CROSS that call (allocno_calls_crossed > 0), and find_reg then excludes
 *       every call-used reg: MEASURED, `flag = 0xffff` hoisted to just after the first `if`
 *       (4 positions x fence/no-fence) = 36 @63 with `addu $s1,$a0,$zero` -- the copy appears but
 *       in a CALLEE-SAVED register, +1 saved reg, +8 frame.  The class is structurally bounded.
 * ALSO FALSIFIED w62-a4 (this basin, all measured by me): identity fence on `flag` before the loop
 *   / at the loop top / doubled (17, INERT -- the w59 "19" was a different basin); `int f = flag;`
 *   plain and with an identity launder (17, copy still deleted -- 13B's "cse eats synthetic
 *   copies" limit, the launder does not mint a preference); a named `nextp` local for the
 *   _padInitSioMode argument to manufacture an $a0-preferring rival allocno (43 @62; it does not
 *   conflict with `flag`, and per (1) it could not evict $a0 even if it did).
 * (b) THE TWO-LOAD LUID TIE re-swept w62-a4 -- all SIX orderings of the state/JOY/chan trio:
 *   chan,state,JOY = 17 @60 (landed) | chan,JOY,state = 17 | state,chan,JOY = 17 |
 *   state,JOY,chan = 19 | JOY,state,chan = 22 @61 | JOY,chan,state = 22 @61 | JOY-first + void
 *   fence = 22 @61.  The JOY-first forms DO reach count-parity but pay 5 more diffs (an extra nop
 *   plus the state-store block moving); the tie itself never flips.  Sched1 ready-list, confirmed.
 * w63-a7 2026-08-15 CERTIFICATE RE-VERIFIED: re-gated 17 @60/61, the shape is unchanged (retail's
 *   entry parm copy `addu $a1,$a0,$zero` + `li $a1,65535` x2 vs ours keeping the parm in $a0, plus
 *   the `lui $v0; lw $v0` pair sitting one block earlier in retail).  Both closed routes hold as
 *   written.  ONE ROUTE THE CERTIFICATE DOES NOT COVER, recorded as a NAMED ANGLE (un-measured,
 *   this belt ran out of budget before pricing it): prune_preferences bars a lower-priority rival
 *   from PRUNING a register the allocno itself prefers -- it does NOT stop a HIGHER-priority
 *   conflicting allocno from simply TAKING $a0 first (find_reg then skips it as occupied, no
 *   preference question arises).  So the open family is not "give a rival the $a0 preference"
 *   (closed) but "manufacture a higher-priority allocno that CONFLICTS with `flag`'s insn-1..20
 *   window and lands $a0".  Everything live in that window today is homed callee-saved (s0-s3),
 *   which is why the w62 `nextp` probe did not conflict; the pricing question for allocsim/
 *   reqdelta is whether any value in that window can be given both a caller-saved home and a
 *   priority above `flag`'s rank 4.
 * w64-a7 2026-08-15: re-gated 17 @60/61, shape unchanged; the certificate stands.  The residual
 *   is now fully attributed: of the 17 lines, 13 are the SINGLE decision `flag`=$a0(ours) vs
 *   $a1(retail) -- 3 for the missing entry copy, 2+2 for the two tests, 4 for the two
 *   `li 65535` -- and the remaining 4 are the (b) two-load LUID tie.  SIX NEW FALSIFICATIONS of
 *   the w63 "higher-priority rival takes $a0 first" family, all 17 and byte-identical unless
 *   noted: an IDENTITY FENCE on `flag` as the literal FIRST statement of the function (the 12A
 *   preference-killer, placed where the parm copy IS the fenced insn -- 17, so killing the
 *   preference is NOT enough: find_reg's plain ascending scan hands $a0 anyway once $v0/$v1 are
 *   taken by block-0 local qtys); the same fence DOUBLED (17); a named `off` temp for the
 *   `_padSioChan * 0xf0` product (17); a named `c0` channel temp (17); the same + an identity
 *   launder on `c0` (22 @61 -- it manufactures a rival but a CALLEE-saved one); fence + `c0`
 *   together (17).  ⇒ the un-covered route needs a rival that is BOTH caller-saved AND
 *   higher-priority than rank 4, and every value live in insns 1..20 that could be given a
 *   caller-saved home is block-local (local_alloc, which runs first, parks those in $v0/$v1 and
 *   never reaches $a0).  Sharpened statement of the open angle: the rival must be a GLOBAL
 *   allocno, born in the entry block, not call-crossing, ranked above 4, and conflicting with
 *   `flag` -- allocsim/reqdelta272 pricing job.
 * MATCH (A14/w71, 17 -> 8 @61/61 COUNT-EXACT) -- residual class (a), the parm copy, is CLOSED,
 *   and the w62/w63/w64 certificate is REFUTED on its own terms: the two exits it priced were
 *   the only two it knew about, but there is a THIRD -- deny the hard register itself.  The
 *   device is 20B (W69, StatusReply): an identity launder that ALSO CLOBBERS the hard reg,
 *   `__asm__("" : "=r"(flag) : "0"(flag) : "$4")`.  Mechanism, in the certificate's own terms:
 *   the `"0"` tie makes the asm NON-VOLATILE (an output-bearing asm is not implicitly volatile),
 *   so it is NOT a sched1 barrier -- the w64 "identity fence as the first statement" probe used
 *   the launder WITHOUT the clobber and therefore only killed the copy-PREFERENCE, which the
 *   certificate correctly observed is not enough (find_reg's plain ascending scan hands $a0
 *   anyway).  The `"$4"` clobber is the missing half: reload/local-alloc put an asm-used hard reg
 *   in `regs_explicitly_used`, so $a0 is excluded from the scan for `flag` outright and retail's
 *   entry copy `addu $a1,$a0,$zero` MINTS.  Both tests, both `li $a1,65535` and the copy -- 13 of
 *   the 17 lines -- go in one edit, and the count becomes exact 61/61.
 *   RESIDUAL 8 @61/61, TWO classes, both position-only (every WORD is now retail's):
 *   (a') PROLOGUE ORDER, 4 lines: retail emits the loop-invariant materializations in the order
 *        [`lui/addiu $s1` = &_pad_info] [`li $s3,-9`] [`lui/addiu $s2` = &_padFixResult] (each
 *        preceded by its own `sw sN`), i.e. the -9 sits BETWEEN the two LICM hoists = it is
 *        itself a loop.c movable emitted in order of appearance.  Ours emits `li $s3,-9` FIRST
 *        because the named `noport` is straight-line pre-loop code and LICM inserts its hoists
 *        after it.  FALSIFIED (A14, all measured): `noport = -9;` assigned INSIDE the loop
 *        (19 @60 -- loop.c DECLINES the movable, `li $v0,-9` stays in the loop and the 4th saved
 *        reg + the 0x28 frame go with it); a bare `-9` literal in the loop (19 @60, identical);
 *        a named `base = _pad_info` declared before `noport` so the base is straight-line too
 *        (24 @63 -- it rotates the whole s-band); `noport` declared last / declared first /
 *        split decl+assign (all 8, inert -- declaration position is NOT the dial here); an
 *        identity launder on `noport` (20).  ANGLE: loop.c declined our -9 movable, so the
 *        question is 13C's ":1640 budget" -- a zero-insn device that raises the constant's
 *        savings so it hoists in appearance order.
 *   (b') the TWO-LOAD LUID TIE, 4 lines (retail `lw _padSioRegs` then `lw _padSioChan`, ours the
 *        reverse), RE-SWEPT at this basin per 04Z and unchanged: all six orderings of the
 *        state/JOY/chan trio (chan,state,JOY / chan,JOY,state / state,chan,JOY = 8; state,JOY,chan
 *        = 10; JOY,chan,state / JOY,state,chan = 13 @62), a discarded `sio = _padSioRegs` read
 *        before the trio (8), and three fused-increment spellings (`chan = _padSioChan + 1`,
 *        `_padSioChan = _padSioChan + 1`, chan-load-after-the-stores; all 10).  Sched1 ready-list
 *        tie, confirmed a second time.
 * *** MATCH (W72-A17): SEALED, PASS 61/61, pin-free.  BOTH residual classes closed by TWO
 * COUPLED edits -- land them together, each alone leaves 4 diffs. ***
 *  (a'') THE -9 MOVABLE, closed by 21B-3 (born-in-the-loop) + 13C's :1640 LIFETIME dial,
 *        read off `-dL` on the lane binary (tools/qty272.py --keep) instead of guessed:
 *            Loop from 12 to 131: 40 real insns.
 *            Insn 25: regno 82 (life 2), move-insn savings 2  moved to 145   <- &_pad_info
 *            Insn 30: regno 74 (life 1), move-insn savings 1 not desirable   <- the -9
 *            Insn 42: regno 84 (life 2), move-insn savings 1  moved to 147   <- &_padFixResult
 *        move_movables (loop.c:1640) moves iff `threshold*savings*lifetime >= insn_count`;
 *        savings = n_times_set = 1 and is NOT source-reachable (loop.c:600), insn_count = 40,
 *        so LIFETIME is the only input -- and the two movables that DID move differ from the
 *        -9 by exactly one luid (life 2 vs 1).  CURE = assign `noport = -9;` INSIDE the loop
 *        (that is what makes it a movable at all -- the old pre-loop `int noport = -9;` is
 *        straight-line entry-block code that LICM cannot reorder) AND put ONE zero-insn insn
 *        between its set and its use so life becomes 2.  The hoist then lands in appearance
 *        order and the prologue is retail's, register for register:
 *            lui/addiu $s1 (&_pad_info) | li $s3,-9 | lui/addiu $s2 (&_padFixResult).
 *        Both fence flavours work (void-tail `"i"(0)` = landed, read-only `"r"(info)` = also
 *        PASS); the fence is REQUIRED (no fence = 15 @60, the movable is declined again and
 *        the 4th saved reg + the 0x28 frame go with it).  FALSIFIED at this basin: the set
 *        placed BEFORE `info = ...` (with `info` split into decl+assign so C89 allows it),
 *        with and without the fence -- 4 both ways, i.e. the movable is only created when its
 *        set sits at that RTL position.
 *  (b'') THE TWO-LOAD LUID TIE, closed by VARIABLE IDENTITY, not by statement order (the
 *        six trio orderings were re-swept a THIRD time at this new basin per 04Z and are still
 *        flat: chan,state,JOY / chan,JOY,state / state,chan,JOY = 4; state,JOY,chan = 6;
 *        JOY-first x2 = 9 @62).  Retail issues `lw _padSioRegs` then `lw _padSioChan`; ours the
 *        reverse because `chan` is SET TWICE (`chan = _padSioChan` then `chan = chan + 1`), so
 *        its load's pseudo is not a single-set birth and sched1 ranks the pair the other way.
 *        Give EACH load its own SINGLE-SET local -- `sio` for the SIO0 base and `c0` for the
 *        channel -- and the issue order is retail's.  BOTH are needed: `c0` alone = 4,
 *        `sio` alone = 4, a merely DISCARDED `sio` read (the w64 probe) = 4.  `sio` must
 *        CARRY the store (`*(volatile u_short *)(sio + 0x0a) = 0`, i.e. JOY_CTRL spelled
 *        through the local); keeping the JOY_CTRL macro beside a live `sio` re-loads the
 *        pointer and stays at 4. */
extern unsigned char *_pad_failall(int flag)
{
    unsigned char *ret;
    int noport;
    int chan;
    int c0;              /* MATCH: single-set home for the _padSioChan load, see (b'') */
    unsigned char *sio;  /* MATCH: single-set home for the _padSioRegs load, see (b'') */

    /* MATCH (A14/w71): 20B preference-killer -- identity launder + a HARD-REG CLOBBER of $a0.
     * The launder's `"0"` tie drops the implicit volatility (so this is NOT a sched barrier and
     * costs ZERO instructions); the `"$4"` clobber enters regs_explicitly_used and denies $a0 to
     * `flag`, which is what mints retail's entry copy `addu $a1,$a0,$zero` and moves both tests
     * and both `li $a1,65535` onto $a1.  Do NOT drop either half: launder alone = 17 (the w64
     * falsification), and the clobber is what the five-wave "quantified hardness certificate"
     * above was missing.  17 -> 8, count-exact 61/61. */
    __asm__("" : "=r"(flag) : "0"(flag) : "$4");
    do {
        unsigned char *info = _pad_info + _padSioChan * 0xf0;
        /* MATCH (W72-A17): `noport` is BORN IN THE LOOP so loop.c enters it as a movable, and
         * the zero-insn fence below buys the ONE luid of lifetime that move_movables' :1640
         * budget is short of (life 1 -> 2).  The hoist then lands BETWEEN the two address
         * hoists, in appearance order = retail's prologue.  Do not hoist the assignment out,
         * do not delete the fence -- see the (a'') block above. */
        noport = -9;
        __asm__("" : : "i"(0));
        if (flag != noport) {
            if (flag == 0)
                _padFixResult[_padSioChan] = 0;
            else {
                _dirFailAuto(info);
                _pad_shift(info);
            }
        }
        /* MATCH (W72-A17): one SINGLE-SET local per load -- see (b'') above.  `sio` is
         * JOY_CTRL's own base (`JOY_CTRL` == `*(volatile u_short *)(_padSioRegs + 0x0a)`);
         * spelling the store through it is what keeps the pointer load a single-set birth. */
        sio = _padSioRegs;
        c0 = _padSioChan;
        _padSioState = 0;
        *(volatile unsigned short *)(sio + 0x0a) = 0;   /* JOY_CTRL = 0 */
        chan = c0 + 1;
        _padSioChan = chan;
        if (chan <= _padChanStop)
            ret = (unsigned char *)(unsigned long)
                  _padInitSioMode(_pad_info + chan * 0xf0);
        else
            ret = (unsigned char *)1;
        flag = 0xffff;
        __asm__("" : : "i"(0));
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
 * RESIDUAL 10 @43/47 (w55-a6 re-gate at the cc1_alt 2.7.2 basin -- the 20 @51/47 figure below is
 * the STALE 2.8-basin number; the sign flipped, ours is now 4 instructions SHORT).  The class is
 * CROSS-JUMP DIRECTION, not threading: retail's shared `lbu $v0,0($v0)` (.L800FE058) is the TAIL
 * OF CASE 0 -- case 0 falls through into it and the 'M' arm jumps INTO it
 * (`j .L800FE058 / addu $v0,$v0,$v1` in the slot) -- while OURS keeps the copy in the 'M'/shared
 * block and makes CASE 0 do the `j`.  do_cross_jump kept the wrong copy (w45 "merge DIRECTION,
 * not depth"), and the 'M' guard's polarity inverts with it (ours `bnez`, retail `beqz` with
 * `li $v0,255` in the slot).  FALSIFIED at this basin (w55-a6) -- all THREE compile to the
 * BYTE-IDENTICAL 43 instructions, i.e. gcc canonicalizes the whole family: case 0 ending in a
 * direct `return (*(u_char **)(info+0x28))[idx];` instead of `break`; the 'M' guard written with
 * the buf path as the if-BODY (`if (idx < info[0x35]) { buf = ...; break; } return 0xff;`);
 * an explicit `common:` label INSIDE case 0 with the 'M' arm doing `goto common;` (retail's exact
 * CFG spelled out).  ⇒ the merge direction is not source-reachable here; next angle is the
 * do_cross_jump input (which block ENDS in a jump at cross-jump time), i.e. an allocation/label
 * question, or the permuter.
 * MATCH (w61-a5, 10 -> 5 @44/47): a ZERO-INSN VOID-TAIL FENCE IN THE `default` ARM, immediately
 * before its inline `return (*(u_char **)(info+0x2c))[idx];`, un-merges that arm from the 'M'
 * arm and restores retail's WHOLE 'M' block: guard polarity flips to the oracle's `beqz`, the
 * `li $v0,255` lands in its delay slot, and the arm becomes `lw $v0,44($a0); j <shared>;
 * addu $v0,$v0,$v1 [slot]` exactly as retail (12C: find_cross_jump refuses volatile
 * ASM_OPERANDS, so an asm inside a candidate tail is the on-demand merge BLOCKER).  The default
 * arm keeps its own full copy = retail's.  No source shape had reached that polarity in 3 waves.
 * RESIDUAL 5 @44/47 -- ONE class, the same merge DIRECTION as before but now only for case 0:
 *   retail keeps case 0's own `lw 40; nop; addu; lbu` copy and lets the OTHER arms jump into it;
 *   ours still lets case 0 `j` into the surviving copy (`lw 40; j; addu [slot]`), 3 insns short.
 *   FALSIFIED at this basin (all 5, byte-identical): a void fence in case 0 before its `break`;
 *   case 0 rewritten as an inline `return` with a void fence; and all three in-tail fence
 *   flavours placed BETWEEN the pointer load and the index (`__asm__("" : : "r"(buf))`,
 *   the identity fence, and the void fence) -- the asm stops the tail comparison but the
 *   surviving 2-insn tail (`addu`,`lbu`) is still enough for do_cross_jump.  The direction is
 *   decided by which block ENDS in a jump vs falls into the epilogue, which no in-arm spelling
 *   moves: the ANGLE is jump.c's do_cross_jump input (make the `jr ra`-terminated default arm
 *   ineligible as the merge TARGET), i.e. a mechanism/permuter job, not a spelling one.
 *   w62-a4 added the ROLE-SWAP probes the note asks for -- they confirm the canonicalization from
 *   the other side: case 0 given the inline return + void fence WITH 'M'/default sharing the
 *   `buf` tail = 10 @43 (worse: the default arm loses its own copy); case 0 inline-return only,
 *   default fence kept = 5 @44 (byte-identical to the landed form); ALL THREE arms as inline
 *   returns = 5 @44; a read-only fence on `buf` after case 0's pointer load = 5 @44.  Four more
 *   spellings, one output.  do_cross_jump's direction input is confirmed source-invariant here.
 *   w64-a7 added SIX MORE, all 5 @44/47 and byte-identical (the family is now 18 spellings deep
 *   across five waves): case 0 exiting with `goto deref;` while 'M' keeps `break` (a distinct
 *   label for one arm -- the very lever that sealed `_pad_filter`'s loop this wave, so it was
 *   worth the probe; it does NOT reach cross-jump the way it reaches duplicate_loop_exit_test);
 *   the mirror (case 0 `break`, 'M' `goto deref`); BOTH arms `goto deref`; a void-tail fence in
 *   the 'M' arm's tail; a read-only fence on `buf` in the 'M' arm; a void-tail fence immediately
 *   before the shared `return buf[idx]` (8 @45, the only non-neutral one, and worse).
 *   NEW OBSERVATION that sharpens the angle: ours does not merge in the wrong DIRECTION only --
 *   it merges one insn DEEPER.  Retail's surviving copy starts at the `lbu` (.L800FE058) and the
 *   'M' arm keeps its OWN `addu $v0,$v0,$v1` (in the `j`'s delay slot); ours merges `addu` + `lbu`
 *   together, which is why we are 3 short rather than 1.  Both arms' `addu`s are textually
 *   identical post-reload, so retail's find_cross_jump STOPPED one insn early -- that, not the
 *   direction, is the cheapest thing to explain, and it is a jump.c input question.
 * MATCH (A14/w71, 5 -> PASS 47/47) -- the five-wave, 18-spelling "do_cross_jump direction is
 *   source-invariant" verdict was WRONG, and the reason is a placement law worth banking: EVERY
 *   prior probe put its fence BEFORE the deref (in the arm body, at the `break`, between the
 *   pointer load and the index), where the fence has no value to hold and the surviving 2-insn
 *   tail `addu;lbu` is still merge-eligible.  Putting a ONE-OPERAND READ-ONLY FENCE **between the
 *   `lbu` and the `return`** -- i.e. on the LOADED BYTE, inside the tail itself -- is what makes
 *   case 0's tail un-mergeable (12C: find_cross_jump refuses a tail containing an asm), so case 0
 *   keeps its own `lw 40; nop; addu; lbu` copy and jumps to the epilogue exactly like retail,
 *   while 'M' still merges into the default arm's surviving copy.  Requires the arm to end in an
 *   inline `return` through a named temp (the `break`+shared-tail form has no tail to fence).
 *   The identity launder in the same position also PASSes; the void fence `"i"(0)` there does NOT
 *   (5, byte-identical) -- an operand-less asm has nothing to keep live.  ALSO MEASURED at this
 *   basin: case 0 fenced + 'M' and default sharing the tail = 10 @43; case 0 laundered + 'M' and
 *   default sharing = 5 @46.  GENERAL LAW (catalog candidate): to un-merge ONE arm of an N-arm
 *   cross_jump, the fence must sit INSIDE the tail you want to keep, holding a live value, not
 *   upstream of it.
 *   BRANCH-WORD AUDIT (11C/04Q discipline, `tools/brdist.py`): baseline 6 offset diffs -> LANDED
 *   1, and the survivor is NAMED: branch #8, the 'M' arm's `j`.  Retail's 'M' merges BACKWARD
 *   into case 0's `lbu` copy (`j .L800FE058`, distance -9); ours merges FORWARD into the DEFAULT
 *   arm's copy (distance +10).  Semantically identical (both targets are `lbu $v0,0($v0)` on the
 *   way to the same epilogue) and word-count identical, but the `j`'s absolute target word
 *   differs, so this is a real production-lane residual behind a green gate -- recorded, not
 *   hidden.  It is the SAME merge-direction question, one level down: the fence that keeps case
 *   0's copy alive also makes that copy un-mergeable, so 'M' has nowhere to go but the default's.
 *   Retail needs no fence at all -- its case-0 and default tails differ in their TERMINATOR
 *   (`j epilogue` + slot vs fall-through), which is why they never merge there.  MEASURED
 *   alternatives, all worse on BOTH axes (gate diffs / brdist offset diffs): all three arms
 *   inline with the default fenced 10 @47 / 4; with case 0 AND default fenced 5 @50 / 6; none
 *   fenced 10 @43 / 7; case 0 + 'M' as `break` with the default fenced 8 @47 / BRANCH COUNT 11
 *   vs 10; case-0 inline unfenced + 'M' break + default fenced 8 @47 / count 11 vs 10; case 0
 *   fenced + 'M' inline + default break 5 @46 / 6.  ANGLE: reproduce retail's terminator
 *   asymmetry (case 0 ending in `j epilogue`, default falling into it) WITHOUT a fence.
 *   W74-A20 2026-08-22 -- re-probed that angle from the OTHER arm (make the DEFAULT's tail the
 *   ineligible one so the surviving copy is case 0's and 'M' has to merge BACKWARD into it).
 *   Landed control re-gated PASS 47/47 with the single named brdist row.  Five more spellings,
 *   none reaching both axes: case 0 plain + the A14 byte-fence moved into the DEFAULT tail
 *   8 @47 / BRANCH COUNT 11 vs 10; case 0 laundered + default byte-fenced 3 @50 / count 11;
 *   BOTH tails byte-fenced 3 @50 / count 11; case 0 plain + default keeping only its void fence
 *   5 @44 / 6 offsets; both plain 10 @43 / 7.  The family now stands at 24 spellings across six
 *   waves: fencing a SECOND tail always costs the extra branch (each un-mergeable arm keeps its
 *   own exit), so the direction cannot be bought with another fence -- it needs jump.c's
 *   do_cross_jump pair-selection input, i.e. the mechanism/permuter route the note already
 *   names.  NOTHING LANDED; this function stays exactly as sealed.
 * OLD (stale, 2.8 basin) note: the 4 extra instructions are jump.c RETURN-THREADING -- this fn is a
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
        /* MATCH (A14/w71): case 0 carries its OWN copy of the deref tail in retail; a
         * 1-operand READ-ONLY FENCE on the loaded byte, placed BETWEEN the `lbu` and the
         * `return`, keeps that value live past the load so do_cross_jump can no longer fold
         * case 0's `addu;lbu` into the default arm's surviving copy (12C: an asm inside a
         * candidate tail blocks find_cross_jump).  The 18 prior spellings all put the fence
         * BEFORE the deref, where it has nothing to hold.  5 -> PASS 47/47. */
        {
            int r0 = (*(unsigned char **)(info + 0x28))[idx];
            __asm__("" : : "r"(r0));
            return r0;
        }
    case 'M':                              /* 0x4D align: pad with 0xff */
        if (info[0x35] <= idx)
            return 0xff;
        buf = *(unsigned char **)(info + 0x2c);
        break;
    default:                                 /* fixed command param block */
        if (info[0x35] <= idx)
            return 0;
        __asm__("" : : "i"(0));
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
 * MATCH (w55-a6, 18 -> 16 @159/159): COMMUTATIVE `and` OPERAND ORDER -- write the scan test as
 *   `(mask & *dat) != 0`, MASK FIRST.  The oracle emits `and $v0,$v0,$a3` (loaded byte first,
 *   mask second as operand 1... i.e. the mask is the SECOND source), which is what the
 *   mask-first C spelling produces; `(*dat & mask)` gives the reversed `and $v0,$a3,$v0`.  Pure
 *   2-diff win, count unchanged, no collateral (catalog w42/w43 commutative-operand family --
 *   reachable here because both operands are plain loads, not a mutation).
 * FALSIFIED (w55-a6) on the FIRST search loop, re-confirming the (1) receipt above at the wired
 *   2.7.2 basin: `while (i < nmask)` (18 @161/159 -- gcc adds the zero-trip guard retail lacks);
 *   UNGUARDED `do { ... } while (i < nmask);` (56 @161/159 -- rotates the whole $a2/$a3 band).
 *   The residual `bne $v1,$t1` vs oracle `slt $v0,$v1,$t1; bnez` therefore stays the documented
 *   guard-fold class, not a comparison-operator miss.
 * MATCH (w61-a5, 16 -> 11 @158/159) -- two edits:
 *   (1) SECOND SEARCH LOOP: `if (*m2++ == mode) *flag = 1;` (post-increment FUSED INTO THE LOAD)
 *       instead of a separate `m2++;` after the guard.  Retail puts that bump in the guard
 *       branch's DELAY SLOT (`bne $v0,$t0,.L / addiu $a1,$a1,1`); as its own statement after the
 *       `if` body, reorg's backward scan can only reach it past the conditional store, so ours
 *       emitted `nop` in the slot and the bump after the `sb`.  16 -> 13.
 *   (2) THE SHARED `1` IS A NAMED LOCAL (`unsigned char one = 1;`) declared as the FIRST local
 *       of the `info[0xe9] != 0` block, before `row` (catalog 08D NAMED-ONE; the store becomes
 *       `*flag = one`).  Retail materializes it in the preheader BEFORE `row`'s zero
 *       (`addiu $t3,$zero,1 / addu $t2,$zero,$zero`); as an anonymous literal ours emitted the
 *       hoist AFTER row's init.  Declaring it in the OUTER block instead measures 14.  13 -> 11.
 * RESIDUAL 11 @158/159, THREE named classes:
 *   (a) 3 lines: the first search loop's back-edge -- ours `bne $v1,$t1` (from the `!=` bound
 *       that buys retail's folded `beqz $t1` entry guard), retail `slt $v0,$v1,$t1; bnez`.
 *       Retail has BOTH the folded guard AND the `slt` back-edge, which is the guarded-do-while
 *       shape -- and every guarded form is catastrophic in this basin (w53-a8 measured 61/62;
 *       w61-a5 re-measured three more: `if (nmask != 0) { i = 0; do {...} while (i < nmask); }`
 *       = 46, the same without braces = 53, with `*map++` fused = 51; plain `while (i < nmask)`
 *       = 13 @160 -- same diff count, 2 insns WORSE).  Standing class: guard-fold.
 *   (b) 1 line: the `andi $v1,$v1,255` remask on the second use of `info[0xe8]`.  An `int e8`
 *       local kills the andi but costs 3 elsewhere (14 @157) -- PROMOTE_MODE family (11D).
 *   (c) 7 lines: the 6-byte tail fill.  ** THE STRUCTURE IS NOW SOLVED (w61-a5) ** -- retail's
 *       walking base + kept displacement is reproduced EXACTLY by
 *         `unsigned char fill = 1; int n = 5; unsigned char *f = info + 5;`
 *         `do { f[0x57] = fill; f--; } while (--n >= 0);`
 *       which gives `sb $vN,87($a0)` + `addiu $a0,$a0,-1` in the bgez slot and makes the fn
 *       COUNT-EXACT 159/159 (w59's "source-resistant, 3 walking spellings all 31" is retired --
 *       those spellings dropped the 0x57 displacement).  It measures 14, NOT 11, because the
 *       residual becomes a pure `fill`/`n` $v0<->$v1 LOCAL-ALLOC QTY TIE (retail fill=$v0,
 *       n=$v1; ours reversed) worth 10 lines.  Not landed under the basin rule (14 > 11).
 *       FALSIFIED dials on that tie: all SIX decl-order permutations of {fill,n,f} (14, byte-
 *       identical -- decl order is inert here), read-only fence on `fill` after the loop and
 *       inside it (14), read-only fence on `n` (14), `int fill` instead of `unsigned char` (14).
 *       ANGLE: `n` outranks `fill` by REF COUNT (3 vs 2) in local_alloc's qty_compare, so it is
 *       handed $v0 first; the dial is +1 REF ON `fill` THAT SURVIVES cse (the fences above did
 *       not change the count), or a qty272-priced equivalent -- then the fn is 4 diffs.
 * MATCH (w62-a4, 11 -> 4 @159/159 -- (c) SEALED, the priced dial executed):
 *   The w61 angle was right but under-dialed.  qty272 says fill/n/f are all GLOBAL allocnos
 *   (154/155/156), not local qtys: fill refs 3 / live 14 (pri .214), n refs 7 / live 6 (pri
 *   2.333), f refs 7 / live 5 (pri 2.8, prefs $a0 from `info`).  global.c allocates in priority
 *   order and find_free_reg is a plain ascending scan (12A), so n takes $v0 and fill is left $v1.
 *   To flip, fill's 272 priority (floor_log2(refs)*refs/live, NO size term) must exceed 2.333:
 *   at live 14 that needs refs >= 11 (3*11/14 = 2.357), i.e. +8 refs -- and an IN-LOOP read-only
 *   fence operand is worth +2 each (flow.c loop-depth weighting), so FOUR operands is the exact
 *   minimum.  MEASURED, model-exact: 3 operands = 14 (no flip), 4 = 4, 5 = 4; 8 operands in an
 *   OUT-OF-loop fence = 14 (weight 1 each AND the live range grows).  Placement: before or after
 *   the store both land 4; at the loop TAIL (after `f--`) the barrier costs an insn (7 @160).
 *   `int fill` is neutral (4 with the fence, 14 without) -- the type was never the lever.
 * RESIDUAL 4 @159/159 = the two OLD classes (a) 3 lines + (b) 1 line, both re-probed w62-a4:
 *   (a) FALSIFIED again in the post-(c) basin: `while (i < nmask)` and `for (i=0;i<nmask;i++)`
 *       both give 4 @161 (the 3 lines move from the back-edge to the entry guard -- ours
 *       `slt $v0,$a2,$t1; beqz` where retail folded `0 < nmask` to `beqz $t1`; note cse hands us
 *       `matched`'s zero register instead of $zero, the 13C constant-capture family), the guarded
 *       do-while is catastrophic again (44 @163), `*map++` fused = 7 @158.  Count-exact 159 is
 *       the better basin, so the `!=` bound stays.
 *   (b) FALSIFIED: `(int)` / `(unsigned int)` / `x - 7 == 0` on the second use are all INERT (4);
 *       `int e8` kills the andi but cse then SHARES the load with the `info[0xe8]==3` arm below
 *       (5 @158, ours 1 short); volatile views to un-share it measure 6/6/10/11/14.
 * MATCH (w63-a7, 4 -> 3 @158/159 -- CLASS (b) IS CLOSED):  `int e8 = info[0xe8];` at the top
 *   of the outer `else` block kills the `andi $v1,$v1,255` remask (PROMOTE_MODE, 11D) exactly as
 *   w61 measured, and the reason it could not be landed then -- cse SHARES that load with the
 *   `info[0xe8] == 3` arm below, leaving us 1 insn short -- is cured by a zero-instruction
 *   OPACITY FENCE on `info` at the head of that arm: laundering the base makes the arm's MEM a
 *   different rtx, so its load is real again.  Measured in this basin: `int e8` alone 5 @158
 *   (w61's number, reproduced), + the fence 3 @158, fence WITHOUT `int e8` 4 @159 (inert), and a
 *   laundered ALIAS pointer `i2` instead of laundering `info` itself 7 @158 (it also costs the
 *   `addu $a0,$s0,$zero` copy).  Note the count: 158 is the HONEST count here -- the old 159 was
 *   the WRONG andi standing in for the missing `slt` of class (a); every instruction we now emit
 *   is an oracle instruction.
 * RESIDUAL 3 @158/159 = class (a) ALONE (the first search loop's back-edge: ours `bne $v1,$t1`,
 *   retail `slt $v0,$v1,$t1; bnez`).  The oracle shape is now read off exactly and it IS the
 *   guarded do-while -- `beqz $t1,<past the loop>` entry guard at 0x800FE144 plus `addiu $v1,1;
 *   slt $v0,$v1,$t1; bnez` at 0x800FE174, i.e. character-for-character the SECOND search loop's
 *   shape, which our source already spells that way and which already matches.  RE-FALSIFIED in
 *   the post-(b) basin (04Z): the same guarded do-while on loop 1 = 43 @162 (with braces, without
 *   braces, and with `*map++` fused -- all three byte-identical), `while (i < nmask)` = 3 @160.
 *   So loop 1 rejects the shape loop 2 accepts; the discriminating difference between them is the
 *   `break` (loop 1 has an early exit, loop 2 does not) -- that is the next named angle: the
 *   guarded-do-while + break combination adds 4 insns and rotates the $a2/$a3 band, so the
 *   question is which pass (jump.c's loop-exit duplication, or the biv's exit-value) reacts to
 *   the break.  Instrumented-cc1 job, not a spelling one.
 * MATCH (w64-a7, 3 -> PASS 159/159 -- CLASS (a) IS CLOSED; the w63 angle was RIGHT and the
 *   answer was ONE token).  The `break` IS the discriminator, and the cure is not a loop shape
 *   at all: keep the guarded do-while loop 2 already uses and spell the early exit as a
 *   `goto` OUT of the loop instead of a `break`.
 *     i = 0;
 *     if (nmask != 0) {
 *         do { if (hit) { matched = 1; goto found; } map++; dat++; i++; } while (i < nmask);
 *     }
 *     found:
 *   MECHANISM: a `break` compiles to a jump to the LOOP'S OWN exit label, i.e. the same label
 *   the do-while's failed bound test falls to -- two edges into one label is exactly the input
 *   jump.c's `duplicate_loop_exit_test` looks for, and it copies the bound test ahead of the
 *   loop (that is the +4 insns and the $a2/$a3 rotation every guarded-do-while probe measured
 *   across w53/w61/w62/w63: 43-61 @162).  A `goto` to a label the loop machinery does not own
 *   leaves the loop with a single exit edge, the duplication never fires, and retail's
 *   `beqz $t1` entry guard + `addiu $v1,1; slt $v0,$v1,$t1; bnez` back-edge come out verbatim.
 *   MEASURED this wave, same basin: control 3 @158 | guard+do-while+GOTO **PASS 159/159** |
 *   guard+`while (1)` with `if (++i >= nmask) break;` as the bottom test **PASS 159/159** (the
 *   same law from the other side -- there the bound test is an ordinary `if`, not the loop's
 *   own exit) | guard+do-while+BREAK 43 @162 | guard+`for(;;)` with a separate bottom
 *   `if (i >= nmask) break;` 43 @162 | the same with `!(i < nmask)` 43 @162 | a void-tail fence
 *   after the old `!=` loop 3 @158 (inert).  Note the two PASSing forms differ only in WHICH
 *   exit is the loop's own, which is the whole content of the law.
 * => the rung is the TU's home; see the wiring note in the report. */
extern void _pad_filter(unsigned char *info)
{
    bzero(info + 0x57, 6);

    if (*(unsigned short *)(info + 0xe6) != 0 && *(int *)(info + 0x28) != 0) {
        int nmask = *(volatile unsigned char *)(info + 0x34) < 7 ? info[0x34] : 6;
        int mode = 0;
        if (info[0xe9] != 0) {
            unsigned char one = 1;
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
                /* MATCH (w64-a7): the early exit is a `goto` OUT of the loop,
                   NOT a `break` -- see the class-(a) note above.  With `break`
                   the exit jump targets the loop's own exit label, so jump.c's
                   duplicate_loop_exit_test copies the bound test ahead of the
                   loop (43 @162); a `goto` to a label the loop machinery does
                   not own leaves the guarded do-while intact and retail's
                   `beqz $t1` guard + `slt $v0,$v1,$t1; bnez` back-edge come out
                   verbatim.  Same shape the SECOND search loop below uses. */
                i = 0;
                if (nmask != 0) {
                    do {
                        if (*map == mode && (mask & *dat) != 0) { matched = 1; goto found; }
                        map++; dat++;
                        i++;
                    } while (i < nmask);
                }
                found:
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
                            if (*m2++ == mode) *flag = one;
                            flag++;
                            k++;
                        } while (k < nmask);
                    }
                }
                row += 5;
                mode++;
            } while (mode < info[0xe9]);
        }
    } else {
        int e8 = info[0xe8];
        if (((unsigned char)(e8 - 4) < 2 || e8 == 7) &&
            (*(unsigned short *)(info + 0xe6) == 0 && info[0x34] > 1)) {
            if ((**(unsigned char **)(info + 0x28) & 0xc0) == 0x40 &&
                ((*(unsigned char **)(info + 0x28))[1] & 1) != 0 &&
                _padTotalCurr + 10 < 0x3d) {
                info[0x58] = 1;
                info[0x57] = 1;
                _padTotalCurr = _padTotalCurr + 10;
            }
        } else {
            /* MATCH (w63-a7): opacity fence on `info` -- with the `int e8`
               local above (which kills the andi remask) cse otherwise SHARES
               that load with this arm's test and we land 1 short; laundering
               the base makes this MEM a different rtx so the load is real.
               Zero instructions.  4 -> 3, and class (b) is gone. */
            __asm__("" : "=r"(info) : "0"(info));
            if (info[0xe8] == 3) {
                info[0x57] = 1;
            } else if (*(unsigned short *)(info + 0xe6) == 0) {
                unsigned char fill = 1;
                int n = 5;
                unsigned char *f = info + 5;
                do {
                    f[0x57] = fill;
                    /* MATCH (w62-a4): 4-operand read-only fence = the PRICED
                     * ref dial that hands `fill` retail's $v0 (see the residual
                     * (c) note above).  ZERO instructions (159/159 either way).
                     * DO NOT trim the operand list -- 3 operands measures 14,
                     * 4 measures 4; the count IS the lever. */
                    __asm__("" : : "r"(fill), "r"(fill), "r"(fill), "r"(fill));
                    f--;
                } while (--n >= 0);
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
 *   (2) the found-arm's block is a single `(set v0,slot)(jump)`, so reorg EAGER-STEALS it into
 *       the beq's delay slot and retargets the beq straight at the shared epilogue = the oracle's
 *       `beq $a0,$v1 / addu $v0,$a2,$zero`.  A bare `return slot;` inside the loop instead emits a
 *       SECOND `jr ra` block (q3 probe: 10 diffs; re-measured w55 at the 2.7.2 basin: 5 @15/14).
 *   (3) increment order slot, i, info -- info LAST so it lands in the bnez delay slot.
 * MATCH (w55-a6, 2 -> PASS 14/14): the copy `r = slot` belongs INSIDE THE FOUND-ARM BLOCK, not
 * before the test.  With `r = slot;` at the top of the loop body the copy sits in the SAME
 * extended basic block as `slot += 0x10`, so cse's make_regs_eqv makes `r`'s register canonical
 * (r outlives slot -- it is read after the loop) and the increment reads it: `addiu $a2,$v0,16`
 * vs the oracle's `addiu $a2,$a2,16` (the last 2 diffs, w48's named residual (b)).  Moving the
 * copy into `if (p == info) { r = slot; goto out; }` confines the equivalence to the ARM path,
 * so the fall-through increment can only read `slot`'s own register -- and the arm block is still
 * the single `(set v0,slot)(jump)` reorg needs for the eager steal, so (2) is preserved.
 * Zero collateral (other 7 PADPORTD fns unchanged).  The old residual (a) (`lui $v0; addiu $v1`
 * vs the self-temp) had already dissolved when the TU moved onto the cc1_alt 2.7.2 rung.
 * FALSIFIED at the 2.7.2 basin (w55-a6): identity fence on `slot` (20), identity fence on `r`
 *   (12 -- it DOES break the cse pick but rotates a1<->a2), fence-on-r + swapped decl order
 *   (2, position-only), split decls with i assigned first (12), `do{i++;}while(0)` depth wrapper
 *   (14), single-variable `slot` as the result with `return slot` (5 @15/14) or with
 *   `goto out; slot=0xff; out: return slot;` (6 @14/14 -- structure exact, but the result lives
 *   in $a2 so both the beq slot and the jr slot come out wrong).
 * FALSIFIED at the earlier w48 basin: for-header/while-header (18/12), `info == p` yoda (12),
 *   `&_pad_info[0]` (12), r-as-block-local (7 @15), break+`r=0xff` default (15 @15),
 *   increment-order permutations x3 (6), decl-order permutations x3 (6). */
extern int _pad_port_to_slot(unsigned char *p)
{
    int i = 0;
    int slot = 0x10;
    int r;
    unsigned char *info = _pad_info;

    do {
        if (p == info) {
            r = slot;
            goto out;
        }
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
