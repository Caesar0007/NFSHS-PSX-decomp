.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_ClearCycleBit, 0x64

glabel iSPCH_ClearCycleBit
    /* F11B8 801009B8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F11BC 801009BC 2110A000 */  addu       $v0, $a1, $zero
    /* F11C0 801009C0 1800BFAF */  sw         $ra, 0x18($sp)
    /* F11C4 801009C4 1400B1AF */  sw         $s1, 0x14($sp)
    /* F11C8 801009C8 0200A104 */  bgez       $a1, .L801009D4
    /* F11CC 801009CC 1000B0AF */   sw        $s0, 0x10($sp)
    /* F11D0 801009D0 0700A224 */  addiu      $v0, $a1, 0x7
  .L801009D4:
    /* F11D4 801009D4 C3100200 */  sra        $v0, $v0, 3
    /* F11D8 801009D8 01005124 */  addiu      $s1, $v0, 0x1
    /* F11DC 801009DC C0100200 */  sll        $v0, $v0, 3
    /* F11E0 801009E0 2310A200 */  subu       $v0, $a1, $v0
    /* F11E4 801009E4 01001024 */  addiu      $s0, $zero, 0x1
    /* F11E8 801009E8 04805000 */  sllv       $s0, $s0, $v0
    /* F11EC 801009EC 6502040C */  jal        iSPCH_GetBankBits
    /* F11F0 801009F0 27801000 */   nor       $s0, $zero, $s0
    /* F11F4 801009F4 21105100 */  addu       $v0, $v0, $s1
    /* F11F8 801009F8 00004390 */  lbu        $v1, 0x0($v0)
    /* F11FC 801009FC 00000000 */  nop
    /* F1200 80100A00 24187000 */  and        $v1, $v1, $s0
    /* F1204 80100A04 000043A0 */  sb         $v1, 0x0($v0)
    /* F1208 80100A08 1800BF8F */  lw         $ra, 0x18($sp)
    /* F120C 80100A0C 1400B18F */  lw         $s1, 0x14($sp)
    /* F1210 80100A10 1000B08F */  lw         $s0, 0x10($sp)
    /* F1214 80100A14 0800E003 */  jr         $ra
    /* F1218 80100A18 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSPCH_ClearCycleBit
