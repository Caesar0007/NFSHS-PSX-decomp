.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__7tScreenb, 0x54

glabel Draw__7tScreenb
    /* 169EC 800261EC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 169F0 800261F0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 169F4 800261F4 0700A010 */  beqz       $a1, .L80026214
    /* 169F8 800261F8 21188000 */   addu      $v1, $a0, $zero
    /* 169FC 800261FC 6000628C */  lw         $v0, 0x60($v1)
    /* 16A00 80026200 00000000 */  nop
    /* 16A04 80026204 10004484 */  lh         $a0, 0x10($v0)
    /* 16A08 80026208 1400428C */  lw         $v0, 0x14($v0)
    /* 16A0C 8002620C 89980008 */  j          .L80026224
    /* 16A10 80026210 00000000 */   nop
  .L80026214:
    /* 16A14 80026214 6000628C */  lw         $v0, 0x60($v1)
    /* 16A18 80026218 00000000 */  nop
    /* 16A1C 8002621C 18004484 */  lh         $a0, 0x18($v0)
    /* 16A20 80026220 1C00428C */  lw         $v0, 0x1C($v0)
  .L80026224:
    /* 16A24 80026224 00000000 */  nop
    /* 16A28 80026228 09F84000 */  jalr       $v0
    /* 16A2C 8002622C 21206400 */   addu      $a0, $v1, $a0
    /* 16A30 80026230 1000BF8F */  lw         $ra, 0x10($sp)
    /* 16A34 80026234 00000000 */  nop
    /* 16A38 80026238 0800E003 */  jr         $ra
    /* 16A3C 8002623C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Draw__7tScreenb
