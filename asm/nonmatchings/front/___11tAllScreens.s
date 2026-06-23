.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___11tAllScreens, 0x1D0

glabel ___11tAllScreens
    /* 1C70C 8002BF0C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 1C710 8002BF10 1800B2AF */  sw         $s2, 0x18($sp)
    /* 1C714 8002BF14 21908000 */  addu       $s2, $a0, $zero
    /* 1C718 8002BF18 1400B1AF */  sw         $s1, 0x14($sp)
    /* 1C71C 8002BF1C 2188A000 */  addu       $s1, $a1, $zero
    /* 1C720 8002BF20 543A4426 */  addiu      $a0, $s2, 0x3A54
    /* 1C724 8002BF24 02000524 */  addiu      $a1, $zero, 0x2
    /* 1C728 8002BF28 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 1C72C 8002BF2C 1E98000C */  jal        ___7tScreen
    /* 1C730 8002BF30 1000B0AF */   sw        $s0, 0x10($sp)
    /* 1C734 8002BF34 D0384426 */  addiu      $a0, $s2, 0x38D0
    /* 1C738 8002BF38 1E98000C */  jal        ___7tScreen
    /* 1C73C 8002BF3C 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C740 8002BF40 08364426 */  addiu      $a0, $s2, 0x3608
    /* 1C744 8002BF44 1E98000C */  jal        ___7tScreen
    /* 1C748 8002BF48 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C74C 8002BF4C 74354426 */  addiu      $a0, $s2, 0x3574
    /* 1C750 8002BF50 1E98000C */  jal        ___7tScreen
    /* 1C754 8002BF54 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C758 8002BF58 E0344426 */  addiu      $a0, $s2, 0x34E0
    /* 1C75C 8002BF5C 1E98000C */  jal        ___7tScreen
    /* 1C760 8002BF60 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C764 8002BF64 58334426 */  addiu      $a0, $s2, 0x3358
    /* 1C768 8002BF68 1E98000C */  jal        ___7tScreen
    /* 1C76C 8002BF6C 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C770 8002BF70 8C324426 */  addiu      $a0, $s2, 0x328C
    /* 1C774 8002BF74 1E98000C */  jal        ___7tScreen
    /* 1C778 8002BF78 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C77C 8002BF7C E82C4426 */  addiu      $a0, $s2, 0x2CE8
    /* 1C780 8002BF80 1E98000C */  jal        ___7tScreen
    /* 1C784 8002BF84 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C788 8002BF88 6C2C4426 */  addiu      $a0, $s2, 0x2C6C
    /* 1C78C 8002BF8C 1E98000C */  jal        ___7tScreen
    /* 1C790 8002BF90 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C794 8002BF94 082C4426 */  addiu      $a0, $s2, 0x2C08
    /* 1C798 8002BF98 1E98000C */  jal        ___7tScreen
    /* 1C79C 8002BF9C 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C7A0 8002BFA0 442B4426 */  addiu      $a0, $s2, 0x2B44
    /* 1C7A4 8002BFA4 02000524 */  addiu      $a1, $zero, 0x2
    /* 1C7A8 8002BFA8 1E98000C */  jal        ___7tScreen
    /* 1C7AC 8002BFAC 8C2A5026 */   addiu     $s0, $s2, 0x2A8C
    /* 1C7B0 8002BFB0 21200002 */  addu       $a0, $s0, $zero
    /* 1C7B4 8002BFB4 1E98000C */  jal        ___7tScreen
    /* 1C7B8 8002BFB8 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C7BC 8002BFBC 242A4426 */  addiu      $a0, $s2, 0x2A24
    /* 1C7C0 8002BFC0 1E98000C */  jal        ___7tScreen
    /* 1C7C4 8002BFC4 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C7C8 8002BFC8 CC284426 */  addiu      $a0, $s2, 0x28CC
    /* 1C7CC 8002BFCC 6C01010C */  jal        ___17tScreenTrophyRoom
    /* 1C7D0 8002BFD0 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C7D4 8002BFD4 44274426 */  addiu      $a0, $s2, 0x2744
    /* 1C7D8 8002BFD8 1E98000C */  jal        ___7tScreen
    /* 1C7DC 8002BFDC 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C7E0 8002BFE0 B0264426 */  addiu      $a0, $s2, 0x26B0
    /* 1C7E4 8002BFE4 1E98000C */  jal        ___7tScreen
    /* 1C7E8 8002BFE8 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C7EC 8002BFEC E8234426 */  addiu      $a0, $s2, 0x23E8
    /* 1C7F0 8002BFF0 EBFD000C */  jal        ___18tScreenTournSelect
    /* 1C7F4 8002BFF4 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C7F8 8002BFF8 48214426 */  addiu      $a0, $s2, 0x2148
    /* 1C7FC 8002BFFC 1E98000C */  jal        ___7tScreen
    /* 1C800 8002C000 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C804 8002C004 A41E4426 */  addiu      $a0, $s2, 0x1EA4
    /* 1C808 8002C008 1E98000C */  jal        ___7tScreen
    /* 1C80C 8002C00C 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C810 8002C010 301E4426 */  addiu      $a0, $s2, 0x1E30
    /* 1C814 8002C014 1E98000C */  jal        ___7tScreen
    /* 1C818 8002C018 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C81C 8002C01C 841D4426 */  addiu      $a0, $s2, 0x1D84
    /* 1C820 8002C020 02000524 */  addiu      $a1, $zero, 0x2
    /* 1C824 8002C024 1E98000C */  jal        ___7tScreen
    /* 1C828 8002C028 E4195026 */   addiu     $s0, $s2, 0x19E4
    /* 1C82C 8002C02C 21200002 */  addu       $a0, $s0, $zero
    /* 1C830 8002C030 24EB000C */  jal        ___16tScreenCarSelect
    /* 1C834 8002C034 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C838 8002C038 38194426 */  addiu      $a0, $s2, 0x1938
    /* 1C83C 8002C03C 02000524 */  addiu      $a1, $zero, 0x2
    /* 1C840 8002C040 1E98000C */  jal        ___7tScreen
    /* 1C844 8002C044 98155026 */   addiu     $s0, $s2, 0x1598
    /* 1C848 8002C048 21200002 */  addu       $a0, $s0, $zero
    /* 1C84C 8002C04C 24EB000C */  jal        ___16tScreenCarSelect
    /* 1C850 8002C050 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C854 8002C054 00154426 */  addiu      $a0, $s2, 0x1500
    /* 1C858 8002C058 02000524 */  addiu      $a1, $zero, 0x2
    /* 1C85C 8002C05C 1E98000C */  jal        ___7tScreen
    /* 1C860 8002C060 60115026 */   addiu     $s0, $s2, 0x1160
    /* 1C864 8002C064 21200002 */  addu       $a0, $s0, $zero
    /* 1C868 8002C068 24EB000C */  jal        ___16tScreenCarSelect
    /* 1C86C 8002C06C 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C870 8002C070 C8104426 */  addiu      $a0, $s2, 0x10C8
    /* 1C874 8002C074 02000524 */  addiu      $a1, $zero, 0x2
    /* 1C878 8002C078 1E98000C */  jal        ___7tScreen
    /* 1C87C 8002C07C 280D5026 */   addiu     $s0, $s2, 0xD28
    /* 1C880 8002C080 21200002 */  addu       $a0, $s0, $zero
    /* 1C884 8002C084 24EB000C */  jal        ___16tScreenCarSelect
    /* 1C888 8002C088 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C88C 8002C08C 58094426 */  addiu      $a0, $s2, 0x958
    /* 1C890 8002C090 24EB000C */  jal        ___16tScreenCarSelect
    /* 1C894 8002C094 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C898 8002C098 B8054426 */  addiu      $a0, $s2, 0x5B8
    /* 1C89C 8002C09C 24EB000C */  jal        ___16tScreenCarSelect
    /* 1C8A0 8002C0A0 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C8A4 8002C0A4 21204002 */  addu       $a0, $s2, $zero
    /* 1C8A8 8002C0A8 1E98000C */  jal        ___7tScreen
    /* 1C8AC 8002C0AC 02000524 */   addiu     $a1, $zero, 0x2
    /* 1C8B0 8002C0B0 01003132 */  andi       $s1, $s1, 0x1
    /* 1C8B4 8002C0B4 03002012 */  beqz       $s1, .L8002C0C4
    /* 1C8B8 8002C0B8 00000000 */   nop
    /* 1C8BC 8002C0BC 6B8F020C */  jal        __builtin_delete
    /* 1C8C0 8002C0C0 21204002 */   addu      $a0, $s2, $zero
  .L8002C0C4:
    /* 1C8C4 8002C0C4 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 1C8C8 8002C0C8 1800B28F */  lw         $s2, 0x18($sp)
    /* 1C8CC 8002C0CC 1400B18F */  lw         $s1, 0x14($sp)
    /* 1C8D0 8002C0D0 1000B08F */  lw         $s0, 0x10($sp)
    /* 1C8D4 8002C0D4 0800E003 */  jr         $ra
    /* 1C8D8 8002C0D8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ___11tAllScreens
    /* 1C8DC 8002C0DC 00000000 */  nop
