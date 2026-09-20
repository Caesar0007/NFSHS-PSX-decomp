"""Insert CHECKPOINT 2026-09-20d into the NFS4 memory hub (after the 2026-09-20c line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20d' not in s
i = s.index('- CHECKPOINT 2026-09-20c')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-20d (tScreen + tDialog = WIP ON A BRANCH): `main` = c305985f+checkpoint commit (0 diff, menu family merged). "
    "Branch `wip/fevirt-tscreen` = 00f0e917: the last 22 hand vtable files are deleted there, everything BUILDS and LINKS (1 undefined: "
    "___18tDialogInteractive; feapp/femenuextended/femenudefs/screentournselect/screentrackinfo/screendisplay DROPPED by gen_ld because "
    "neighbours grew) but it is NOT byte-exact. To resume: `git checkout wip/fevirt-tscreen`, FULL build, relink, then walk objects "
    "with fndrift.py OBJ <first symbol's retail VA>. DONE on the branch (scripts scratchpad/psyq_pipe/fevirt_tscreen.py .. 9.py): (1) "
    "root: every owner-surface copy of `struct tScreen` (10 FE headers) includes the member fragment fescreen_virtuals.inc where `_vf` "
    "was -- slot order GetShapeInfo(short&,short&,char**,char**), DrawBackground, DrawForeground, ~tScreen [slot 4!], PreLoad, "
    "Initialize, Cleanup, TransitionIsFinished, ProcessInput; tDialogBase adds [10] CalculateDimensions=0 [11] Draw; tScreenCarSelect "
    "[10..15] DrawVideoWall(short), InitializeVideoWall, UpdateVideoWall(tCarInfo&), GetCar(tCarInfo&), AllocateAsyncBuffer, "
    "FreeAsyncBuffer; TwoPlayer/PinkSlipsCarSelect [16] TurnOffVideoWall [17] SetDialog; Duel [16] DrawOpponentVideoWall(short); "
    "tScreenCongrats [10] CalculatePrizes [11] DrawCongratsMessage (pure only under NFS4_TSCREENCONGRATS_OWNER) [12] GetCar; (2) "
    "fescreen_virtual_types.h gives every surface tPlayer/tInputKeyType/tMenuCommand, so the layout-only placeholder signatures are "
    "gone (menu roots too); (3) the `#define tPlayer int` / `#define tMenuCommand int` owner surfaces (feapp, screencontroller, "
    "screenmain, screentournselect) use the real types (else overrides OVERLOAD -> undefined ProcessInput__7tScreeni...); (4) "
    "fevirt_sites.py `auto-screen` mode + hand conversions of the carriers (`vtbl[1][K]` = slot 10+K); the smuggled vptr stores in "
    "mem-initializers (screencontroller fShaker, front CarDialog) and fememcard's manual `_vf` poke are gone; two hand-TRANSCRIBED "
    "__asm__ destructor blocks (screencontroller, screencarselect, ~7 KB of asm in source) are gone; (5) 🔑 vt_census.py = which "
    "object emits which vtable (R global / r local): a LOCAL copy in a non-owner object means that surface's copy of the class "
    "declares none of its overrides -> fevirt_tscreen9.py HOISTS every retail-proven override declaration (derived from the hand "
    "tables on `main`) to the top of the class on all surfaces; census is now clean except feapp's pragma-carrier helper. OPEN: (a) "
    "fedialog: dialog classes must be declared in retail's order (tables + synthesized-dtor tail = YesNoTri, YesNoMem, YesNo, "
    "Interactive, NoInputMessage, BackUpOnly, MessageString, Help, Base -> declare Base, Help, MessageString, BackUpOnly, "
    "NoInputMessage, Interactive, YesNo, YesNoMem, YesNoTri); retail's tDialogYesNo ctor stores FOUR vptrs in turn (Base 0x800105B0, "
    "MessageString 0x800104F0, Interactive 0x800103D0, YesNo 0x80010370) => tDialogInteractive needs an explicit inline ctor defined "
    "in fedialog.cpp AFTER tDialogMessageString's inline ctor (done), but fedialog then emits an out-of-line copy of "
    "__20tDialogMessageString (key-function class) -> try the NII flag for fedialog; CalculateDimensions__12tDialogYesNo +24 / "
    "Draw__12tDialogYesNo +20 = a base call that must be qualified (`this->tDialogMessageString::Draw()`); tDialogInteractive is "
    "ALL-INLINE (no own virtuals): its table + synthesized dtor are emitted in fedialog.obj because fedialog's derived ctors "
    "reference it; (b) screencarselect_types.h lost `~tScreenCarSelectTwoPlayer() {}` (in-class inline dtor) in a hoist -- RESTORE; "
    "(c) then front, screencarselect, screentracks, screencontroller drifts; rodata rows for every screen/dialog owner (tables now "
    "live in the owners' .rodata; vtables `.align 3`); (d) retire fedialog_timeout_class.h's #pragma carrier + helper base once feapp "
    "emits tDialogMessageStringWithTimeout's local table naturally. PITFALLS: `git add -A` prints a CRLF warning per file -- "
    "redirect (>/dev/null 2>&1); never patch scripts via heredoc; nm over a glob of build/recon overflows the Windows command line "
    "(batch + cwd).\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
