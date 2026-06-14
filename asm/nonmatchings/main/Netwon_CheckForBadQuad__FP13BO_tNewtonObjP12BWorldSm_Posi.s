.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi, 0x60

glabel Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi
    /* 93624 800A2E24 7800A28C */  lw         $v0, 0x78($a1)
    /* 93628 800A2E28 00000000 */  nop
    /* 9362C 800A2E2C 06004010 */  beqz       $v0, .L800A2E48
    /* 93630 800A2E30 21380000 */   addu      $a3, $zero, $zero
    /* 93634 800A2E34 00004290 */  lbu        $v0, 0x0($v0)
    /* 93638 800A2E38 00000000 */  nop
    /* 9363C 800A2E3C 0F004230 */  andi       $v0, $v0, 0xF
    /* 93640 800A2E40 0D004010 */  beqz       $v0, .L800A2E78
    /* 93644 800A2E44 00000000 */   nop
  .L800A2E48:
    /* 93648 800A2E48 40100600 */  sll        $v0, $a2, 1
    /* 9364C 800A2E4C 21104600 */  addu       $v0, $v0, $a2
    /* 93650 800A2E50 00110200 */  sll        $v0, $v0, 4
    /* 93654 800A2E54 21108200 */  addu       $v0, $a0, $v0
    /* 93658 800A2E58 A402438C */  lw         $v1, 0x2A4($v0)
    /* 9365C 800A2E5C 9002428C */  lw         $v0, 0x290($v0)
    /* 93660 800A2E60 00000000 */  nop
    /* 93664 800A2E64 23186200 */  subu       $v1, $v1, $v0
    /* 93668 800A2E68 0200023C */  lui        $v0, (0x20000 >> 16)
    /* 9366C 800A2E6C 2A104300 */  slt        $v0, $v0, $v1
    /* 93670 800A2E70 02004010 */  beqz       $v0, .L800A2E7C
    /* 93674 800A2E74 00000000 */   nop
  .L800A2E78:
    /* 93678 800A2E78 01000724 */  addiu      $a3, $zero, 0x1
  .L800A2E7C:
    /* 9367C 800A2E7C 0800E003 */  jr         $ra
    /* 93680 800A2E80 2110E000 */   addu      $v0, $a3, $zero
endlabel Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi
