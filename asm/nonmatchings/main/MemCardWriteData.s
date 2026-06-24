.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardWriteData, 0xB8

glabel MemCardWriteData
    /* EBA54 800FB254 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EBA58 800FB258 1480073C */  lui        $a3, %hi(D_80147528)
    /* EBA5C 800FB25C 2875E724 */  addiu      $a3, $a3, %lo(D_80147528)
    /* EBA60 800FB260 1000BFAF */  sw         $ra, 0x10($sp)
    /* EBA64 800FB264 0000E28C */  lw         $v0, 0x0($a3)
    /* EBA68 800FB268 00000000 */  nop
    /* EBA6C 800FB26C 04004104 */  bgez       $v0, .L800FB280
    /* EBA70 800FB270 21408000 */   addu      $t0, $a0, $zero
    /* EBA74 800FB274 0580043C */  lui        $a0, %hi(D_80057440)
    /* EBA78 800FB278 BCEC0308 */  j          .L800FB2F0
    /* EBA7C 800FB27C 40748424 */   addiu     $a0, $a0, %lo(D_80057440)
  .L800FB280:
    /* EBA80 800FB280 F0FFE28C */  lw         $v0, -0x10($a3)
    /* EBA84 800FB284 00000000 */  nop
    /* EBA88 800FB288 04004018 */  blez       $v0, .L800FB29C
    /* EBA8C 800FB28C F0FFE324 */   addiu     $v1, $a3, -0x10
    /* EBA90 800FB290 0580043C */  lui        $a0, %hi(D_80057370)
    /* EBA94 800FB294 BCEC0308 */  j          .L800FB2F0
    /* EBA98 800FB298 70738424 */   addiu     $a0, $a0, %lo(D_80057370)
  .L800FB29C:
    /* EBA9C 800FB29C 7F00C230 */  andi       $v0, $a2, 0x7F
    /* EBAA0 800FB2A0 04004010 */  beqz       $v0, .L800FB2B4
    /* EBAA4 800FB2A4 7F00A230 */   andi      $v0, $a1, 0x7F
    /* EBAA8 800FB2A8 0580043C */  lui        $a0, %hi(D_80057464)
    /* EBAAC 800FB2AC BCEC0308 */  j          .L800FB2F0
    /* EBAB0 800FB2B0 64748424 */   addiu     $a0, $a0, %lo(D_80057464)
  .L800FB2B4:
    /* EBAB4 800FB2B4 0C004014 */  bnez       $v0, .L800FB2E8
    /* EBAB8 800FB2B8 06000224 */   addiu     $v0, $zero, 0x6
    /* EBABC 800FB2BC 1080043C */  lui        $a0, %hi(MemCardWriteData_cb)
    /* EBAC0 800FB2C0 0CB38424 */  addiu      $a0, $a0, %lo(MemCardWriteData_cb)
    /* EBAC4 800FB2C4 F0FFE2AC */  sw         $v0, -0x10($a3)
    /* EBAC8 800FB2C8 040060AC */  sw         $zero, 0x4($v1)
    /* EBACC 800FB2CC 080060AC */  sw         $zero, 0x8($v1)
    /* EBAD0 800FB2D0 140065AC */  sw         $a1, 0x14($v1)
    /* EBAD4 800FB2D4 1C0068AC */  sw         $t0, 0x1C($v1)
    /* EBAD8 800FB2D8 0427040C */  jal        UserFuncOpen
    /* EBADC 800FB2DC 180066AC */   sw        $a2, 0x18($v1)
    /* EBAE0 800FB2E0 BFEC0308 */  j          .L800FB2FC
    /* EBAE4 800FB2E4 01000224 */   addiu     $v0, $zero, 0x1
  .L800FB2E8:
    /* EBAE8 800FB2E8 0580043C */  lui        $a0, %hi(D_80057490)
    /* EBAEC 800FB2EC 90748424 */  addiu      $a0, $a0, %lo(D_80057490)
  .L800FB2F0:
    /* EBAF0 800FB2F0 2B0A040C */  jal        printf
    /* EBAF4 800FB2F4 00000000 */   nop
    /* EBAF8 800FB2F8 21100000 */  addu       $v0, $zero, $zero
  .L800FB2FC:
    /* EBAFC 800FB2FC 1000BF8F */  lw         $ra, 0x10($sp)
    /* EBB00 800FB300 1800BD27 */  addiu      $sp, $sp, 0x18
    /* EBB04 800FB304 0800E003 */  jr         $ra
    /* EBB08 800FB308 00000000 */   nop
endlabel MemCardWriteData
