.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MPause_StartPauseMenu__Fv, 0x230

glabel MPause_StartPauseMenu__Fv
    /* 8F480 8009EC80 1C0D848F */  lw         $a0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F484 8009EC84 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8F488 8009EC88 1400BFAF */  sw         $ra, 0x14($sp)
    /* 8F48C 8009EC8C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8F490 8009EC90 60008424 */  addiu      $a0, $a0, 0x60
    /* 8F494 8009EC94 5000828C */  lw         $v0, 0x50($a0)
    /* 8F498 8009EC98 741884AF */  sw         $a0, %gp_rel(D_8013DDC0)($gp)
    /* 8F49C 8009EC9C 10004384 */  lh         $v1, 0x10($v0)
    /* 8F4A0 8009ECA0 1400428C */  lw         $v0, 0x14($v0)
    /* 8F4A4 8009ECA4 00000000 */  nop
    /* 8F4A8 8009ECA8 09F84000 */  jalr       $v0
    /* 8F4AC 8009ECAC 21208300 */   addu      $a0, $a0, $v1
    /* 8F4B0 8009ECB0 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 8F4B4 8009ECB4 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 8F4B8 8009ECB8 06000224 */  addiu      $v0, $zero, 0x6
    /* 8F4BC 8009ECBC 701880AF */  sw         $zero, %gp_rel(D_8013DDBC)($gp)
    /* 8F4C0 8009ECC0 0E006210 */  beq        $v1, $v0, .L8009ECFC
    /* 8F4C4 8009ECC4 02000224 */   addiu     $v0, $zero, 0x2
    /* 8F4C8 8009ECC8 0C006210 */  beq        $v1, $v0, .L8009ECFC
    /* 8F4CC 8009ECCC 00000000 */   nop
    /* 8F4D0 8009ECD0 1C0D908F */  lw         $s0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F4D4 8009ECD4 AFA1020C */  jal        IsDisabled__10tPMenuItem
    /* 8F4D8 8009ECD8 1C000426 */   addiu     $a0, $s0, 0x1C
    /* 8F4DC 8009ECDC 11004010 */  beqz       $v0, .L8009ED24
    /* 8F4E0 8009ECE0 01000224 */   addiu     $v0, $zero, 0x1
    /* 8F4E4 8009ECE4 1480013C */  lui        $at, %hi(ChangedEnabling)
    /* 8F4E8 8009ECE8 ECD222AC */  sw         $v0, %lo(ChangedEnabling)($at)
    /* 8F4EC 8009ECEC 1C00028E */  lw         $v0, 0x1C($s0)
    /* 8F4F0 8009ECF0 FEFF0324 */  addiu      $v1, $zero, -0x2
    /* 8F4F4 8009ECF4 487B0208 */  j          .L8009ED20
    /* 8F4F8 8009ECF8 24104300 */   and       $v0, $v0, $v1
  .L8009ECFC:
    /* 8F4FC 8009ECFC 1C0D908F */  lw         $s0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F500 8009ED00 AAA1020C */  jal        IsEnabled__10tPMenuItem
    /* 8F504 8009ED04 1C000426 */   addiu     $a0, $s0, 0x1C
    /* 8F508 8009ED08 06004010 */  beqz       $v0, .L8009ED24
    /* 8F50C 8009ED0C 01000324 */   addiu     $v1, $zero, 0x1
    /* 8F510 8009ED10 1C00028E */  lw         $v0, 0x1C($s0)
    /* 8F514 8009ED14 1480013C */  lui        $at, %hi(ChangedEnabling)
    /* 8F518 8009ED18 ECD223AC */  sw         $v1, %lo(ChangedEnabling)($at)
    /* 8F51C 8009ED1C 25104300 */  or         $v0, $v0, $v1
  .L8009ED20:
    /* 8F520 8009ED20 1C0002AE */  sw         $v0, 0x1C($s0)
  .L8009ED24:
    /* 8F524 8009ED24 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 8F528 8009ED28 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 8F52C 8009ED2C 06000224 */  addiu      $v0, $zero, 0x6
    /* 8F530 8009ED30 16006214 */  bne        $v1, $v0, .L8009ED8C
    /* 8F534 8009ED34 00000000 */   nop
    /* 8F538 8009ED38 1C0D908F */  lw         $s0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F53C 8009ED3C AFA1020C */  jal        IsDisabled__10tPMenuItem
    /* 8F540 8009ED40 50000426 */   addiu     $a0, $s0, 0x50
    /* 8F544 8009ED44 07004010 */  beqz       $v0, .L8009ED64
    /* 8F548 8009ED48 01000224 */   addiu     $v0, $zero, 0x1
    /* 8F54C 8009ED4C 1480013C */  lui        $at, %hi(ChangedEnabling)
    /* 8F550 8009ED50 ECD222AC */  sw         $v0, %lo(ChangedEnabling)($at)
    /* 8F554 8009ED54 5000028E */  lw         $v0, 0x50($s0)
    /* 8F558 8009ED58 FEFF0324 */  addiu      $v1, $zero, -0x2
    /* 8F55C 8009ED5C 24104300 */  and        $v0, $v0, $v1
    /* 8F560 8009ED60 500002AE */  sw         $v0, 0x50($s0)
  .L8009ED64:
    /* 8F564 8009ED64 1C0D908F */  lw         $s0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F568 8009ED68 AAA1020C */  jal        IsEnabled__10tPMenuItem
    /* 8F56C 8009ED6C 40000426 */   addiu     $a0, $s0, 0x40
    /* 8F570 8009ED70 1B004010 */  beqz       $v0, .L8009EDE0
    /* 8F574 8009ED74 01000324 */   addiu     $v1, $zero, 0x1
    /* 8F578 8009ED78 4000028E */  lw         $v0, 0x40($s0)
    /* 8F57C 8009ED7C 1480013C */  lui        $at, %hi(ChangedEnabling)
    /* 8F580 8009ED80 ECD223AC */  sw         $v1, %lo(ChangedEnabling)($at)
    /* 8F584 8009ED84 777B0208 */  j          .L8009EDDC
    /* 8F588 8009ED88 25104300 */   or        $v0, $v0, $v1
  .L8009ED8C:
    /* 8F58C 8009ED8C 1C0D908F */  lw         $s0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F590 8009ED90 AAA1020C */  jal        IsEnabled__10tPMenuItem
    /* 8F594 8009ED94 50000426 */   addiu     $a0, $s0, 0x50
    /* 8F598 8009ED98 06004010 */  beqz       $v0, .L8009EDB4
    /* 8F59C 8009ED9C 01000324 */   addiu     $v1, $zero, 0x1
    /* 8F5A0 8009EDA0 5000028E */  lw         $v0, 0x50($s0)
    /* 8F5A4 8009EDA4 1480013C */  lui        $at, %hi(ChangedEnabling)
    /* 8F5A8 8009EDA8 ECD223AC */  sw         $v1, %lo(ChangedEnabling)($at)
    /* 8F5AC 8009EDAC 25104300 */  or         $v0, $v0, $v1
    /* 8F5B0 8009EDB0 500002AE */  sw         $v0, 0x50($s0)
  .L8009EDB4:
    /* 8F5B4 8009EDB4 1C0D908F */  lw         $s0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F5B8 8009EDB8 AFA1020C */  jal        IsDisabled__10tPMenuItem
    /* 8F5BC 8009EDBC 40000426 */   addiu     $a0, $s0, 0x40
    /* 8F5C0 8009EDC0 07004010 */  beqz       $v0, .L8009EDE0
    /* 8F5C4 8009EDC4 01000224 */   addiu     $v0, $zero, 0x1
    /* 8F5C8 8009EDC8 1480013C */  lui        $at, %hi(ChangedEnabling)
    /* 8F5CC 8009EDCC ECD222AC */  sw         $v0, %lo(ChangedEnabling)($at)
    /* 8F5D0 8009EDD0 4000028E */  lw         $v0, 0x40($s0)
    /* 8F5D4 8009EDD4 FEFF0324 */  addiu      $v1, $zero, -0x2
    /* 8F5D8 8009EDD8 24104300 */  and        $v0, $v0, $v1
  .L8009EDDC:
    /* 8F5DC 8009EDDC 400002AE */  sw         $v0, 0x40($s0)
  .L8009EDE0:
    /* 8F5E0 8009EDE0 1C0D908F */  lw         $s0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F5E4 8009EDE4 AFA1020C */  jal        IsDisabled__10tPMenuItem
    /* 8F5E8 8009EDE8 64010426 */   addiu     $a0, $s0, 0x164
    /* 8F5EC 8009EDEC 07004010 */  beqz       $v0, .L8009EE0C
    /* 8F5F0 8009EDF0 01000224 */   addiu     $v0, $zero, 0x1
    /* 8F5F4 8009EDF4 1480013C */  lui        $at, %hi(ChangedEnabling)
    /* 8F5F8 8009EDF8 ECD222AC */  sw         $v0, %lo(ChangedEnabling)($at)
    /* 8F5FC 8009EDFC 6401028E */  lw         $v0, 0x164($s0)
    /* 8F600 8009EE00 FEFF0324 */  addiu      $v1, $zero, -0x2
    /* 8F604 8009EE04 24104300 */  and        $v0, $v0, $v1
    /* 8F608 8009EE08 640102AE */  sw         $v0, 0x164($s0)
  .L8009EE0C:
    /* 8F60C 8009EE0C 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* 8F610 8009EE10 F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* 8F614 8009EE14 00000000 */  nop
    /* 8F618 8009EE18 02004228 */  slti       $v0, $v0, 0x2
    /* 8F61C 8009EE1C 10004014 */  bnez       $v0, .L8009EE60
    /* 8F620 8009EE20 FFFE0524 */   addiu     $a1, $zero, -0x101
    /* 8F624 8009EE24 1C0D838F */  lw         $v1, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F628 8009EE28 00000000 */  nop
    /* 8F62C 8009EE2C 40006424 */  addiu      $a0, $v1, 0x40
    /* 8F630 8009EE30 0C00828C */  lw         $v0, 0xC($a0)
    /* 8F634 8009EE34 00000000 */  nop
    /* 8F638 8009EE38 24104500 */  and        $v0, $v0, $a1
    /* 8F63C 8009EE3C 0C0082AC */  sw         $v0, 0xC($a0)
    /* 8F640 8009EE40 1C006424 */  addiu      $a0, $v1, 0x1C
    /* 8F644 8009EE44 0C00828C */  lw         $v0, 0xC($a0)
    /* 8F648 8009EE48 50006324 */  addiu      $v1, $v1, 0x50
    /* 8F64C 8009EE4C 24104500 */  and        $v0, $v0, $a1
    /* 8F650 8009EE50 0C0082AC */  sw         $v0, 0xC($a0)
    /* 8F654 8009EE54 0C00628C */  lw         $v0, 0xC($v1)
    /* 8F658 8009EE58 A77B0208 */  j          .L8009EE9C
    /* 8F65C 8009EE5C 24104500 */   and       $v0, $v0, $a1
  .L8009EE60:
    /* 8F660 8009EE60 1C0D838F */  lw         $v1, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F664 8009EE64 00000000 */  nop
    /* 8F668 8009EE68 40006424 */  addiu      $a0, $v1, 0x40
    /* 8F66C 8009EE6C 0C00828C */  lw         $v0, 0xC($a0)
    /* 8F670 8009EE70 00000000 */  nop
    /* 8F674 8009EE74 00014234 */  ori        $v0, $v0, 0x100
    /* 8F678 8009EE78 0C0082AC */  sw         $v0, 0xC($a0)
    /* 8F67C 8009EE7C 1C006424 */  addiu      $a0, $v1, 0x1C
    /* 8F680 8009EE80 0C00828C */  lw         $v0, 0xC($a0)
    /* 8F684 8009EE84 50006324 */  addiu      $v1, $v1, 0x50
    /* 8F688 8009EE88 00014234 */  ori        $v0, $v0, 0x100
    /* 8F68C 8009EE8C 0C0082AC */  sw         $v0, 0xC($a0)
    /* 8F690 8009EE90 0C00628C */  lw         $v0, 0xC($v1)
    /* 8F694 8009EE94 00000000 */  nop
    /* 8F698 8009EE98 00014234 */  ori        $v0, $v0, 0x100
  .L8009EE9C:
    /* 8F69C 8009EE9C 0C0062AC */  sw         $v0, 0xC($v1)
    /* 8F6A0 8009EEA0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 8F6A4 8009EEA4 1000B08F */  lw         $s0, 0x10($sp)
    /* 8F6A8 8009EEA8 0800E003 */  jr         $ra
    /* 8F6AC 8009EEAC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MPause_StartPauseMenu__Fv
