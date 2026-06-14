.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_GetProfileMask__Fi, 0x40

glabel AIWorld_GetProfileMask__Fi
    /* 63BFC 800733FC 07000224 */  addiu      $v0, $zero, 0x7
    /* 63C00 80073400 23104400 */  subu       $v0, $v0, $a0
    /* 63C04 80073404 08000324 */  addiu      $v1, $zero, 0x8
    /* 63C08 80073408 23186200 */  subu       $v1, $v1, $v0
    /* 63C0C 8007340C 03006104 */  bgez       $v1, .L8007341C
    /* 63C10 80073410 10006228 */   slti      $v0, $v1, 0x10
    /* 63C14 80073414 21180000 */  addu       $v1, $zero, $zero
    /* 63C18 80073418 10006228 */  slti       $v0, $v1, 0x10
  .L8007341C:
    /* 63C1C 8007341C 02004014 */  bnez       $v0, .L80073428
    /* 63C20 80073420 00000000 */   nop
    /* 63C24 80073424 0F000324 */  addiu      $v1, $zero, 0xF
  .L80073428:
    /* 63C28 80073428 0F000224 */  addiu      $v0, $zero, 0xF
    /* 63C2C 8007342C 23104300 */  subu       $v0, $v0, $v1
    /* 63C30 80073430 01000324 */  addiu      $v1, $zero, 0x1
    /* 63C34 80073434 0800E003 */  jr         $ra
    /* 63C38 80073438 04104300 */   sllv      $v0, $v1, $v0
endlabel AIWorld_GetProfileMask__Fi
