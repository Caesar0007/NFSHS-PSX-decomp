.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardReadData, 0xB8

glabel MemCardReadData
    /* EB860 800FB060 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EB864 800FB064 1480073C */  lui        $a3, %hi(D_80147528)
    /* EB868 800FB068 2875E724 */  addiu      $a3, $a3, %lo(D_80147528)
    /* EB86C 800FB06C 1000BFAF */  sw         $ra, 0x10($sp)
    /* EB870 800FB070 0000E28C */  lw         $v0, 0x0($a3)
    /* EB874 800FB074 00000000 */  nop
    /* EB878 800FB078 04004104 */  bgez       $v0, .L800FB08C
    /* EB87C 800FB07C 21408000 */   addu      $t0, $a0, $zero
    /* EB880 800FB080 0580043C */  lui        $a0, %hi(D_80057440)
    /* EB884 800FB084 3FEC0308 */  j          .L800FB0FC
    /* EB888 800FB088 40748424 */   addiu     $a0, $a0, %lo(D_80057440)
  .L800FB08C:
    /* EB88C 800FB08C F0FFE28C */  lw         $v0, -0x10($a3)
    /* EB890 800FB090 00000000 */  nop
    /* EB894 800FB094 04004018 */  blez       $v0, .L800FB0A8
    /* EB898 800FB098 F0FFE324 */   addiu     $v1, $a3, -0x10
    /* EB89C 800FB09C 0580043C */  lui        $a0, %hi(D_80057370)
    /* EB8A0 800FB0A0 3FEC0308 */  j          .L800FB0FC
    /* EB8A4 800FB0A4 70738424 */   addiu     $a0, $a0, %lo(D_80057370)
  .L800FB0A8:
    /* EB8A8 800FB0A8 7F00C230 */  andi       $v0, $a2, 0x7F
    /* EB8AC 800FB0AC 04004010 */  beqz       $v0, .L800FB0C0
    /* EB8B0 800FB0B0 7F00A230 */   andi      $v0, $a1, 0x7F
    /* EB8B4 800FB0B4 0580043C */  lui        $a0, %hi(D_80057464)
    /* EB8B8 800FB0B8 3FEC0308 */  j          .L800FB0FC
    /* EB8BC 800FB0BC 64748424 */   addiu     $a0, $a0, %lo(D_80057464)
  .L800FB0C0:
    /* EB8C0 800FB0C0 0C004014 */  bnez       $v0, .L800FB0F4
    /* EB8C4 800FB0C4 05000224 */   addiu     $v0, $zero, 0x5
    /* EB8C8 800FB0C8 1080043C */  lui        $a0, %hi(MemCardReadData_cb)
    /* EB8CC 800FB0CC 18B18424 */  addiu      $a0, $a0, %lo(MemCardReadData_cb)
    /* EB8D0 800FB0D0 F0FFE2AC */  sw         $v0, -0x10($a3)
    /* EB8D4 800FB0D4 040060AC */  sw         $zero, 0x4($v1)
    /* EB8D8 800FB0D8 080060AC */  sw         $zero, 0x8($v1)
    /* EB8DC 800FB0DC 140065AC */  sw         $a1, 0x14($v1)
    /* EB8E0 800FB0E0 1C0068AC */  sw         $t0, 0x1C($v1)
    /* EB8E4 800FB0E4 0427040C */  jal        UserFuncOpen
    /* EB8E8 800FB0E8 180066AC */   sw        $a2, 0x18($v1)
    /* EB8EC 800FB0EC 42EC0308 */  j          .L800FB108
    /* EB8F0 800FB0F0 01000224 */   addiu     $v0, $zero, 0x1
  .L800FB0F4:
    /* EB8F4 800FB0F4 0580043C */  lui        $a0, %hi(D_80057490)
    /* EB8F8 800FB0F8 90748424 */  addiu      $a0, $a0, %lo(D_80057490)
  .L800FB0FC:
    /* EB8FC 800FB0FC 2B0A040C */  jal        printf
    /* EB900 800FB100 00000000 */   nop
    /* EB904 800FB104 21100000 */  addu       $v0, $zero, $zero
  .L800FB108:
    /* EB908 800FB108 1000BF8F */  lw         $ra, 0x10($sp)
    /* EB90C 800FB10C 1800BD27 */  addiu      $sp, $sp, 0x18
    /* EB910 800FB110 0800E003 */  jr         $ra
    /* EB914 800FB114 00000000 */   nop
endlabel MemCardReadData
