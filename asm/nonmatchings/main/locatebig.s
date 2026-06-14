.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching locatebig, 0x40

glabel locatebig
    /* D6A18 800E6218 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D6A1C 800E621C 1400B1AF */  sw         $s1, 0x14($sp)
    /* D6A20 800E6220 21888000 */  addu       $s1, $a0, $zero
    /* D6A24 800E6224 1000B0AF */  sw         $s0, 0x10($sp)
    /* D6A28 800E6228 1800BFAF */  sw         $ra, 0x18($sp)
    /* D6A2C 800E622C 7798030C */  jal        locatebigoffset
    /* D6A30 800E6230 21800000 */   addu      $s0, $zero, $zero
    /* D6A34 800E6234 02004010 */  beqz       $v0, .L800E6240
    /* D6A38 800E6238 00000000 */   nop
    /* D6A3C 800E623C 21802202 */  addu       $s0, $s1, $v0
  .L800E6240:
    /* D6A40 800E6240 21100002 */  addu       $v0, $s0, $zero
    /* D6A44 800E6244 1800BF8F */  lw         $ra, 0x18($sp)
    /* D6A48 800E6248 1400B18F */  lw         $s1, 0x14($sp)
    /* D6A4C 800E624C 1000B08F */  lw         $s0, 0x10($sp)
    /* D6A50 800E6250 0800E003 */  jr         $ra
    /* D6A54 800E6254 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel locatebig
