.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDtimeremaining, 0x64

glabel iSNDtimeremaining
    /* F51A8 801049A8 40100400 */  sll        $v0, $a0, 1
    /* F51AC 801049AC 21104400 */  addu       $v0, $v0, $a0
    /* F51B0 801049B0 80100200 */  sll        $v0, $v0, 2
    /* F51B4 801049B4 23104400 */  subu       $v0, $v0, $a0
    /* F51B8 801049B8 80100200 */  sll        $v0, $v0, 2
    /* F51BC 801049BC 1480033C */  lui        $v1, %hi(D_801479F0)
    /* F51C0 801049C0 F0796324 */  addiu      $v1, $v1, %lo(D_801479F0)
    /* F51C4 801049C4 21184300 */  addu       $v1, $v0, $v1
    /* F51C8 801049C8 0800628C */  lw         $v0, 0x8($v1)
    /* F51CC 801049CC 00000000 */  nop
    /* F51D0 801049D0 0C004010 */  beqz       $v0, .L80104A04
    /* F51D4 801049D4 FF7F023C */   lui       $v0, (0x7FFFFFFF >> 16)
    /* F51D8 801049D8 1400628C */  lw         $v0, 0x14($v1)
    /* F51DC 801049DC 0C00648C */  lw         $a0, 0xC($v1)
    /* F51E0 801049E0 0800638C */  lw         $v1, 0x8($v1)
    /* F51E4 801049E4 23104400 */  subu       $v0, $v0, $a0
    /* F51E8 801049E8 1B004300 */  divu       $zero, $v0, $v1
    /* F51EC 801049EC 02006014 */  bnez       $v1, .L801049F8
    /* F51F0 801049F0 00000000 */   nop
    /* F51F4 801049F4 0D000700 */  break      7
  .L801049F8:
    /* F51F8 801049F8 12100000 */  mflo       $v0
    /* F51FC 801049FC 0800E003 */  jr         $ra
    /* F5200 80104A00 00000000 */   nop
  .L80104A04:
    /* F5204 80104A04 0800E003 */  jr         $ra
    /* F5208 80104A08 FFFF4234 */   ori       $v0, $v0, (0x7FFFFFFF & 0xFFFF)
endlabel iSNDtimeremaining
