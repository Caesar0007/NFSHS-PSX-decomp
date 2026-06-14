.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_CheckBankBit, 0x54

glabel iSPCH_CheckBankBit
    /* F121C 80100A1C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F1220 80100A20 1400B1AF */  sw         $s1, 0x14($sp)
    /* F1224 80100A24 2188A000 */  addu       $s1, $a1, $zero
    /* F1228 80100A28 1800BFAF */  sw         $ra, 0x18($sp)
    /* F122C 80100A2C 0200A104 */  bgez       $a1, .L80100A38
    /* F1230 80100A30 1000B0AF */   sw        $s0, 0x10($sp)
    /* F1234 80100A34 0700B124 */  addiu      $s1, $a1, 0x7
  .L80100A38:
    /* F1238 80100A38 C3881100 */  sra        $s1, $s1, 3
    /* F123C 80100A3C C0101100 */  sll        $v0, $s1, 3
    /* F1240 80100A40 2310A200 */  subu       $v0, $a1, $v0
    /* F1244 80100A44 01001024 */  addiu      $s0, $zero, 0x1
    /* F1248 80100A48 6502040C */  jal        iSPCH_GetBankBits
    /* F124C 80100A4C 04805000 */   sllv      $s0, $s0, $v0
    /* F1250 80100A50 21105100 */  addu       $v0, $v0, $s1
    /* F1254 80100A54 00004290 */  lbu        $v0, 0x0($v0)
    /* F1258 80100A58 1800BF8F */  lw         $ra, 0x18($sp)
    /* F125C 80100A5C 1400B18F */  lw         $s1, 0x14($sp)
    /* F1260 80100A60 24105000 */  and        $v0, $v0, $s0
    /* F1264 80100A64 1000B08F */  lw         $s0, 0x10($sp)
    /* F1268 80100A68 0800E003 */  jr         $ra
    /* F126C 80100A6C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSPCH_CheckBankBit
