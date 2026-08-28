/* syslib/psx/libpad/PADSEQD.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libpad.lib(PADSEQD.OBJ): the direct-mode "auto" sequencer -- 5 functions that drive the
 *   per-VSync controller handshake for one port.  _padInitDirSeq installs the three auto-mode
 *   dispatch slots; the SIO engine (PADMAIN) then calls _dirSendAuto to emit the next request,
 *   _dirRecvAuto to absorb the reply (copying it into the caller's PADL buffer at info+0x30), and
 *   _dirFailAuto on a timeout/no-controller; _dirCheck reports whether the command engine is busy.
 *
 *   "info" is the per-port device block, addressed by raw byte offset (field map in PADCMD.cpp).
 *   rx = *(info+0x3c) is the SIO receive buffer; padbuf = *(info+0x30) is the user PADL buffer.
 *   NOTE: _padFuncChkEng takes info in $a0 (Ghidra drops the arg). */

extern void (*_padFuncClrInfo)(unsigned char *info);         /* dispatch slot: reset port state
                                                                  (same symbol PADPORTD.c wires to
                                                                  _pad_reset_state -- must be called
                                                                  indirectly, not as a direct fn) */
extern int  _padCmdParaMode(unsigned char *info, int para);  /* PADCMD */
extern void _padSendAtLoadInfo(unsigned char *info);        /* PADCMD */
extern int  _padRecvAtLoadInfo(unsigned char *info);         /* PADCMD */

/* auto-mode dispatch slots installed by _padInitDirSeq (defined in PAD.OBJ data) */
extern int      (*_padFuncSendAuto)(unsigned char *info);
extern int      (*_padFuncChkEng)(unsigned char *info);
extern unsigned (*_padFuncRecvAuto)(unsigned char *info);

/* forward declarations */
extern int      _dirSendAuto(unsigned char *info);
extern unsigned _dirRecvAuto(unsigned char *info);
extern int      _dirFailAuto(unsigned char *info);
extern int      _dirCheck(unsigned char *info);

/* @0x8010A0B0 : _padInitDirSeq -- wire the auto-mode send/check/recv handlers.
 * MATCH: r = _dirRecvAuto hoisted so its addr is live before jr ra delay slot can consume store. */
