.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __10AnimScriptii, 0x9C

glabel __10AnimScriptii
    /* 64BCC 800743CC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 64BD0 800743D0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 64BD4 800743D4 21888000 */  addu       $s1, $a0, $zero
    /* 64BD8 800743D8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 64BDC 800743DC 2190A000 */  addu       $s2, $a1, $zero
    /* 64BE0 800743E0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 64BE4 800743E4 2180C000 */  addu       $s0, $a2, $zero
    /* 64BE8 800743E8 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 64BEC 800743EC 618F020C */  jal        __builtin_vec_new
    /* 64BF0 800743F0 80201000 */   sll       $a0, $s0, 2
    /* 64BF4 800743F4 21280000 */  addu       $a1, $zero, $zero
    /* 64BF8 800743F8 0F00001A */  blez       $s0, .L80074438
    /* 64BFC 800743FC 100022AE */   sw        $v0, 0x10($s1)
    /* 64C00 80074400 1180023C */  lui        $v0, %hi(animScripts)
    /* 64C04 80074404 4CE24624 */  addiu      $a2, $v0, %lo(animScripts)
    /* 64C08 80074408 80200500 */  sll        $a0, $a1, 2
  .L8007440C:
    /* 64C0C 8007440C 21104502 */  addu       $v0, $s2, $a1
    /* 64C10 80074410 0100A524 */  addiu      $a1, $a1, 0x1
    /* 64C14 80074414 80100200 */  sll        $v0, $v0, 2
    /* 64C18 80074418 21104600 */  addu       $v0, $v0, $a2
    /* 64C1C 8007441C 1000238E */  lw         $v1, 0x10($s1)
    /* 64C20 80074420 0000428C */  lw         $v0, 0x0($v0)
    /* 64C24 80074424 21208300 */  addu       $a0, $a0, $v1
    /* 64C28 80074428 000082AC */  sw         $v0, 0x0($a0)
    /* 64C2C 8007442C 2A10B000 */  slt        $v0, $a1, $s0
    /* 64C30 80074430 F6FF4014 */  bnez       $v0, .L8007440C
    /* 64C34 80074434 80200500 */   sll       $a0, $a1, 2
  .L80074438:
    /* 64C38 80074438 21102002 */  addu       $v0, $s1, $zero
    /* 64C3C 8007443C 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* 64C40 80074440 B0E0648C */  lw         $a0, %lo(D_8011E0B0)($v1)
    /* 64C44 80074444 06000324 */  addiu      $v1, $zero, 0x6
    /* 64C48 80074448 080043AC */  sw         $v1, 0x8($v0)
    /* 64C4C 8007444C 000044AC */  sw         $a0, 0x0($v0)
    /* 64C50 80074450 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 64C54 80074454 1800B28F */  lw         $s2, 0x18($sp)
    /* 64C58 80074458 1400B18F */  lw         $s1, 0x14($sp)
    /* 64C5C 8007445C 1000B08F */  lw         $s0, 0x10($sp)
    /* 64C60 80074460 0800E003 */  jr         $ra
    /* 64C64 80074464 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __10AnimScriptii
