# W67-A3 RECEIPTS — BYTE-TRUTH EXPLOITATION (LIBMCRD+LIBPAD+LIBMATH+LIBC+LIBCD+LIBAPI)
2026-08-15. Repo @77c09895. Truth source: C:\Temp\nfs4-clean\psyq43\extracted (redirect from
w67a1 SpongeBob lane); tiebreaker: C:\Temp\ps1-decomp-refs\Spongebob_SuperSponge\tools\psyq\lib
(extracted to scratchpad/w67a3/sb_extract, LIBCD/LIBPAD/LIBC/LIBMCRD/LIBMATH/LIBAPI).

## TOOL
scratchpad/w67a3/vcmp.py — parses an SN-LNK member obj (reuses tools_psyq_extract.py parser,
re-walks patches DECODING exprs -> symbol names), pulls retail words from the oracle .s
comments, word-compares masking patch sites. Locate by XDEF/local name, --anchor SYM
(VA arithmetic vs configs/symbol_addrs.txt), or --scan (sliding-window best match).
Verdicts: BYTE-IDENTICAL / RELOC-ONLY (drift=0) / DRIFTED(n).
Full annotated dumps: scratchpad/w67a3/truth/<fn>.txt (V:vendor word, R:retail word,
RELOC tNN <symbol-or-sect+off>).

## BYTE-TRUTH INVENTORY (all 21 targets; gate baselines re-gated by me this session)
| fn | TU | gate | vendor obj | verdict |
|---|---|---|---|---|
| MemCardGetDirentry | libmcrd/LIBMCRD.c | 36 @150/152 | LIBMCRD.obj | RELOC-ONLY |
| MemCardCreateFile | LIBMCRD.c | 12 @130/130 | LIBMCRD.obj | RELOC-ONLY |
| MemCardDeleteFile | LIBMCRD.c | 5 @110/111 | LIBMCRD.obj | RELOC-ONLY |
| _pad_failall | libpad/PADPORTD.c | 17 @60/61 | PADPORTD.obj (anchor PadInitDirect) | RELOC-ONLY |
| _pad_getbyte | PADPORTD.c | 5 @44/47 | PADPORTD.obj | RELOC-ONLY |
| _pad_filter | PADPORTD.c | **PASS (159)** (brief row stale) | — | — |
| _padInitSioMode | PADMAIN.c | 20 @207/205 | PADMAIN.obj | RELOC-ONLY |
| _padLoadActInfo_rcv | PADCMD.c | 14 @155/157 | PADCMD.obj (anchor _padLoadActInfo) | RELOC-ONLY |
| _padInitDirSeq | PADSEQD.c | 3 @14/13 | PADSEQD.obj | RELOC-ONLY |
| _mul_mant_d | libmath/MULDF3.c | 8 @59/59 | MULDF3.obj | RELOC-ONLY |
| __divdf3 | DIVDF3.c | 16 @182/184 | DIVDF3.obj | RELOC-ONLY |
| __adddf3 | ADDDF3.c | 8 @221/221 | ADDDF3.obj | RELOC-ONLY |
| __fixdfsi | FIXDFSI.c | 5 @62/63 | FIXDFSI.obj | RELOC-ONLY |
| sprintf | libc/SPRINTF.c | 44 @545/545 | LIBC SPRINTF.obj | RELOC-ONLY (LIBC2 variant is 544w = NOT retail's) |
| CD_cw | libcd/drv.c | 18 @259/259 | LIBCD BIOS.obj | RELOC-ONLY |
| CD_init (CD_init_80108140) | drv.c | 10 @120/120 | BIOS.obj | RELOC-ONLY |
| CdSearchFile | iso9660.c | 19 @181/182 | ISO9660.obj | RELOC-ONLY |
| _read_int | cdread.c | 15 @158/157 | CDREAD.obj | **DRIFTED(25)** -> SpongeBob CDR_1.obj **RELOC-ONLY** |
| _st_dma | stcdint.c | 25 @107/106 | C_011.obj (anchor StCdInterrupt +0x948) | RELOC-ONLY |
| StCdInterrupt | stcdint.c | 27 @576/583 | C_011.obj | RELOC-ONLY |
| data_ready_callback | streamhelp.c | 9 @34/35 | C_004.obj | RELOC-ONLY |
| firstfile | libapi/FIRST.c | 5 @104/103 | FIRST.obj | RELOC-ONLY |

=> 20/21 of the belt's oracle functions are the PsyQ 4.3 shipping objects verbatim
(gate-parity: matching these bytes == matching the vendor object). The ONLY revision
drift in the whole belt is CDREAD.

## 🏆 CERTIFICATE CLOSURES
1. **_padInitDirSeq AT-MACRO-SPLIT: OBJECT-PROVEN.** PADSEQD.obj words 10/11/12:
   `lui $at,%hi(_padFuncRecvAuto)` [patch t52] / `jr $ra` [no patch] / `sw $v0,%lo(...)($at)`
   [patch t54] — the hi half BEFORE the return, the lo-half store IN the delay slot, as
   SEPARATE hi/lo patches at fixed word positions in the SHIPPING vendor object. The split
   is Sony's real build product, not a disasm/emulation artifact. The w61-a5 POST-maspsx
   mechanism spec ("move the sw into the return's delay slot after maspsx expansion, drop
   the nop" -> 13/13) is now vendor-justified — ORCHESTRATOR: implement it (13E named gap).
   All three slot installs use the same shape: `lui $v0/addiu $v0` la-pair for the handler
   address (.text+0x34 _dirSendAuto, +0x460 _dirCheck, +0x134 _dirRecvAuto = obj-local
   offsets, confirming our static layout), `lui $at/sw %lo($at)` macro for each store.
2. **LIBMCRD 2.8-vs-2.7.2 spill-alignment rung: NOT metadata-settleable.** LIBMCRD.obj is
   debug-stripped (no 0x1C filename record, no locals, no SLD) — no compiler stamp exists
   in the object. The retail 4-aligned spill map (92/96, frame 144) is IN the shipping
   object; the w64-a4 ladder finding stands unchanged (2.8.x packs 4/4 = retail's slots but
   loses the TU; 2.7.2 wins the TU but 8-aligns). The route remains the w64-a4 mechanism
   ask: **a per-fn 4-aligned-spill device on the 272 lane** (turns the settled goto-loop
   LICM lever from -49 into ~-17 on GetDirentry).
3. **sprintf no_split_addresses identity: VENDOR-CORROBORATED.** SPRINTF.obj words 28/29
   (`lui $a1,%hi / addiu $a1,$a1,%lo` self-form la for &D_8012348C = SPRINTF.obj .data+0x970)
   and 357-361 (same self-form into $a3 for .rdata+0x28/+0x14), jtbl read via
   `lui $at + lw %lo($at)` (words 171/173) — the shipping object carries exactly the
   `-mno-split-addresses` + jtbl_at_fusion forms build.py wired at w63-a9. The standing
   wiring is retail-true, not just diff-metric-preferred. Residual 44 = the register-handout
   rows (post-RTL / 06E), unchanged in kind.

## 15F DRIFT RECORD — CDREAD.obj (psyq43) vs retail
_read_int: 25 drift words (dump: truth/_read_int.PSYQ43-DRIFT.txt). Two changes:
(a) driver-struct fields shifted +4 from ~+0x24 (vendor +0x28/+0x2C/+0x30 -> retail
    +0x2C/+0x30/+0x34 = a field inserted mid-struct);
(b) retail ADDS `sw $v0,0x24($s0)` + reshapes the `CdSyncCallback(_read_sync)` tail
    (+1 insn; branch distances shift).
SpongeBob's LIBCD CDR_1.obj (_read_int @+0x34, scan best) = RELOC-ONLY vs retail =>
**NFS4 shipped the SpongeBob-vintage LIBCD CDREAD, one revision past PsyQ 4.3's.**
For any cdread.c question the byte-truth source is sb_extract/LIBCD/CDR_1.obj
(dump: truth/_read_int.SB.txt). Do NOT port shapes from psyq43's CDREAD.
All other belt members: psyq43 == retail (BIOS.obj, ISO9660.obj, C_004, C_011 confirmed
via their target fns).

## RELOC / SYMBOL TRUTH (cross-cutting)
- Patch-type census over all 21 fns: ONLY t52 (%hi), t54 (%lo), t4a (jal/j 26-bit).
  **ZERO gp-rel patch types anywhere in the belt** — 4th independent confirmation of the
  syslib zero-%gp_rel law (w48); no storage-section surprises are hiding in these fns.
- libmath targets carry ONLY t4a (pure code+calls, zero data relocs): every non-jal word
  of __adddf3/__divdf3/__fixdfsi/_mul_mant_d is literal byte-truth already in the oracle.
- **jal-callee name audit (4th-blind-spot class, vendor as third witness): CLEAN.** Every
  external t4a symbol matches splat's name across all 21 fns (the one flagged row,
  CD_cw word 191 `t4a sect61442` bare = .text+0 of BIOS.obj = CD_get_intr, first fn of the
  obj — consistent). Vendor confirms CD_sync/CD_flush/CD_get_intr are BIOS.obj-local fns
  (section-offset calls, no XDEF), matching drv.c's model.
- Section map uniform in all belt objs: 61441=.rdata 61442=.text 61443=.data 61444=.sdata
  61445=.sbss 61446=.bss. Notables: sprintf template D_8012348C = SPRINTF .data+0x970;
  data_ready_callback's D_801489D0/D_801489D4 = C_004 **.bss**+0x100/+0x104 (two separate
  statics, not one struct: retail materializes ONE la anchor for the unaligned swl/swr pair
  at +0x100 but stores +0x104 via the $at macro — corroborates the w55-a5/w64-a6 reading);
  cdread statics D_8013C290/D_8013C298/D_8013C2B0 = CDREAD .data+0/+8/+0x20;
  CD_read_dma_mode + CD_cbread are XREFs (externals) from CDREAD.obj.