/* The residual (3 @14/13) is NOT a scheduling floor -- it is the AT-MACRO-SPLIT class: retail's
 * assembler expanded `sw $v0,_padFuncRecvAuto` ACROSS the `jr $ra` (lui above, the `%lo($at)` half
 * IN the slot); maspsx expands it entirely before the branch and nops the slot.  w51-a5 proved it
 * source-unreachable and LANE-reachable: under `{"cc1_272": True}` (PsyQ 4.0 CC1PSX + direct GNU as
 * in .set-reorder mode) _padInitDirSeq is PASS 13/13.  BUT the rest of PADSEQD is 2.8-basin-tuned,
 * so the lane is a NET LOSS here (whole-TU A/B: base 44 diffs / 1 PASS vs 272 lane 146 / 1 PASS,
 * _dirSendAuto PASS -> 3).  Do NOT wire PADSEQD.c to the lane; re-test once the other four fns
 * are re-matched in the 272 basin.
 * w61-a5 RE-TEST (that condition is now ANSWERED -- and the answer is still NO): with
 * _dirRecvAuto rebuilt on its switch dispatch (34 -> 2), the whole-TU A/B is DEFAULT 12 diffs /
 * 1 PASS vs the 2.7.2 rung 48 diffs / 1 PASS (_padInitDirSeq PASS but _dirSendAuto PASS -> 3,
 * _dirRecvAuto 2 -> 25, _dirCheck 4 -> 13, _dirFailAuto 3 -> 7).  The lane stays off.
 * w61-a5 MECHANISM SPEC (the only remaining route -- orchestrator): the class is POST-maspsx.
 * cc1 emits the macro `sw $2,_padFuncRecvAuto` followed by `j $31` with an EMPTY slot (reorder
 * mode); maspsx expands the macro to `lui $1,%hi; sw $2,%lo($1)` BEFORE the branch and nops the
 * slot, while GNU-as/aspsx in reorder mode split it ACROSS the branch.  PER_FN_TEXT_MOVES runs
 * on the PRE-maspsx .s, so it cannot express this (moving the macro line into the slot would put
 * BOTH halves there).  Needed: a per-fn POST-maspsx rule -- "if the two insns before `jr $ra`
 * are `lui $1,%hi(SYM)` + `sw $r,%lo(SYM)($1)`, move the `sw` into the return's delay slot and
 * drop the nop" -- which reproduces retail's 13 insns exactly.  No source spelling can reach it
 * (the address must stay in the assembler's $at macro form; a pointer local emits la+sw = 3).
 * Falsified in-basin earlier: original order, hoisted r=_dirRecvAuto temp, order swap,
 * r=_dirRecvAuto var.
 * w63-a7 2026-08-15 CERTIFICATE RE-VERIFIED, twice, in the NEW basin (04Z):
 *  (1) residual re-gated 3 @14/13 and the shape is unchanged -- oracle `lui $at,%hi(SYM);
 *      jr $ra; sw $v0,%lo(SYM)($at)` vs ours both macro halves before the branch + nop.
 *  (2) the 2.7.2-rung whole-TU A/B was re-run AFTER _dirCheck (4->1) and _dirFailAuto
 *      (3->PASS) landed, because rung tables are basin-relative: DEFAULT 3/5 PASS / 4 diffs
 *      total vs the 2.7.2 rung 1/5 PASS / 36 diffs (_padInitDirSeq PASS but _dirSendAuto
 *      PASS->3, _dirFailAuto PASS->4, _dirCheck 1->4, _dirRecvAuto PASS->25).  Still a
 *      decisive net loss; the lane stays off.
 *  (3) NEW -- the "PER_FN_TEXT_MOVES cannot express it" claim above was REASONED; it is now
 *      MEASURED, and the measurement is worse than unreachable: slotting the macro line
 *      (`{"take": "\\tsw\\t\\$2,_padFuncRecvAuto\\n", "after": "\\tj\\t\\$31\\n", "slot": 1}`)
 *      gates 2 diffs at COUNT-EXACT 13/13 -- but objdump shows maspsx expanded BOTH halves
 *      after the branch (`jr ra; lui $at; sw $v0,0($at)`), i.e. the store lands PAST the
 *      return and _padFuncRecvAuto is NEVER WRITTEN.  A semantically dead function that the
 *      gate scores 2/13.  Do NOT wire this row; it is a textbook case of the gate being
 *      blind in both directions (w46 hazard).  The POST-maspsx rule spec'd above stays the
 *      only route, and it stays orchestrator-owned.
 * W73 orchestrator 2026-08-22 -- VENDOR-BUILD IDENTITY PROVEN (user-ordered experiment):
 *  (1) the REAL PsyQ 4.3 toolchain (psq43 CC1PSX -O2, and again with -fno-delayed-branch,
 *      -> ASPSX.EXE 2.77 with the vendor driver's exact `-q` invocation, verified via
 *      `CCPSX -v`) produces 13 words with `lui $at / sw / jr` -- ASPSX 2.77 does NOT
 *      split the store macro into the jr slot under ANY flag the driver passes
 *      (scratchpad/W73_pq_flags.py: REAL=1, words 11/12 = the sw/jr order swap).
 *  (2) the SHIPPED PsyQ 4.3 lib member ITSELF (psyq43/extracted/LIBPAD/functions/
 *      _padInitDirSeq.bin w10..w12 = 3c010000/03e00008/ac220000) carries retail's
 *      lui/jr/sw-in-slot shape -- i.e. Sony's own shipped library CANNOT be rebuilt by
 *      the toolchain on the same CD.  The split came from Sony's internal lib build
 *      (an earlier ASPSX rung; note the 272-lane GNU-as in .set-reorder DOES split it,
 *      w51-a5 -- the behavior existed and 2.77 lost it).  => the residual is a
 *      VENDOR-BUILD IDENTITY (same family as sec.3.25-3b / the DMPSX templates), and
 *      PER_FN_POST_MASPSX_MOVES reproduces a vendor artifact no on-hand assembler
 *      emits -- not an emulation of ASPSX 2.77.
 *  (3) 🏆 SEALED same session -- PASS 13/13, TU 5/5 COMPLETE (gated 2x + full build).
 *      The landed mechanism is BETTER than the POST-maspsx move spec: PsyQ 4.0's
 *      CC1PSX emits the required UNSPLIT `la`/`sw` macro form (2.6.x codegen), and
 *      GNU as in .set-reorder mode still splits the trailing sw macro across the
 *      jr natively (byte-proof scratchpad/W73_pq40.s -> objdump == retail w10..12).
 *      Wired as build.py PER_FN_RAW40_SPLICE: compile THIS fn with CC1_PSYQ40,
 *      splice its raw region into the post-maspsx text (whitespace-tolerant
 *      .ent/.end pair -- maspsx strips the leading tab), assemble with the lane's
 *      own GNU as at -G0 (maspsx's forced default; -G4 sends the sw macros
 *      gp-relative).  Gotcha: the 1996 cc1 needs a Windows-style TMPDIR or it
 *      writes cta<pid> at the drive root (the repo's stray cta* litter class).
 *      SCOPE: valid only where the fn's whole 4.0-codegen region matches retail
 *      (trivial fns; w51-a5 proved this one) -- do NOT extend to 2.8-shaped fns
 *      needing only the macro-split (MemCardCreateFile's li $a1,1 row stays in
 *      the w48 class-5 maspsx-as-reorder-option family).
 * A14/w71 2026-08-21 -- RE-ATTACKED FROM SOURCE per the no-floors rule; the identity attribution
 *   STANDS, and here is the move-pair evidence the directive asks for, read off the artifacts
 *   rather than reasoned:
 *   OUR cc1 OUTPUT (`build/recon/syslib/psx/libpad/PADSEQD.c.s`, verbatim tail):
 *       lui  $2,%hi(_dirRecvAuto) # high
 *       addiu $2,$2,%lo(_dirRecvAuto) # low
 *       sw   $2,_padFuncRecvAuto        <-- UNSPLIT assembler MACRO, one line
 *       j    $31
 *       <blank>                         <-- EMPTY slot, no .set noreorder/nomacro wrapper
 *   i.e. cc1 hands the slot to the ASSEMBLER and hands it a MACRO to place; gcc's reorg never
 *   considered the store because a macro cannot go in a delay slot.
 *   RETAIL WORDS (asm/nonmatchings/main/_padInitDirSeq.s, the vendor object per 19A):
 *       8010A0D8  lui $at,%hi(_padFuncRecvAuto)
 *       8010A0DC  jr  $ra
 *       8010A0E0  sw  $v0,%lo(_padFuncRecvAuto)($at)     <-- the macro's SECOND half, in the slot
 *   OURS AFTER maspsx (objdump of the gate object): `lui $at; sw $v0,0($at); jr $ra; nop`.
 *   THE MOVE PAIR is therefore POST-maspsx and one line long: take the expanded
 *   `sw $r,%lo(SYM)($1)` line, place it in the `j $31` delay slot, drop the appended nop; the
 *   `lui $1,%hi(SYM)` stays put.  It is NOT expressible pre-maspsx (the w63-a7 (3) measurement
 *   above is the proof: moving the un-expanded macro line takes BOTH halves past the return and
 *   silently kills the store).  SOURCE ROUTES RE-CHECKED AND ALL CLOSED: the store's address must
 *   remain the assembler's `$at` macro form for the words to match, and every C spelling that
 *   gives gcc a slot-eligible single-insn store first materializes the address into a NAMED
 *   register (`la` = 2 insns + `sw` = 3 words vs retail's 3, but with the wrong register and an
 *   extra word overall) -- so no source form can produce `$at` + a 13-word body.
 *   REQUIRED SHARED CHANGE (report, not made -- tools/ is out of scope for this belt):
 *   PER_FN_POST_MASPSX_MOVES as spec'd by w61-a5, or equivalently the maspsx GNU-as-reorder-fill
 *   option (w48-a6/a10 spec).  Either one lands this function at PASS 13/13.
 * W72-A17 2026-08-22 -- CERTIFICATE RE-VERIFIED ARTIFACT-BY-ARTIFACT (not re-reasoned), and the
 *   class is now BOUNDED FROM THE OTHER SIDE by a `-G` probe that had never been run here:
 *   (1) re-gated 3 @14/13; `build/.../PADSEQD.c.s` still shows the UNSPLIT macro
 *       `sw $2,_padFuncRecvAuto` + `j $31` with an EMPTY slot and no noreorder wrapper, and
 *       `objdump -dr` on the gate object still shows maspsx's `lui $at; sw $v0,0($at); jr $ra;
 *       nop` -- the one-line POST-maspsx move pair is unchanged in every particular.
 *   (2) NEW BOUND: the whole class is the `mips_check_split` SMALL-DATA GATE (mips.c:893 +
 *       ENCODE_SECTION_INFO mips.h:2792 -- see the W72-A17 law block in PADCMD.c).  These three
 *       pointer globals are 4 bytes, so at the lane's default -G4 they are small-data,
 *       SYMBOL_REF_FLAG is set, mips_check_split returns 0 and cc1 emits the UNSPLIT MACRO -- a
 *       macro cannot go in a delay slot, so gcc hands the slot to the assembler (which is why the
 *       fill is an ASSEMBLER question here and not a reorg one).  MEASURED at `g_value: 0`:
 *       cc1 pre-splits, reorg DOES put the `sw` in the `jr $ra` slot, and the function becomes
 *       COUNT-EXACT 13/13 with retail's exact instruction SHAPE -- but scores 12, because the
 *       scratch register is gcc's `$v1` where retail has the assembler's `$at`, on all three
 *       stores.  ($at is FIXED_REGISTERS-reserved; no allocator or source lever can request it.)
 *       g_value 4 and 8 both reproduce the shipped 3 @14.  ⇒ the two basins are: -G4 = right
 *       REGISTERS, one missing slot fill (3 diffs, shipped); -G0 = right SLOT, wrong registers
 *       (12 diffs).  Only the POST-maspsx move gets both, which RAISES the mechanism's priority
 *       rather than lowering it -- and confirms there is no third basin to hunt for. */
