.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_SimCar__FP8Car_tObj, 0x84

glabel Physics_SimCar__FP8Car_tObj
    /* 9DD44 800AD544 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 9DD48 800AD548 1000BFAF */  sw         $ra, 0x10($sp)
    /* 9DD4C 800AD54C 2C01828C */  lw         $v0, 0x12C($a0)
    /* 9DD50 800AD550 00000000 */  nop
    /* 9DD54 800AD554 99194228 */  slti       $v0, $v0, 0x1999
    /* 9DD58 800AD558 15004010 */  beqz       $v0, .L800AD5B0
    /* 9DD5C 800AD55C 00000000 */   nop
    /* 9DD60 800AD560 6804838C */  lw         $v1, 0x468($a0)
    /* 9DD64 800AD564 6C0480AC */  sw         $zero, 0x46C($a0)
    /* 9DD68 800AD568 780480AC */  sw         $zero, 0x478($a0)
    /* 9DD6C 800AD56C 840480AC */  sw         $zero, 0x484($a0)
    /* 9DD70 800AD570 F5016228 */  slti       $v0, $v1, 0x1F5
    /* 9DD74 800AD574 04004014 */  bnez       $v0, .L800AD588
    /* 9DD78 800AD578 880480AC */   sw        $zero, 0x488($a0)
    /* 9DD7C 800AD57C 0CFE6224 */  addiu      $v0, $v1, -0x1F4
    /* 9DD80 800AD580 63B50208 */  j          .L800AD58C
    /* 9DD84 800AD584 680482AC */   sw        $v0, 0x468($a0)
  .L800AD588:
    /* 9DD88 800AD588 680480AC */  sw         $zero, 0x468($a0)
  .L800AD58C:
    /* 9DD8C 800AD58C 8801838C */  lw         $v1, 0x188($a0)
    /* 9DD90 800AD590 FF7F0224 */  addiu      $v0, $zero, 0x7FFF
    /* 9DD94 800AD594 2A104300 */  slt        $v0, $v0, $v1
    /* 9DD98 800AD598 07004014 */  bnez       $v0, .L800AD5B8
    /* 9DD9C 800AD59C 00000000 */   nop
    /* 9DDA0 800AD5A0 B6A9020C */  jal        Physics_StopCar__FP8Car_tObj
    /* 9DDA4 800AD5A4 00000000 */   nop
    /* 9DDA8 800AD5A8 6EB50208 */  j          .L800AD5B8
    /* 9DDAC 800AD5AC 00000000 */   nop
  .L800AD5B0:
    /* 9DDB0 800AD5B0 59B0020C */  jal        Physics_Real__FP8Car_tObj
    /* 9DDB4 800AD5B4 00000000 */   nop
  .L800AD5B8:
    /* 9DDB8 800AD5B8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 9DDBC 800AD5BC 00000000 */  nop
    /* 9DDC0 800AD5C0 0800E003 */  jr         $ra
    /* 9DDC4 800AD5C4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Physics_SimCar__FP8Car_tObj