- LIBC2's sprintf (544 insns) ≠ retail (545): NFS4 linked LIBC's, not LIBC2's.

## PER-FN RESIDUAL NOTES (vendor-informed, receipts read)
- **_pad_getbyte 5 @44/47**: vendor adds nothing beyond the oracle words (3 relocs, all
  intra-obj j targets). The 18-spelling-deep find_cross_jump depth question stands
  (w64-a7: retail's merge stops one insn early); mechanism/permuter job.
- **data_ready_callback 9 @34/35**: w64-a6 hardness certificate STANDS; vendor corroborates
  the la-anchor + $at-macro asymmetry it describes. Re-open only with a zero-insn
  add-a-live-value device (15A foreign-operand fence was priced: inert — availability loss).
- **MemCardGetDirentry 36**: fully diagnosed at w64-a4; blocked solely on the 4/4-spill
  mechanism (above). Classes (a)+(b) land with it (goto-loop lever settled, do not re-derive).
- Remaining belt fns (CD_cw 18, CD_init 10, CdSearchFile 19, _st_dma 25, StCdInterrupt 27,
  firstfile 5, _pad_failall 17, _padInitSioMode 20, _padLoadActInfo_rcv 14, CreateFile 12,
  DeleteFile 5, libmath 4 fns): truth dumps saved for the next belt pass; no gp-rel or
  call-target surprises to exploit — their residuals are the receipted allocator/scheduler
  classes, now with word-level vendor annotations available per fn.

## ORCHESTRATOR ACTIONS
1. Implement the POST-maspsx AT-MACRO-SPLIT move (w61-a5 spec in PADSEQD.c receipts) —
   now object-proven; seals _padInitDirSeq 3->0 (13/13).
2. Keep SPRINTF wiring as-is (vendor-corroborated identity).
3. The 4-aligned-spill per-fn mechanism (w64-a4 ask) is the single unblocking device for
   the LIBMCRD belt (GetDirentry -17 in one step; also the long-standing 1-diff
   `sw $a3,96/92($sp)` class).
4. CDREAD revision: any future truth-lane work on cdread.c must use
   scratchpad/w67a3/sb_extract/LIBCD/CDR_1.obj (psyq43's is one revision older).

## CATALOG-ROW CANDIDATES
- "A vendor SN-LNK object encodes assembler macro splits at fixed word positions with
  separate hi/lo patches — the object IS the at-macro-split proof; read patch pairs that
  straddle an unpatched branch word" (PADSEQD _padInitDirSeq; closes the w48/w51 class
  evidentially).
- "PsyQ lib revision drift is PER-MEMBER, not per-SDK: psyq43 LIBCD ships one CDREAD
  revision behind NFS4's retail while every sibling member is byte-exact; scan-locate +
  word-compare per member before porting any vendor shape" (CDREAD vs SpongeBob).
- "LIB\x01 member date stamps are not DOS-decodable; treat as opaque ordering tokens"
  (raw stamps recorded in session log).

## HAZARDS
- INDEX.tsv .bin sizes are next-XDEF-bounded: a member's statics inflate the preceding
  export's .bin (PADSEQD 225 "insns" for a 13-word fn); never size a fn from INDEX — use
  the oracle word count.
- --anchor VA arithmetic fails across a revision drift (CDREAD: statics resized); --scan
  is the safe locator (bug found live: anchor placed _read_int at +0x94, scan at +0x0).
- tools_psyq_extract.py asserts on LIB\x02 (SpongeBob LIBSN) when pointed at a whole dir;
  extract per-lib via lib_members().

## FILES
- scratchpad/w67a3/vcmp.py (tool), truth/*.txt (22 dumps), sb_extract/ (6 libs of member
  objs). No recon/ or tools/ files touched; no commits made.