extern void _padInitDirSeq(void)
{
    _padFuncSendAuto = _dirSendAuto;
    _padFuncChkEng   = _dirCheck;
    _padFuncRecvAuto = _dirRecvAuto;
}

/* @0x8010A0E4 : _dirSendAuto (_padFuncSendAuto) -- emit the next request for the current state.
 * MATCH (w48-a4, 32 -> PASS 64/64).  Two facts:
 *  (1) the state dispatch is a REAL `switch (st)` over {0, 1, 0xfe, 0xff}.  The oracle's tree is
 *      gcc-2.8 balance_case_nodes on 4 nodes: root `beq $v1,1` + bound test `slti $v1,2` in its
 *      delay slot, left leaf `beqz $v1` (case 0), right pair `beq 0xFE` / `beq 0xFF`, every body
 *      out-of-line, cases 0 and 0xff having NO body (straight to the shared `return 0`).  The
 *      if/else-if cascade inverts three of those branches (32 diffs).  The `default: break;`
 *      label and putting the `!= 0` fn-pointer arm FIRST are both load-bearing (8 diffs without).
 *  (2) the `_padFuncClrInfo` call: retail emits a REDUNDANT `addu $a0,$s0,$zero` copy of `info`
 *      into the jalr's delay slot even though $a0 still holds it; our cc1 copy-propagates the
 *      copy away and leaves `nop` (the methodology 3.25-3b "old-gcc no-copy-prop" identity /
 *      w47 delete_noop_moves law).  The w47 OPACITY FENCE `__asm__("" : "=r"(x) : "0"(x))` is
 *      the zero-instruction modelling device for exactly this: the "0" constraint pins output to
 *      input so NO code is emitted, but cse/copy-prop can no longer prove `info` == the incoming
 *      $a0, so the copy survives.  DO NOT DELETE IT -- removing it costs the match (2 diffs).
 *      A plain local copy (`p = info;`) does not work: it is propagated away (2 diffs). */
extern int _dirSendAuto(unsigned char *info)
{
    unsigned char st;
    /* MATCH (strict target): assigning the shared call argument on BOTH incoming edges
     * keeps the case-0xfe `addu a0,s0,zero` in its predecessor block.  The earlier
     * unconfigured edge can then branch directly to the `jal`, as retail does.  Using
     * `info` directly normalized PASS but targeted the preceding `addu` (one word short). */
    unsigned char *arg;
    unsigned char *rx = *(unsigned char **)(info + 0x3c);

    if (rx[0] == (unsigned char)0xf3) {          /* controller present */
        if (info[0xe8] == 0) {                   /* unconfigured: shares the st==0xfe call site */
            arg = info;
            goto reenter_cfgmode;
        }
        if (info[0x49] == 2) {
            /* MATCH: keeps retail's redundant `addu $a0,$s0,$zero` in the jalr delay slot */
            __asm__("" : "=r"(info) : "0"(info));
            _padFuncClrInfo(info);
        }
    }

    st = info[0x46];
    switch (st) {
    case 1:
        _padCmdParaMode(info, 1);
        return 0;
    case 0:
        return 0;
    case 0xfe:
        arg = info;
    reenter_cfgmode:
        _padCmdParaMode(arg, 0);
        return 0;
    case 0xff:
        return 0;
    default:
        break;
    }
    if (*(void **)(info + 0x14) != 0)
        (*(int (**)(unsigned char *))(info + 0x14))(info);
    else
        _padSendAtLoadInfo(info);
    return 0;
}

/* @0x8010A1E4 : _dirRecvAuto (_padFuncRecvAuto) -- absorb the reply, advance the state machine.
 * MATCH (w61-a5, 34 -> 2 @148/148, count-exact) -- three edits, all read off the oracle:
 *  (1) THE STATE DISPATCH IS A REAL `switch (st)` OVER {0, 1, 0xfe}, EXACTLY LIKE THE SIBLING
 *      _dirSendAuto (and _pad_getbyte).  The oracle's tree is gcc-2.8's balance_case_nodes:
 *      root `beq $v1,$a0(=1)` with the bound test `slti $v0,$v1,2` in its DELAY SLOT, then
 *      `beqz $v1` for case 0 and `beq $v1,$v0(=0xFE)` for case 0xfe, EVERY body out of line and
 *      `default` falling through to the fn-ptr tail.  The old `if (st == 1) {...} if (st < 2)
 *      { if (st == 0) {...} } else if (st == 0xfe) {...}` cascade INLINES the st==1 arm as the
 *      fall-through (`bne` instead of `beq`) and lets cse fold that arm's `info[0x46]` reload
 *      into `st + 1` (`addu $v0,$v1,$zero; addu $v0,$v0,$a0`), which retail re-reads.
 *      🔑 CASE ORDER IS LOAD-BEARING: `case 0:` must be written FIRST (retail lays the st==0
 *      block ahead of the st==1 block and cross-jumps their shared `addiu ,1; sb` tail);
 *      case-1-first measures 18, case-0-first 14.  34 -> 14.
 *  (2) THE FN-PTR TAIL ARM ORDER: `if (p != 0) r = (*p)(info); else r = _padRecvAtLoadInfo(info);`
 *      -- retail's fall-through is the INDIRECT call (`beqz $v0` skips to the `jal`), so the
 *      non-NULL arm is the if-BODY.  14 -> 8.
 *  (3) `prev_e8` IS AN `int`, NOT A `char`: with a narrow local, the `(unsigned char)` compare
 *      operand emits `andi $v0,$s1,255` and swaps the compare's operand order
 *      (`lbu $v1,232; beq $v1,$v0` vs retail `lbu $v0,232; beq $v0,$s1`).  As an `int` the
 *      saved-reg copy is already the zero-extended byte from its own `lbu` and the mask
 *      disappears -- PROMOTE_MODE family (11D).  Measured alternatives: `unsigned char` (14
 *      then 8, inert), `unsigned` (2, equivalent), Yoda operand order (8 / 4).  8 -> 2.
 * RESIDUAL 2: ours stages the `info[0x36] == 0` path's return value with
 * `addu $v0,$zero,$zero` in that `beqz`'s DELAY SLOT where retail leaves `nop` -- retail simply
 * RETURNS THE TESTED REGISTER (on the taken edge `$v0` is already 0, cse's record_jump_equiv).
 * FALSIFIED: routing the test through the return variable (`r = info[0x36]; if (r == 0) return r;`
 * and the `(r = info[0x36]) == 0` embedded-assignment form) -- both still stage a fresh zero (2);
 * a void-tail fence at the return block's head to block reorg's steal makes it WORSE (4 @150);
 * the same fence after the guard is inert (2).  ANGLE: this is the "reuse the tested reg as the
 * return value" class (catalog F) -- a cse/jump-equiv property, not a spelling. */
