.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__15tScreenUserName, 0xC0

glabel Initialize__15tScreenUserName
    /* 3B788 8004AF88 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 3B78C 8004AF8C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 3B790 8004AF90 21908000 */  addu       $s2, $a0, $zero
    /* 3B794 8004AF94 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3B798 8004AF98 21880000 */  addu       $s1, $zero, $zero
    /* 3B79C 8004AF9C 80000224 */  addiu      $v0, $zero, 0x80
    /* 3B7A0 8004AFA0 0580063C */  lui        $a2, %hi(menu_kUserNameRows)
    /* 3B7A4 8004AFA4 B029C484 */  lh         $a0, %lo(menu_kUserNameRows)($a2)
    /* 3B7A8 8004AFA8 0580053C */  lui        $a1, %hi(MENUUSERNAME_STARTY)
    /* 3B7AC 8004AFAC 2000BFAF */  sw         $ra, 0x20($sp)
    /* 3B7B0 8004AFB0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 3B7B4 8004AFB4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3B7B8 8004AFB8 680042A6 */  sh         $v0, 0x68($s2)
    /* 3B7BC 8004AFBC 82000224 */  addiu      $v0, $zero, 0x82
    /* 3B7C0 8004AFC0 00190400 */  sll        $v1, $a0, 4
    /* 3B7C4 8004AFC4 23186400 */  subu       $v1, $v1, $a0
    /* 3B7C8 8004AFC8 43180300 */  sra        $v1, $v1, 1
    /* 3B7CC 8004AFCC 23104300 */  subu       $v0, $v0, $v1
    /* 3B7D0 8004AFD0 14008018 */  blez       $a0, .L8004B024
    /* 3B7D4 8004AFD4 B229A2A4 */   sh        $v0, %lo(MENUUSERNAME_STARTY)($a1)
    /* 3B7D8 8004AFD8 2198C000 */  addu       $s3, $a2, $zero
    /* 3B7DC 8004AFDC 00841100 */  sll        $s0, $s1, 16
  .L8004AFE0:
    /* 3B7E0 8004AFE0 03841000 */  sra        $s0, $s0, 16
    /* 3B7E4 8004AFE4 94E4020C */  jal        TextSys_Word__Fi
    /* 3B7E8 8004AFE8 FB010426 */   addiu     $a0, $s0, 0x1FB
    /* 3B7EC 8004AFEC C0201000 */  sll        $a0, $s0, 3
    /* 3B7F0 8004AFF0 21209000 */  addu       $a0, $a0, $s0
    /* 3B7F4 8004AFF4 70008424 */  addiu      $a0, $a0, 0x70
    /* 3B7F8 8004AFF8 21204402 */  addu       $a0, $s2, $a0
    /* 3B7FC 8004AFFC 2F91030C */  jal        sprintf
    /* 3B800 8004B000 21284000 */   addu      $a1, $v0, $zero
    /* 3B804 8004B004 01002226 */  addiu      $v0, $s1, 0x1
    /* 3B808 8004B008 21884000 */  addu       $s1, $v0, $zero
    /* 3B80C 8004B00C 00140200 */  sll        $v0, $v0, 16
    /* 3B810 8004B010 B0296386 */  lh         $v1, %lo(menu_kUserNameRows)($s3)
    /* 3B814 8004B014 03140200 */  sra        $v0, $v0, 16
    /* 3B818 8004B018 2A104300 */  slt        $v0, $v0, $v1
    /* 3B81C 8004B01C F0FF4014 */  bnez       $v0, .L8004AFE0
    /* 3B820 8004B020 00841100 */   sll       $s0, $s1, 16
  .L8004B024:
    /* 3B824 8004B024 2B98000C */  jal        Initialize__7tScreen
    /* 3B828 8004B028 21204002 */   addu      $a0, $s2, $zero
    /* 3B82C 8004B02C 2000BF8F */  lw         $ra, 0x20($sp)
    /* 3B830 8004B030 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 3B834 8004B034 1800B28F */  lw         $s2, 0x18($sp)
    /* 3B838 8004B038 1400B18F */  lw         $s1, 0x14($sp)
    /* 3B83C 8004B03C 1000B08F */  lw         $s0, 0x10($sp)
    /* 3B840 8004B040 0800E003 */  jr         $ra
    /* 3B844 8004B044 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Initialize__15tScreenUserName
