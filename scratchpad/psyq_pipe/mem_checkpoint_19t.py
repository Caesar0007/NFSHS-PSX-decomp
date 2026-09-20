"""Insert CHECKPOINT 2026-09-19t into the NFS4 memory hub (after the 2026-09-19s line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-19t' not in s
i = s.index('- CHECKPOINT 2026-09-19s')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-19t (FE MENU FAMILY = WIP ON A BRANCH): nfs4-decomp `main` = 3145f4c7 (0 diff, 297792/297792, UNPUSHED on "
    "top of pushed 6871d324). Branch `wip/fevirt-tmenu` = b7ac4cea holds the menu-family conversion: links clean (0 undefined, no "
    "DROPPED) but 1577 diff words. To resume: `git checkout wip/fevirt-tmenu`, FULL `python tools/build.py --no-link`, relink. DONE "
    "on the branch: tMenuItem/tMenu roots polymorphic in fe_core_types.h (ProcessInput has a layout-only placeholder signature on "
    "owner surfaces without tInputKeyType/tMenuCommand; Draw(bool) pure only under NFS4_FE_CORE_FEMENU_METHODS), 11 hand vtable files "
    "removed, all family default ctors removed, fevirt_sites.py `auto-menu` mode (per-type ITEM/MENU slot maps from the struct the "
    "compiler names) + hand-converted entry-pointer carriers, extra virtuals marked (tMenuNFS4::DrawItem, tInsideBoxMenu::Draw(sssss), "
    "tMenuItemSlidingMenu::UpdatefOpenHeight, tInsideBoxSongMenu::DrawOneSong), tInsideBoxControllerLeftRightSlider real inheritance, "
    "extern-C dtor devices removed (fevirt_tmenu4.py), `((Base *)this)->Virt()` -> `this->Base::Virt()` (fevirt_basecalls.py; retail "
    "calls the base DIRECTLY), femenudefs uses the real tPlayer enum. femenuextended / femenuoptions / femenudefs now match retail "
    "FUNCTION-FOR-FUNCTION (fndrift.py shows the culprit `<- after fn`; pass the FIRST SYMBOL's retail address as BASE -- gen_ld's "
    "implied spine base can sit inside the previous object's deferred tail). 🔑 LAWS: (1) the DEFERRED-INLINE TAIL = one group per "
    "class in REVERSE class-declaration order; inside a group the in-class inline members in REVERSE declaration order, the "
    "compiler-SYNTHESIZED destructor LAST (femenuextended tail: IsSubMenu__12tMenuOptions, UpdateTransition__10tMenuBlank, ~TwoItem, "
    "~OptionsLR, Draw__27GoToMenuNFS4Buttonb => Draw(bool) is an in-class `{}`; femenudefs tail: TIF32, Draw32iib, Draw32b, ~32, "
    "TIF33, Draw33iib, ~33 => tBlank* are ALL-INLINE classes, declare Draw(b), Draw(iib), TIF in that order); (2) a USER empty dtor "
    "stores its own vptr (+8 B) -- retail's bare `jal ~Base` dtors are SYNTHESIZED; (3) mem-initializers run AFTER the vptr store "
    "(tested); (4) 🔴 FRONT-END LANE HYPOTHESIS: retail FE objects inline members of key-function classes WITHOUT out-of-line copies "
    "(SYM proves an inlined tOptionsMenu accessor in screenusername, femenuoptions.obj has no copy; tBlank* inline ctors, none in "
    "femenudefs.obj) => `-fno-implement-inlines` for the FE (build.py PER_TU_FLAGS lines marked `# FEVIRT-NII-PROBE`, "
    "scratchpad/psyq_pipe/fevirt_nii_probe.py on|off FILES); vtable-referenced inlines and synthesized dtors ARE still emitted under "
    "the flag. If confirmed lane-wide it also retires the feapp `#pragma interface` carrier (the all-inline "
    "tDialogMessageStringWithTimeout gets a local table + its inline dtor naturally). The game-side 'every inline member gets a copy' "
    "law stays true for GAME objects. OPEN on the branch: (a) femenu `tMenuItemLeftRightSlider` ctor -12 B: retail does "
    "`jal ~Interactive ctor; fData = d; fFlags |= 0x80; <vptr store>; fFlags |= 0x80` -- vptr store MID-BODY, no intermediate class tag "
    "in the SYM, mem-init does not do it; (b) fedialog `Run__18tDialogInteractive` -16 B (not yet diffed; probably a menu virtual call "
    "that retail makes direct or vice versa); (c) rodata rows for femenu / femenuextended / femenuoptions / femenudefs must be "
    "extended to take their vtables (end = base + built .rodata size, vtables `.align 3`); (d) then A/B the NII flag on ALL frontend "
    "TUs; (e) tInsideBoxSongMenu ctor uses an inline 6-arg tInsideBoxMenu ctor (copy suppressed only by the flag). Tools added: "
    "fevirt_errs.py [--lines] FILES (error triage across TUs), textsize_check.py, fndrift.py. PITFALL (again): never patch scripts "
    "through a Bash heredoc -- backslashes get mangled; Write tool only.\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
