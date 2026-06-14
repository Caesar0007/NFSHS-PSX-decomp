.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_RadioStaticInit__Fv, 0x3C

glabel CopSpeak_RadioStaticInit__Fv
    /* 89BDC 800993DC 21180000 */  addu       $v1, $zero, $zero
    /* 89BE0 800993E0 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 89BE4 800993E4 1480063C */  lui        $a2, %hi(CopSpeak_gStaticPatch)
    /* 89BE8 800993E8 F8D0C624 */  addiu      $a2, $a2, %lo(CopSpeak_gStaticPatch)
    /* 89BEC 800993EC 1480043C */  lui        $a0, %hi(CopSpeak_gStaticHandle)
    /* 89BF0 800993F0 F0D08424 */  addiu      $a0, $a0, %lo(CopSpeak_gStaticHandle)
  .L800993F4:
    /* 89BF4 800993F4 000085AC */  sw         $a1, 0x0($a0)
    /* 89BF8 800993F8 21106600 */  addu       $v0, $v1, $a2
    /* 89BFC 800993FC 01006324 */  addiu      $v1, $v1, 0x1
    /* 89C00 80099400 000045A0 */  sb         $a1, 0x0($v0)
    /* 89C04 80099404 02006228 */  slti       $v0, $v1, 0x2
    /* 89C08 80099408 FAFF4014 */  bnez       $v0, .L800993F4
    /* 89C0C 8009940C 04008424 */   addiu     $a0, $a0, 0x4
    /* 89C10 80099410 0800E003 */  jr         $ra
    /* 89C14 80099414 00000000 */   nop
endlabel CopSpeak_RadioStaticInit__Fv