extern unsigned _dirRecvAuto(unsigned char *info)
{
    int            prev_e8 = info[0xe8];
    unsigned char  mode    = (*(unsigned char **)(info + 0x3c))[0] >> 4;
    int            st;   /* MATCH: signed -- the oracle's bound test is `slti ,2`, not sltiu */
    unsigned       r;

    /* MATCH (w51-a5): the rx (+0x3c) and padbuf (+0x30) pointers are RE-READ AT EVERY USE --
     * the oracle reloads BOTH inside the copy loop, once per iteration (the `sb` into padbuf
     * may-alias the pointer fields, so cse cannot keep them).  Caching them in locals was the
     * 9-instruction shortfall. */
    info[0xe8] = mode;
    if (mode == 0xf) {
        info[0xe8] = (unsigned char)prev_e8;     /* no controller: keep last type */
    } else {
        int i;
        (*(unsigned char **)(info + 0x30))[0] = 0;
        (*(unsigned char **)(info + 0x30))[1] = (*(unsigned char **)(info + 0x3c))[0];
        for (i = 2; i < (int)info[0x44]; i++)
            (*(unsigned char **)(info + 0x30))[i] = (*(unsigned char **)(info + 0x3c))[i];
    }

    if (((*(unsigned char **)(info + 0x3c))[1] == 0 &&
         ((info[0x46] != 1 || *(int *)(info + 0x14) != 0) && info[0x50] == 0)) ||
        (_dirCheck(info) == 0 && info[0x37] == 0 && info[0x4a] == 0 &&
         info[0xe8] != prev_e8)) {
        _padFuncClrInfo(info);
    }
    info[0x4a] = 0;

    if (info[0x46] == 0xff)
        return 0xff;
    if ((unsigned char)(info[0x46] - 2) < 0xfc &&
        (*(unsigned char **)(info + 0x3c))[0] != (unsigned char)0xf3)
        _padFuncClrInfo(info);
    if (info[0x46] != 0 && info[0x36] == 0)
        return info[0x36];   /* MATCH (w62-a4): RETURN THE TESTED BYTE, not a literal 0 -- see
                              * the header note.  cse's record_jump_equiv knows the compared
                              * register holds 0 on this edge, so the value costs NOTHING and
                              * retail's `nop` delay slot is restored.  `return 0;` made reorg
                              * eager-steal an `addu $v0,$zero,$zero` into that slot. */

    st = info[0x46];
    switch (st) {
    case 0:
        info[0x49] = 1;
        r = info[0x46] + 1;                      /* MATCH: the oracle RE-READS +0x46 for the bump
                                                  * (`lbu; addiu ,1; sb`) in both arms, sharing one
                                                  * increment block -- not `st + 1` */
        info[0x46] = (unsigned char)r;
        return r;
    case 1:
        info[0x47] = 0;
        r = info[0x46] + 1;
        info[0x46] = (unsigned char)r;
        return r;
    case 0xfe:
        r = 0xff;
        info[0x46] = (unsigned char)r;
        return r;
    default:
        break;
    }
    if (*(void **)(info + 0x18) != 0)
        r = (*(unsigned (**)(unsigned char *))(info + 0x18))(info);
    else
        r = _padRecvAtLoadInfo(info);
    info[0x46] = info[0x46] + (unsigned char)r;
    return r;
}

/* @0x8010A434 : _dirFailAuto -- a poll produced no usable reply; retry or give up.
 * MATCH (w48-a4, 65 -> 3 diffs @56/55).  Four structural facts read off the oracle:
 *  (1) ARM ORDER / POLARITY: `beqz $v1,.L8010A4CC` sends st==0 to the reset block, which sits
 *      OUT-OF-LINE at the END; the retry arms are the fall-through.  The old `if (st == 0)`-first
 *      shape inlined the reset block and inverted three branches.
 *  (2) `rx` IS READ AT ITS USE SITE, not at the top: the oracle loads `lw $v0,0x3C($s0)` inside
 *      the reset block.  Hoisting it to a function-scope local made it live across the
 *      _padFuncClrInfo call -> an extra callee-saved register and a 0x20 frame (retail: 0x18).
 *  (3) `cnt = info[0x4a]` is loaded SEPARATELY IN EACH ARM (two `lbu $v1,0x4A($s0)` in the
 *      oracle); one shared load before the if costs the match.  The two `sb $v0,0x4A($s0)`
 *      + `j` tails then cross-jump-merge on their own = the oracle's shared .L8010A4A0.
 *  (4) the padbuf stores RE-READ `*(info+0x30)` for the second store (the first `sb` may-alias
 *      the pointer field), and the SECOND load's value is the return value.
 * RESIDUAL 3 @56/55: in the st==1/cnt>1 arm retail materializes the two constants sequentially
 * in ONE register (`li $v0,2; sb 0x49; li $v0,255; j; sb $v0,0x46` -- 255 doubles as the return
 * value), while ours keeps 255 live across the 0x49 store and pays `addu $v1,$v0,$zero`.  The
 * zero-insn use fence below already fixes the ORDER (7 -> 3); the surviving copy is the
 * delete_noop_moves/coalescing direction.  Falsified here: SHARED-CONSTANT-RETURN hoist
 * (`r = 0xff; info[0x46] = r; return r;`) 16 without the fence / 12 with it; `unsigned char v`
 * carrier 7; store-order swap 7; volatile 0x49 store 7; a second fence after the 0x46 store 5;
 * `return (unsigned char)0xff` and a trailing `r = 0xff; return r;` both 3 (identical).
 * w55-a6 (cc1 `.s` READ, mechanism now exact): the copy is emitted by CC1 ITSELF, not by maspsx
 * or reorg -- the raw `.s` carries `li $2,255 / move $3,$2 / .set noreorder / j $L53 / sb $3,70($16)`.
 * So the store's pseudo and the shared-return-block pseudo are two DISTINCT pseudos that
 * local_alloc homed in $3 and $2; delete_noop_moves cannot merge them.  Retail has ONE pseudo in
 * $2 serving both.  Further falsified at this basin: block-local `int ff = 0xff;` carrier (5 --
 * copy direction merely reverses), `return (info[0x46] = 0xff);` assignment-as-expression (3,
 * identical output), ONE mutated carrier for BOTH constants `int v = 2; ... v = 0xff;` (9 -- the
 * merged pseudo takes $v1 and the whole arm rotates).  The reachable angle is the store pseudo
 * winning $2, i.e. a local-alloc qty question, not a spelling one.
 * w61-a5: the 12D "assign into the EXISTING variable that owns the register" reading was tested
 * too -- routing BOTH constants through the fn's own return variable `r` (`r = 2; info[0x49] =
 * r; r = 0xff; info[0x46] = r; return r;`) measures 16 with the info fence and 16 without, and
 * carrying only the 255 through `r` measures 12 (all @57/55).  The 3-diff copy stands.
 * w62-a4 tried the STORE-THEN-READ-BACK route (the w43 lever: cc1 forwards a just-stored value,
 * so `info[0x46] = 0xff; return info[0x46];` should give ONE pseudo serving store and return):
 * with the fence 3 @56 (byte-identical to the landed form -- cse forwards the value but keeps the
 * two pseudos), `(unsigned char)`-cast read-back 3, WITHOUT the info fence 7, with a SECOND fence
 * between the store and the read-back 5.  The copy is minted by cc1's own expander before any of
 * these see it; the reachable angle stays "the store pseudo must win $2" (a local-alloc qty
 * question).  NOTE the sibling seal: _dirRecvAuto's 2-diff residual WAS this shape's cousin and
 * fell to `return <the tested lvalue>` (cse record_jump_equiv) -- that lever needs a COMPARISON
 * to carry the value, which this arm does not have.
 *
 * w63-a7 2026-08-15 -- SEALED, 3 -> PASS 55/55.  Every wave above had the MECHANISM right
 * (two distinct pseudos where retail has one, minted by cc1's own expander) and the CURE
 * one step away: the SHARED-CONSTANT-RETURN carrier is necessary but NOT sufficient -- on
 * its own cse copy-propagates the carrier straight back into the two mode-specific pseudos
 * (measured control `r = 0xff; info[0x46] = (unsigned char)r; return r;` = 16 @57).  Adding
 * the zero-insn IDENTITY LAUNDER on the carrier between its init and its two consumers
 * (13B: the pseudo now dies TWICE, so local-alloc's combine_regs refuses to tie it and cse
 * can no longer prove it equal to the literal) makes the ONE carrier serve both the `sb`
 * and the return, exactly like retail: `li $v0,255 / j / sb $v0,0x46($s0)`.
 *   The old `__asm__("" : : "r"(info))` USE fence is RETIRED by this -- it was buying the
 *   store ORDER (7 -> 3) that the carrier now gets for free; dropping it is PASS either way
 *   (with it 55/55 PASS, without it 55/55 PASS), so the function keeps only the one device.
 *   Unlaundered control gated per 13B: 16 @57.  Falsified alongside: launder placed AFTER
 *   the store (3, the copy is already minted), a READ-ONLY fence instead of the identity
 *   fence (12 @57 -- wrong direction, 12E), an `unsigned char` laundered carrier (5),
 *   `return (info[0x46] = 0xff);` embedded assignment with (3) and without (7) the info
 *   fence.  LAW (catalog candidate): when the residual is an EXTRA reg-reg copy that
 *   delete_noop_moves will not remove, the cure is not another spelling of the value -- it
 *   is to make the SOURCE pseudo un-provable to cse, i.e. the identity launder; the 13B
 *   "the copy IS the mechanism" rule reads in this direction too. */
extern int _dirFailAuto(unsigned char *info)
{
    unsigned char st;
    unsigned cnt;
    int r;
    unsigned char *padbuf;

    *(int *)(info + 0x4c) = *(int *)(info + 0x4c) + 1;

    st = info[0x46];
    if (st != 0) {
        if (st == 1) {
            cnt = info[0x4a];
            if (1 < cnt) {
                info[0x49] = 2;
                r = 0xff;
                /* identity launder: keeps ONE pseudo serving the sb AND the
                   return (13B) -- unlaundered this is 16 diffs, see the note */
                __asm__("" : "=r"(r) : "0"(r));
                info[0x46] = r;
                return r;
            }
            r = cnt + 1;
            info[0x4a] = (unsigned char)r;
            return r;
        }
        cnt = info[0x4a];
        if (cnt < 4) {
            r = cnt + 1;
            info[0x4a] = (unsigned char)r;
            return r;
        }
        if (info[0x49] != 0)
            _padFuncClrInfo(info);
    }
    if ((*(unsigned char **)(info + 0x3c))[0] == (unsigned char)0xf3)
        return 0xf3;
    (*(unsigned char **)(info + 0x30))[0] = 0xff;
    padbuf = *(unsigned char **)(info + 0x30);
    padbuf[1] = 0;
    info[0xe8] = 0;
    return (int)padbuf;
}

/* @0x8010A510 : _dirCheck (_padFuncChkEng) -- 1 = engine free/idle, 0 = mid actuator-load command.
 * MATCH: lhu (unsigned short) for the modeword field; lh (signed) generates wrong instruction.
 * MATCH (w48-a4): the "5-diff scheduling floor" note below was WRONG -- it was a STRUCTURE miss.
 *   The old `if (A || B) return 1; return 0;` shape emits TWO `jr ra` blocks (12 insns); the oracle
 *   has ONE shared epilogue reached from both arms, i.e. the source is the De-Morgan EARLY-OUT
 *   `if (!A && !B) return 0; return 1;` (11/11 count-exact, 6 diffs).  MATCH: `int ff = 0xff;`
 *   (catalog NAMED-ONE) then moves the byte load onto the oracle's $v1 (6 -> 4).
 * RESIDUAL 4 (2 lines): ours `li a1,255 / beq v1,a1` vs oracle `li v0,255 / beq v1,v0`.
 *   NOT a priority dial -- `-dg` shows the constant's allocno literally `81 conflicts: 80 81 2 3 29`,
 *   i.e. a HARD-REG conflict with $v0(2) that no ref/live dial can move (reqdelta class:
 *   conflict-set, w46 "a hard-reg conflict beats every allocno dial").  Falsified at this basin:
 *   yoda-compare (6), nested-if block scope (6), (int) cast (6), byte-local (12), decl-after-guard
 *   (12), word/const SHARED pseudo -- in-place reuse, all 3 spellings put the merged pseudo in $a1
 *   (8), opacity fence on ff (5 @12 insns), fence in the nested-reuse form (8), pre-loaded byte
 *   local (8 @9 insns).  NEXT ANGLE: find what puts hard $v0 in the constant's conflict set
 *   (global.c record_conflicts around the two return-value sets) -- retail's constant IS $v0.
 *   w53-a8 added 8 more falsifications at this basin (all 4 or worse, none reaches the conflict
 *   set): result-funnel `int r = 1; if (...) r = 0; return r;` (11 @10 insns), `return !(A && B)`
 *   (13 @12), inner-arm early-return nest (12 @11), `unsigned ff` (4), a 4th block qty `int busy
 *   = 0; return busy;` (4 -- the w46 3-QTY-boundary dial does NOT fire here), a named `mw` word
 *   temp (4), a use fence on ff inside the guard (4), bare literal instead of `ff` (6).
 * w61-a5 added 3 more falsifications of the 12D DEAD-PSEUDO-STAGING angle (retail's 0xFF lives
 * in $v0 = the register the just-tested `mw` halfword owns, so the law says "assign into the
 * EXISTING variable"): reusing that variable as the constant carrier in the nested form (8), in
 * the De-Morgan flat form (12), and via a comma-expression inside the `&&` (8).  All three
 * rotate the whole fn; the hard-reg conflict receipt above stands.
 * w62-a4 re-swept the BIRTH-POSITION axis (the conflict set says the constant is born too early:
 * `int ff = 0xff;` at fn scope is live across BOTH the `lhu` (=$v0) and the `lbu` (=$v1), which is
 * exactly why it can have neither).  Every form that births it after the guard measures 6 @11,
 * byte-identical: bare literal in the `&&`; nested `if (mw != 0) { int ff = 0xff; ... }`; nested
 * with a bare literal; `(unsigned char)0xff`; the goto/early-out spelling; `int ff;` assigned
 * inside the guard body; and a named `mw` halfword temp + bare literal.  In ALL of them the
 * constant lands $v1 and the byte load is pushed to $a0 -- i.e. block 1 never offers $v0 at all,
 * so the target register is barred by something outside the constant's own birth position
 * (candidate: the return-value pseudo's hard-reg range).  The landed `int ff` form is still the
 * best (it at least buys retail's $v1 byte load).  Open, quantified, not a floor.
 *
 * w63-a7 2026-08-15 -- 4 -> 1 diff.  THE CONSTANT'S REGISTER IS SOLVED; the residual is a
 * different, named mechanism.  The w62 conflict-set receipt was right about WHY the flat
 * `int ff = 0xff;` form can never reach $v0 (born before the `lhu`, so it conflicts with the
 * lhu's block-local qty which local_alloc homes in $v0) -- what it missed is that retail's
 * 0xFF and retail's returned 0 ARE THE SAME PSEUDO.  Spelling ONE variable that (a) is born
 * INSIDE the guard, after the lhu dies, (b) carries the compare constant, and (c) is then
 * zeroed and RETURNED gives that pseudo a $v0 copy-preference from the (set (reg 2) (reg r))
 * return copy (13A SET_PREFERENCE LAW), and it spans two blocks, so global_alloc -- not
 * local_alloc -- assigns it.  Result: every instruction of the oracle is reproduced,
 * including `li $v0,255` in the beqz slot and `addu $v0,$zero,$zero` in the beq slot.
 *   RESIDUAL 1 (12 insns vs 11): OUR reorg pass converts the `return 1` fall-through into
 *   its OWN return insn and steals `li $2,1` into its delay slot (make_return_insns,
 *   reorg.c:4289), where retail lets that block FALL THROUGH into the shared `jr ra`.
 *   cc1 .s evidence (this is the whole difference, nothing else):
 *       ours    $L56: [noreorder/nomacro] j $31 ; li $2,1 [macro/reorder]   $L59: j $31
 *       retail  $L56: li $2,1                                              $L59: j $31 ; nop
 *   It is a pure post-cc1 text edit (delete the duplicated `j $31`, leave the `li` in place)
 *   => PER_FN_TEXT_MOVES.  ** SPEC WRITTEN AND PROVEN: scratchpad/w63a7/
 *   SPEC_text_moves_dirCheck.json -- with the row this fn is PASS 11/11, the TU goes 3/5 -> 4/5
 *   with ZERO PASS->FAIL, run twice; and the spliced OBJECT was objdump-verified to be retail's
 *   exact 11 words with both branch targets landing on the oracle's labels (the _padInitDirSeq
 *   lesson: a count-exact splice can be a dead-code bug the gate cannot see). **  NOT
 *   source-reachable:
 *   every single-exit / goto-shared-exit / exit-block-device spelling of this shape rotates
 *   the whole function instead (B1 goto-shared-exit 14 @13, B2 else-arm single exit 14 @13,
 *   C3 `if (0) { out: }` exit-block device 14 @13, C1 early-out chain 5 @14, C5 nested
 *   early-out 5 @14), and a void-tail fence before the `return 1` is diff-NEUTRAL (the
 *   backward scan reaches the `li` before it ever sees the fence).  Other measurements at
 *   this basin: A carrier born at fn scope 7 @12 (the w62 conflict is back), C carrier +
 *   De-Morgan early-out 11 @12, D returns-only-via-var 13 @10, E carrier single-exit 14 @13,
 *   E2/E3 modeword-as-carrier 8 @11 (the carrier follows the lhu into $a1), E5 nested with a
 *   LITERAL 0 return 6 @11 (single-block => local qty => $v1, the w62 class), E4 dead
 *   `else ff = 0;` 1 @12 (same basin as the landed form, but with a dead store).
 * w78-root: a `do { ... break; } while (0)` shared-return funnel is count-exact but rotates the
 *   result/byte pair (14 @11); splitting the compare constant into block-local `ff` lets GCC
 *   booleanize the result (11 @10), and an opacity fence prevents the fold but still rotates the
 *   pair (12 @11).  A statement-expression return with a post-constant read fence prevents delay-
 *   slot folding but moves the one-carrier to $a1 and grows to 13 insns (10 diffs).  All were
 *   reverted.
 * w79-root: source-only PASS 11/11.  The shipped Silent Hill and Parasite Eve 2 PADSEQD objects
 *   contain the same 11-word helper, confirming the Sony single-result funnel.  Spell the two
 *   outcomes as one `r`, then launder that merged value once at the shared exit.  The tied empty
 *   identity prevents GCC 2.8 from booleanizing or splitting the arms into two returns, while
 *   remaining schedulable: the equal branch receives `r = 0` in its delay slot, the other arm
 *   falls through to `r = 1`, and both reach the single retail `jr $ra`. */
extern int _dirCheck(unsigned char *info)
{
    int r;

    if ((*(unsigned short *)(info + 0xe6) == 0) ||
        (info[0x46] != 0xff)) {
        r = 1;
    } else {
        r = 0;
    }
    __asm__("" : "=r"(r) : "0"(r));
    return r;
}
