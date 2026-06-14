.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800FDEF0, 0xF4

glabel func_800FDEF0
    /* EE6F0 800FDEF0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* EE6F4 800FDEF4 21288000 */  addu       $a1, $a0, $zero
    /* EE6F8 800FDEF8 1400B1AF */  sw         $s1, 0x14($sp)
    /* EE6FC 800FDEFC 1480113C */  lui        $s1, %hi(D_80147600)
    /* EE700 800FDF00 00763126 */  addiu      $s1, $s1, %lo(D_80147600)
    /* EE704 800FDF04 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* EE708 800FDF08 F7FF1324 */  addiu      $s3, $zero, -0x9
    /* EE70C 800FDF0C 1800B2AF */  sw         $s2, 0x18($sp)
    /* EE710 800FDF10 1380123C */  lui        $s2, %hi(_padFixResult)
    /* EE714 800FDF14 D07C5226 */  addiu      $s2, $s2, %lo(_padFixResult)
    /* EE718 800FDF18 2000BFAF */  sw         $ra, 0x20($sp)
    /* EE71C 800FDF1C 1000B0AF */  sw         $s0, 0x10($sp)
  .L800FDF20:
    /* EE720 800FDF20 1380033C */  lui        $v1, %hi(_padSioChan)
    /* EE724 800FDF24 B87C638C */  lw         $v1, %lo(_padSioChan)($v1)
    /* EE728 800FDF28 00000000 */  nop
    /* EE72C 800FDF2C 00110300 */  sll        $v0, $v1, 4
    /* EE730 800FDF30 23104300 */  subu       $v0, $v0, $v1
    /* EE734 800FDF34 00110200 */  sll        $v0, $v0, 4
    /* EE738 800FDF38 0A00B310 */  beq        $a1, $s3, .L800FDF64
    /* EE73C 800FDF3C 21805100 */   addu      $s0, $v0, $s1
    /* EE740 800FDF40 0400A014 */  bnez       $a1, .L800FDF54
    /* EE744 800FDF44 80100300 */   sll       $v0, $v1, 2
    /* EE748 800FDF48 21105200 */  addu       $v0, $v0, $s2
    /* EE74C 800FDF4C D9F70308 */  j          .L800FDF64
    /* EE750 800FDF50 000040AC */   sw        $zero, 0x0($v0)
  .L800FDF54:
    /* EE754 800FDF54 0D29040C */  jal        _dirFailAuto
    /* EE758 800FDF58 21200002 */   addu      $a0, $s0, $zero
    /* EE75C 800FDF5C F9F7030C */  jal        func_800FDFE4
    /* EE760 800FDF60 21200002 */   addu      $a0, $s0, $zero
  .L800FDF64:
    /* EE764 800FDF64 1380023C */  lui        $v0, %hi(D_80136CD8)
    /* EE768 800FDF68 D86C428C */  lw         $v0, %lo(D_80136CD8)($v0)
    /* EE76C 800FDF6C 1380033C */  lui        $v1, %hi(_padSioChan)
    /* EE770 800FDF70 B87C638C */  lw         $v1, %lo(_padSioChan)($v1)
    /* EE774 800FDF74 1380013C */  lui        $at, %hi(_padSioState)
    /* EE778 800FDF78 BC7C20AC */  sw         $zero, %lo(_padSioState)($at)
    /* EE77C 800FDF7C 0A0040A4 */  sh         $zero, 0xA($v0)
    /* EE780 800FDF80 1380023C */  lui        $v0, %hi(_padChanStop)
    /* EE784 800FDF84 CC7C428C */  lw         $v0, %lo(_padChanStop)($v0)
    /* EE788 800FDF88 01006324 */  addiu      $v1, $v1, 0x1
    /* EE78C 800FDF8C 1380013C */  lui        $at, %hi(_padSioChan)
    /* EE790 800FDF90 B87C23AC */  sw         $v1, %lo(_padSioChan)($at)
    /* EE794 800FDF94 2A104300 */  slt        $v0, $v0, $v1
    /* EE798 800FDF98 08004014 */  bnez       $v0, .L800FDFBC
    /* EE79C 800FDF9C 01000224 */   addiu     $v0, $zero, 0x1
    /* EE7A0 800FDFA0 00210300 */  sll        $a0, $v1, 4
    /* EE7A4 800FDFA4 23208300 */  subu       $a0, $a0, $v1
    /* EE7A8 800FDFA8 00210400 */  sll        $a0, $a0, 4
    /* EE7AC 800FDFAC 4B13040C */  jal        _padInitSioMode
    /* EE7B0 800FDFB0 21209100 */   addu      $a0, $a0, $s1
    /* EE7B4 800FDFB4 F0F70308 */  j          .L800FDFC0
    /* EE7B8 800FDFB8 FFFF0534 */   ori       $a1, $zero, 0xFFFF
  .L800FDFBC:
    /* EE7BC 800FDFBC FFFF0534 */  ori        $a1, $zero, 0xFFFF
  .L800FDFC0:
    /* EE7C0 800FDFC0 D7FF4010 */  beqz       $v0, .L800FDF20
    /* EE7C4 800FDFC4 00000000 */   nop
    /* EE7C8 800FDFC8 2000BF8F */  lw         $ra, 0x20($sp)
    /* EE7CC 800FDFCC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* EE7D0 800FDFD0 1800B28F */  lw         $s2, 0x18($sp)
    /* EE7D4 800FDFD4 1400B18F */  lw         $s1, 0x14($sp)
    /* EE7D8 800FDFD8 1000B08F */  lw         $s0, 0x10($sp)
    /* EE7DC 800FDFDC 0800E003 */  jr         $ra
    /* EE7E0 800FDFE0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel func_800FDEF0
