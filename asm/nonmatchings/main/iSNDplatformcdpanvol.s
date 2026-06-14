.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformcdpanvol, 0x64

glabel iSNDplatformcdpanvol
    /* F9CEC 801094EC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F9CF0 801094F0 1000A627 */  addiu      $a2, $sp, 0x10
    /* F9CF4 801094F4 1800BFAF */  sw         $ra, 0x18($sp)
    /* F9CF8 801094F8 CE31040C */  jal        iSNDpvtolrv
    /* F9CFC 801094FC 1400A727 */   addiu     $a3, $sp, 0x14
    /* F9D00 80109500 1480043C */  lui        $a0, %hi(sndpd)
    /* F9D04 80109504 18798424 */  addiu      $a0, $a0, %lo(sndpd)
    /* F9D08 80109508 1000A38F */  lw         $v1, 0x10($sp)
    /* F9D0C 8010950C 1405858C */  lw         $a1, 0x514($a0)
    /* F9D10 80109510 C0110300 */  sll        $v0, $v1, 7
    /* F9D14 80109514 21104300 */  addu       $v0, $v0, $v1
    /* F9D18 80109518 40100200 */  sll        $v0, $v0, 1
    /* F9D1C 8010951C 1400A38F */  lw         $v1, 0x14($sp)
    /* F9D20 80109520 FF7F4230 */  andi       $v0, $v0, 0x7FFF
    /* F9D24 80109524 B001A2A4 */  sh         $v0, 0x1B0($a1)
    /* F9D28 80109528 C0110300 */  sll        $v0, $v1, 7
    /* F9D2C 8010952C 21104300 */  addu       $v0, $v0, $v1
    /* F9D30 80109530 40100200 */  sll        $v0, $v0, 1
    /* F9D34 80109534 1405838C */  lw         $v1, 0x514($a0)
    /* F9D38 80109538 FF7F4230 */  andi       $v0, $v0, 0x7FFF
    /* F9D3C 8010953C B20162A4 */  sh         $v0, 0x1B2($v1)
    /* F9D40 80109540 1800BF8F */  lw         $ra, 0x18($sp)
    /* F9D44 80109544 21100000 */  addu       $v0, $zero, $zero
    /* F9D48 80109548 0800E003 */  jr         $ra
    /* F9D4C 8010954C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSNDplatformcdpanvol
