import os

CR = b'\r\n'
P = 'recon/syslib/psx/libmcrd/LIBMCRD.c'


def J(*ls):
    return CR.join(ls) + CR


data = open(P, 'rb').read()
orig = len(data)


def insert_before(anchor, new_text):
    global data
    assert data.count(anchor) == 1, ('anchor count', data.count(anchor), anchor[:60])
    i = data.find(anchor)
    data = data[:i] + new_text + data[i:]


# ---- MemCardCmd_cb : the seal receipt --------------------------------------------------
insert_before(
    b'/* @0x800FAE2C : MemCardAccept command step (probe -> clear -> load). */',
    J(b'/* W61-A3 -- MemCardCmd_cb 17 -> PASS (141/141).  THREE devices, all zero-insn:',
      b' *',
      b' * (1) BLOCK-LOCAL ANCHORS BEAT THE SHARED ONE (17 -> 11 -> 5).  A single function-scope',
      b' *     `pc` referenced from three arms is a GLOBAL allocno, so local_alloc has already',
      b' *     handed each arm`s own qty (the rslt value, the loaded event) $v0 by the time',
      b' *     global.c places `pc` -- it lands in $v1 and every store in the function comes out',
      b' *     mirrored.  Declaring the anchor INSIDE the arm makes it a block-local QTY whose',
      b' *     local_alloc priority (refs/live = 3/3) beats the rslt qty`s (2/4), so it takes $v0',
      b' *     and rslt falls to $v1 -- retail`s handout, exactly.  cdone: -6.  ctail ev==4: -6.',
      b' *     GENERAL RULE: if retail`s per-arm registers are the mirror of ours and the arms',
      b' *     share one pointer variable, SPLIT the variable -- do not dial it.  This is the',
      b' *     cheap answer to the whole "local-alloc QTY handout" class that methodology 4.6',
      b' *     de-prioritised as instrument-blind: qty272.py shows the local table directly, and',
      b' *     scope (not refs) is the lever that moves a pseudo between the two allocators.',
      b' *',
      b' * (2) ARM ORDER (5 -> 4).  Retail branches `beqz` with the ZERO arm as the branch target',
      b' *     and the `li 3` arm as the fall-through, so the source test is `if (cleared != 0)',
      b' *     { rslt = 3; } else { rslt = 0; }`, not the natural `== 0` spelling.',
      b' *',
      b' * (3) HEAD-OF-THREAD BARRIER (4 -> PASS).  With the arms right, reorg still filled the',
      b' *     `beqz` slot from the FALL-THROUGH thread (`li $v1,3`) instead of stealing the',
      b' *     target thread`s `addu $v1,$zero,$zero`: mostly_true_jump (reorg.c) scores an EQ',
      b' *     branch 0 = "unlikely", and fill_eager_delay_slots then tries the fall-through',
      b' *     FIRST.  A zero-insn `__asm__("" : : "i"(0));` as the first statement of the',
      b' *     fall-through arm makes that thread unstealable, so reorg falls through to the',
      b' *     target thread and reproduces retail`s slot -- and the extra `j; nop` block that',
      b' *     our version needed for the zero arm disappears (143 -> 141 insns).',
      b' *     CATALOG CANDIDATE: "reorg took the wrong delay-slot thread" is dialable -- put a',
      b' *     zero-insn barrier at the HEAD of the thread you do not want it to take.',
      b' */'))

# ---- MemCardExist_cb ------------------------------------------------------------------
insert_before(
    b'/* @0x800FABF0 : MemCardExist / MemCardAccept(card-present) probe step. */',
    J(b'/* W61-A3 47 -> 41: the same BLOCK-LOCAL ANCHOR law that sealed MemCardCmd_cb (see its',
      b' * receipt).  The function-scope `pc` was a GLOBAL allocno shared by the ev==4 arm and the',
      b' * iodone tail; giving each arm its own pointer makes both local QTYs and every anchor',
      b' * register now matches retail ($v1).  `pc` itself became dead and was removed (re-gated:',
      b' * still 41, so the unused decl was not load-bearing here).',
      b' * FALSIFIED in the post-split basin (the "return constant materialized BEFORE the store"',
      b' * angle below, re-measured because 12C says receipts are basin-relative):',
      b' *   fenced `long ret = 1;` after the call, before the store ... 41 but +2 insns (116->118)',
      b' *   12D dead-pseudo staging -- reuse the dead `c` as the result carrier ... 52',
      b' * REMAINING 41: (a) the two tails` `addu $a0,$v0,$zero` / `addu $v1,$v0,$zero` copies,',
      b' * i.e. retail materialises the return constant into $v0 BEFORE the store and therefore has',
      b' * to move the call result out of $v0 -- ours stores straight from $v0 and puts the `li` in',
      b' * the `j` slot, 1 insn shorter per tail; (b) a $v0/$v1 swap on the `_mc_exretry` bump and',
      b' * on the common tail`s mask chain, both of which look like the same local-QTY-vs-return-',
      b' * value race as (a).  NAMED ANGLE: the carrier for the return constant must be a BLOCK-LOCAL',
      b' * qty born BEFORE the call result`s qty in the same block -- neither a fence (parks it in a',
      b' * saved reg) nor an existing dead variable (12D) does that here. */'))

# ---- MemCardSync : the class-B named angle ---------------------------------------------
insert_before(
    b'__inline__ long MemCardSync(long mode, int *cmds, int *result)',
    J(b'/* W61-A3 NAMED ANGLE (worth 15 diffs in EACH of MemCardCreateFile / MemCardDeleteFile;',
      b' * mechanism now identified end to end, so this is a receipt, not a floor).',
      b' *',
      b' * SYMPTOM: in both callers retail`s INLINED copy of this body reaches cmd/rslt/done through',
      b' * the CALLER`s anchor register ($s0: `lw $v0,0($s0)`, `lw $v0,4($s0)`, `sw $zero,8($s0)`)',
      b' * and materialises a SEPARATE `lui;addiu` only for the spin address, while ours materialises',
      b' * this fn`s own anchor inside the loop and then rebases it (`addiu $v1,$v1,8`).  Retail also',
      b' * keeps the two DEAD snapshot loads (`lw $v0,0($s0); lw $v0,4($s0)`) that our inlined copy',
      b' * dead-code-eliminates, which is independent evidence that retail`s reads are not plain.',
      b' *',
      b' * WHY THE OBVIOUS FIXES CANNOT WORK (all measured, in the post-rotation basin):',
      b' *   drop this fence entirely ....... MemCardSync 0 -> 3, DeleteFile 34 -> 39, Create -> 73',
      b' *                                    (with a plain base the inlined loads at offsets 4/8',
      b' *                                    constant-fold to `lui;lw` macros -- 2 insns each)',
      b' *   make it non-volatile ........... byte-identical whole-TU (so the flavour is NOT the',
      b' *                                    lever, contrary to what the old note implied)',
      b' *   shared `static __inline__ int *mc_anchor(void)` used by this fn AND the callers, so',
      b' *   every expansion of the fence carries ONE source line ... DeleteFile 48, Create 41.',
      b' *     Rationale (correct, but insufficient): cse.c`s exp_equiv_p compares the generic',
      b' *     `i` fields, and ASM_OPERANDS carries ASM_OPERANDS_SOURCE_LINE as one -- so two',
      b' *     fences on the SAME line ARE cse-equal (this is 12C`s rule, on the cse side).',
      b' *     It still does not merge, because the caller`s anchor is in the loop PREHEADER and',
      b' *     the inlined body is inside the loop: different extended basic blocks, and cse`s',
      b' *     table is reset at an EBB boundary.  loop.c would have to hoist the asm first;',
      b' *     invariant_p (loop.c) does accept a non-volatile ASM_OPERANDS, but scan_loop does',
      b' *     not move it out of this loop (maybe_never is set by the branches above it).',
      b' *',
      b' * SHARPENED ANGLE: get the inlined anchor into the loop PREHEADER (where cse2-after-loop',
      b' * can merge it with the caller`s anchor) -- i.e. a device that is loop-hoistable AND',
      b' * opacity-preserving.  A gcc -dL/-dS dump of MemCardDeleteFile will show exactly why',
      b' * scan_loop declines the asm; that is the next experiment, not another spelling sweep. */'))

assert len(data) > orig
tmp = P + '.tmp'
open(tmp, 'wb').write(data)
os.replace(tmp, P)
print('ok %d -> %d' % (orig, len(data)))
