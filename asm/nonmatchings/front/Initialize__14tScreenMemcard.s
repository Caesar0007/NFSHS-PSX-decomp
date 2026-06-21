.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__14tScreenMemcard, 0x1A8

glabel Initialize__14tScreenMemcard
    /* 38430 80047C30 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 38434 80047C34 1000B0AF */  sw         $s0, 0x10($sp)
    /* 38438 80047C38 21808000 */  addu       $s0, $a0, $zero
    /* 3843C 80047C3C 0180043C */  lui        $a0, %hi(D_80012220)
    /* 38440 80047C40 20228424 */  addiu      $a0, $a0, %lo(D_80012220)
    /* 38444 80047C44 0580033C */  lui        $v1, %hi(GRIDMEMCARD_STARTX)
    /* 38448 80047C48 F6000224 */  addiu      $v0, $zero, 0xF6
    /* 3844C 80047C4C F42862AC */  sw         $v0, %lo(GRIDMEMCARD_STARTX)($v1)
    /* 38450 80047C50 0580033C */  lui        $v1, %hi(GRIDMEMCARD_STARTY)
    /* 38454 80047C54 3C000224 */  addiu      $v0, $zero, 0x3C
    /* 38458 80047C58 F82862AC */  sw         $v0, %lo(GRIDMEMCARD_STARTY)($v1)
    /* 3845C 80047C5C 0580033C */  lui        $v1, %hi(MEMCARD_DELTAX)
    /* 38460 80047C60 3B000224 */  addiu      $v0, $zero, 0x3B
    /* 38464 80047C64 FC2862AC */  sw         $v0, %lo(MEMCARD_DELTAX)($v1)
    /* 38468 80047C68 0580033C */  lui        $v1, %hi(MEMCARD_DELTAY)
    /* 3846C 80047C6C 1B000224 */  addiu      $v0, $zero, 0x1B
    /* 38470 80047C70 002962AC */  sw         $v0, %lo(MEMCARD_DELTAY)($v1)
    /* 38474 80047C74 0580023C */  lui        $v0, %hi(kMemCardMessageH1)
    /* 38478 80047C78 0C000524 */  addiu      $a1, $zero, 0xC
    /* 3847C 80047C7C 082945AC */  sw         $a1, %lo(kMemCardMessageH1)($v0)
    /* 38480 80047C80 0580023C */  lui        $v0, %hi(kMemCardMessageH)
    /* 38484 80047C84 042945AC */  sw         $a1, %lo(kMemCardMessageH)($v0)
    /* 38488 80047C88 0580023C */  lui        $v0, %hi(EXTRAYATTOP)
    /* 3848C 80047C8C 0580033C */  lui        $v1, %hi(GRIDMEMCARD_WIDTH)
    /* 38490 80047C90 0C2945AC */  sw         $a1, %lo(EXTRAYATTOP)($v0)
    /* 38494 80047C94 B1000224 */  addiu      $v0, $zero, 0xB1
    /* 38498 80047C98 102962AC */  sw         $v0, %lo(GRIDMEMCARD_WIDTH)($v1)
    /* 3849C 80047C9C 0580033C */  lui        $v1, %hi(GRIDMEMCARD_HEIGHT)
    /* 384A0 80047CA0 93000224 */  addiu      $v0, $zero, 0x93
    /* 384A4 80047CA4 142962AC */  sw         $v0, %lo(GRIDMEMCARD_HEIGHT)($v1)
    /* 384A8 80047CA8 0580023C */  lui        $v0, %hi(GRIDMEMCARDGOURAUDBIT_X)
    /* 384AC 80047CAC 182945AC */  sw         $a1, %lo(GRIDMEMCARDGOURAUDBIT_X)($v0)
    /* 384B0 80047CB0 0580023C */  lui        $v0, %hi(GRIDMEMCARDGOURAUDBIT_Y)
    /* 384B4 80047CB4 06000524 */  addiu      $a1, $zero, 0x6
    /* 384B8 80047CB8 0580033C */  lui        $v1, %hi(MEMCARDICONOFFX)
    /* 384BC 80047CBC 1C2945AC */  sw         $a1, %lo(GRIDMEMCARDGOURAUDBIT_Y)($v0)
    /* 384C0 80047CC0 0F000224 */  addiu      $v0, $zero, 0xF
    /* 384C4 80047CC4 202962AC */  sw         $v0, %lo(MEMCARDICONOFFX)($v1)
    /* 384C8 80047CC8 0580023C */  lui        $v0, %hi(MEMCARDICONOFFY)
    /* 384CC 80047CCC 0580033C */  lui        $v1, %hi(kMemCardMessage1Y)
    /* 384D0 80047CD0 242945AC */  sw         $a1, %lo(MEMCARDICONOFFY)($v0)
    /* 384D4 80047CD4 33000224 */  addiu      $v0, $zero, 0x33
    /* 384D8 80047CD8 2C2962AC */  sw         $v0, %lo(kMemCardMessage1Y)($v1)
    /* 384DC 80047CDC 0580023C */  lui        $v0, %hi(kMemCardMessageX)
    /* 384E0 80047CE0 50010324 */  addiu      $v1, $zero, 0x150
    /* 384E4 80047CE4 302943AC */  sw         $v1, %lo(kMemCardMessageX)($v0)
    /* 384E8 80047CE8 0580023C */  lui        $v0, %hi(kMemCardMessage1X)
    /* 384EC 80047CEC 282943AC */  sw         $v1, %lo(kMemCardMessage1X)($v0)
    /* 384F0 80047CF0 0580033C */  lui        $v1, %hi(kMemCardMessageY)
    /* 384F4 80047CF4 C6000224 */  addiu      $v0, $zero, 0xC6
    /* 384F8 80047CF8 C0210524 */  addiu      $a1, $zero, 0x21C0
    /* 384FC 80047CFC 21300000 */  addu       $a2, $zero, $zero
    /* 38500 80047D00 1400BFAF */  sw         $ra, 0x14($sp)
    /* 38504 80047D04 980500AE */  sw         $zero, 0x598($s0)
    /* 38508 80047D08 CF94030C */  jal        reservememadr
    /* 3850C 80047D0C 342962AC */   sw        $v0, %lo(kMemCardMessageY)($v1)
    /* 38510 80047D10 0580033C */  lui        $v1, %hi(FEApp)
    /* 38514 80047D14 C014648C */  lw         $a0, %lo(FEApp)($v1)
    /* 38518 80047D18 0580033C */  lui        $v1, %hi(fMemIcon)
    /* 3851C 80047D1C 382962AC */  sw         $v0, %lo(fMemIcon)($v1)
    /* 38520 80047D20 900500AE */  sw         $zero, 0x590($s0)
    /* 38524 80047D24 880500A6 */  sh         $zero, 0x588($s0)
    /* 38528 80047D28 8A0500A6 */  sh         $zero, 0x58A($s0)
    /* 3852C 80047D2C 2D028290 */  lbu        $v0, 0x22D($a0)
    /* 38530 80047D30 87020724 */  addiu      $a3, $zero, 0x287
    /* 38534 80047D34 9C0502A6 */  sh         $v0, 0x59C($s0)
    /* 38538 80047D38 80100200 */  sll        $v0, $v0, 2
    /* 3853C 80047D3C 9C050386 */  lh         $v1, 0x59C($s0)
    /* 38540 80047D40 01004224 */  addiu      $v0, $v0, 0x1
    /* 38544 80047D44 02006010 */  beqz       $v1, .L80047D50
    /* 38548 80047D48 680002AE */   sw        $v0, 0x68($s0)
    /* 3854C 80047D4C 89020724 */  addiu      $a3, $zero, 0x289
  .L80047D50:
    /* 38550 80047D50 21300000 */  addu       $a2, $zero, $zero
    /* 38554 80047D54 0580023C */  lui        $v0, %hi(menuDefs)
    /* 38558 80047D58 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 3855C 80047D5C 80000824 */  addiu      $t0, $zero, 0x80
    /* 38560 80047D60 5430828C */  lw         $v0, 0x3054($a0)
    /* 38564 80047D64 8030838C */  lw         $v1, 0x3080($a0)
    /* 38568 80047D68 21280002 */  addu       $a1, $s0, $zero
    /* 3856C 80047D6C 843087AC */  sw         $a3, 0x3084($a0)
    /* 38570 80047D70 01004234 */  ori        $v0, $v0, 0x1
    /* 38574 80047D74 01006334 */  ori        $v1, $v1, 0x1
    /* 38578 80047D78 543082AC */  sw         $v0, 0x3054($a0)
    /* 3857C 80047D7C 803083AC */  sw         $v1, 0x3080($a0)
  .L80047D80:
    /* 38580 80047D80 21100602 */  addu       $v0, $s0, $a2
    /* 38584 80047D84 500240A0 */  sb         $zero, 0x250($v0)
    /* 38588 80047D88 5F0240A0 */  sb         $zero, 0x25F($v0)
    /* 3858C 80047D8C 6E0240A0 */  sb         $zero, 0x26E($v0)
    /* 38590 80047D90 3205A8A4 */  sh         $t0, 0x532($a1)
    /* 38594 80047D94 1405A0A4 */  sh         $zero, 0x514($a1)
    /* 38598 80047D98 0100C624 */  addiu      $a2, $a2, 0x1
    /* 3859C 80047D9C 0F00C228 */  slti       $v0, $a2, 0xF
    /* 385A0 80047DA0 F7FF4014 */  bnez       $v0, .L80047D80
    /* 385A4 80047DA4 0200A524 */   addiu     $a1, $a1, 0x2
    /* 385A8 80047DA8 21200002 */  addu       $a0, $s0, $zero
    /* 385AC 80047DAC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 385B0 80047DB0 540580AC */  sw         $zero, 0x554($a0)
    /* 385B4 80047DB4 A00580AC */  sw         $zero, 0x5A0($a0)
    /* 385B8 80047DB8 500580AC */  sw         $zero, 0x550($a0)
    /* 385BC 80047DBC 640082AC */  sw         $v0, 0x64($a0)
    /* 385C0 80047DC0 2B98000C */  jal        Initialize__7tScreen
    /* 385C4 80047DC4 940580AC */   sw        $zero, 0x594($a0)
    /* 385C8 80047DC8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 385CC 80047DCC 1000B08F */  lw         $s0, 0x10($sp)
    /* 385D0 80047DD0 0800E003 */  jr         $ra
    /* 385D4 80047DD4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Initialize__14tScreenMemcard
