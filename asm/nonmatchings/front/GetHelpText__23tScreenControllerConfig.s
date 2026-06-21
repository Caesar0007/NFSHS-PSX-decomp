.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetHelpText__23tScreenControllerConfig, 0x60

glabel GetHelpText__23tScreenControllerConfig
    /* 360AC 800458AC 74018390 */  lbu        $v1, 0x174($a0)
    /* 360B0 800458B0 02000224 */  addiu      $v0, $zero, 0x2
    /* 360B4 800458B4 10006210 */  beq        $v1, $v0, .L800458F8
    /* 360B8 800458B8 03006228 */   slti      $v0, $v1, 0x3
    /* 360BC 800458BC 05004010 */  beqz       $v0, .L800458D4
    /* 360C0 800458C0 01000224 */   addiu     $v0, $zero, 0x1
    /* 360C4 800458C4 0A006210 */  beq        $v1, $v0, .L800458F0
    /* 360C8 800458C8 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 360CC 800458CC 41160108 */  j          .L80045904
    /* 360D0 800458D0 00000000 */   nop
  .L800458D4:
    /* 360D4 800458D4 07006228 */  slti       $v0, $v1, 0x7
    /* 360D8 800458D8 09004010 */  beqz       $v0, .L80045900
    /* 360DC 800458DC 05006228 */   slti      $v0, $v1, 0x5
    /* 360E0 800458E0 08004014 */  bnez       $v0, .L80045904
    /* 360E4 800458E4 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 360E8 800458E8 0800E003 */  jr         $ra
    /* 360EC 800458EC 18020224 */   addiu     $v0, $zero, 0x218
  .L800458F0:
    /* 360F0 800458F0 0800E003 */  jr         $ra
    /* 360F4 800458F4 19020224 */   addiu     $v0, $zero, 0x219
  .L800458F8:
    /* 360F8 800458F8 0800E003 */  jr         $ra
    /* 360FC 800458FC 1A020224 */   addiu     $v0, $zero, 0x21A
  .L80045900:
    /* 36100 80045900 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L80045904:
    /* 36104 80045904 0800E003 */  jr         $ra
    /* 36108 80045908 00000000 */   nop
endlabel GetHelpText__23tScreenControllerConfig
