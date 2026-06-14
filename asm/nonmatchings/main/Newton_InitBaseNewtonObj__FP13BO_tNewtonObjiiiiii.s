.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii, 0x280

glabel Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii
    /* 923E8 800A1BE8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 923EC 800A1BEC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 923F0 800A1BF0 3800B18F */  lw         $s1, 0x38($sp)
    /* 923F4 800A1BF4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 923F8 800A1BF8 3C00B28F */  lw         $s2, 0x3C($sp)
    /* 923FC 800A1BFC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 92400 800A1C00 21808000 */  addu       $s0, $a0, $zero
    /* 92404 800A1C04 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 92408 800A1C08 4000B38F */  lw         $s3, 0x40($sp)
    /* 9240C 800A1C0C 1180023C */  lui        $v0, %hi(D_80113224)
    /* 92410 800A1C10 2400BFAF */  sw         $ra, 0x24($sp)
    /* 92414 800A1C14 2000B4AF */  sw         $s4, 0x20($sp)
    /* 92418 800A1C18 000005AE */  sw         $a1, 0x0($s0)
    /* 9241C 800A1C1C 880000AE */  sw         $zero, 0x88($s0)
    /* 92420 800A1C20 900000A2 */  sb         $zero, 0x90($s0)
    /* 92424 800A1C24 A00000AE */  sw         $zero, 0xA0($s0)
    /* 92428 800A1C28 A40000AE */  sw         $zero, 0xA4($s0)
    /* 9242C 800A1C2C A80000AE */  sw         $zero, 0xA8($s0)
    /* 92430 800A1C30 AC0000AE */  sw         $zero, 0xAC($s0)
    /* 92434 800A1C34 B00000AE */  sw         $zero, 0xB0($s0)
    /* 92438 800A1C38 B40000AE */  sw         $zero, 0xB4($s0)
    /* 9243C 800A1C3C B80006AE */  sw         $a2, 0xB8($s0)
    /* 92440 800A1C40 2432428C */  lw         $v0, %lo(D_80113224)($v0)
    /* 92444 800A1C44 00000000 */  nop
    /* 92448 800A1C48 02004230 */  andi       $v0, $v0, 0x2
    /* 9244C 800A1C4C 08004010 */  beqz       $v0, .L800A1C70
    /* 92450 800A1C50 00000000 */   nop
    /* 92454 800A1C54 6002028E */  lw         $v0, 0x260($s0)
    /* 92458 800A1C58 00000000 */  nop
    /* 9245C 800A1C5C 04004230 */  andi       $v0, $v0, 0x4
    /* 92460 800A1C60 03004010 */  beqz       $v0, .L800A1C70
    /* 92464 800A1C64 80100600 */   sll       $v0, $a2, 2
    /* 92468 800A1C68 21104600 */  addu       $v0, $v0, $a2
    /* 9246C 800A1C6C B80002AE */  sw         $v0, 0xB8($s0)
  .L800A1C70:
    /* 92470 800A1C70 6002028E */  lw         $v0, 0x260($s0)
    /* 92474 800A1C74 00000000 */  nop
    /* 92478 800A1C78 20004230 */  andi       $v0, $v0, 0x20
    /* 9247C 800A1C7C 24004010 */  beqz       $v0, .L800A1D10
    /* 92480 800A1C80 1180023C */   lui       $v0, %hi(D_801131F8)
    /* 92484 800A1C84 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 92488 800A1C88 01000224 */  addiu      $v0, $zero, 0x1
    /* 9248C 800A1C8C 18006214 */  bne        $v1, $v0, .L800A1CF0
    /* 92490 800A1C90 1180033C */   lui       $v1, %hi(Cars_gHumanRaceCarList)
    /* 92494 800A1C94 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 92498 800A1C98 00000000 */  nop
    /* 9249C 800A1C9C 8802428C */  lw         $v0, 0x288($v0)
    /* 924A0 800A1CA0 00000000 */  nop
    /* 924A4 800A1CA4 0000428C */  lw         $v0, 0x0($v0)
    /* 924A8 800A1CA8 00000000 */  nop
    /* 924AC 800A1CAC 16004228 */  slti       $v0, $v0, 0x16
    /* 924B0 800A1CB0 0A004014 */  bnez       $v0, .L800A1CDC
    /* 924B4 800A1CB4 48FA6324 */   addiu     $v1, $v1, %lo(Cars_gHumanRaceCarList)
    /* 924B8 800A1CB8 0400628C */  lw         $v0, 0x4($v1)
    /* 924BC 800A1CBC 00000000 */  nop
    /* 924C0 800A1CC0 8802428C */  lw         $v0, 0x288($v0)
    /* 924C4 800A1CC4 00000000 */  nop
    /* 924C8 800A1CC8 0000428C */  lw         $v0, 0x0($v0)
    /* 924CC 800A1CCC 00000000 */  nop
    /* 924D0 800A1CD0 16004228 */  slti       $v0, $v0, 0x16
    /* 924D4 800A1CD4 06004010 */  beqz       $v0, .L800A1CF0
    /* 924D8 800A1CD8 00000000 */   nop
  .L800A1CDC:
    /* 924DC 800A1CDC B800028E */  lw         $v0, 0xB8($s0)
    /* 924E0 800A1CE0 00000000 */  nop
    /* 924E4 800A1CE4 40100200 */  sll        $v0, $v0, 1
    /* 924E8 800A1CE8 44870208 */  j          .L800A1D10
    /* 924EC 800A1CEC B80002AE */   sw        $v0, 0xB8($s0)
  .L800A1CF0:
    /* 924F0 800A1CF0 B800028E */  lw         $v0, 0xB8($s0)
    /* 924F4 800A1CF4 00000000 */  nop
    /* 924F8 800A1CF8 40180200 */  sll        $v1, $v0, 1
    /* 924FC 800A1CFC 21186200 */  addu       $v1, $v1, $v0
    /* 92500 800A1D00 C2170300 */  srl        $v0, $v1, 31
    /* 92504 800A1D04 21186200 */  addu       $v1, $v1, $v0
    /* 92508 800A1D08 43180300 */  sra        $v1, $v1, 1
    /* 9250C 800A1D0C B80003AE */  sw         $v1, 0xB8($s0)
  .L800A1D10:
    /* 92510 800A1D10 B800058E */  lw         $a1, 0xB8($s0)
    /* 92514 800A1D14 0191030C */  jal        rdiv
    /* 92518 800A1D18 0100043C */   lui       $a0, (0x10000 >> 16)
    /* 9251C 800A1D1C B800058E */  lw         $a1, 0xB8($s0)
    /* 92520 800A1D20 0100043C */  lui        $a0, (0x10000 >> 16)
    /* 92524 800A1D24 BC0002AE */  sw         $v0, 0xBC($s0)
    /* 92528 800A1D28 C0280500 */  sll        $a1, $a1, 3
    /* 9252C 800A1D2C 0191030C */  jal        rdiv
    /* 92530 800A1D30 200105AE */   sw        $a1, 0x120($s0)
    /* 92534 800A1D34 21182002 */  addu       $v1, $s1, $zero
    /* 92538 800A1D38 0100143C */  lui        $s4, (0x10000 >> 16)
    /* 9253C 800A1D3C 240102AE */  sw         $v0, 0x124($s0)
    /* 92540 800A1D40 140100AE */  sw         $zero, 0x114($s0)
    /* 92544 800A1D44 180100AE */  sw         $zero, 0x118($s0)
    /* 92548 800A1D48 1C0100AE */  sw         $zero, 0x11C($s0)
    /* 9254C 800A1D4C 280100AE */  sw         $zero, 0x128($s0)
    /* 92550 800A1D50 2C0114AE */  sw         $s4, 0x12C($s0)
    /* 92554 800A1D54 300100AE */  sw         $zero, 0x130($s0)
    /* 92558 800A1D58 340111AE */  sw         $s1, 0x134($s0)
    /* 9255C 800A1D5C 380112AE */  sw         $s2, 0x138($s0)
    /* 92560 800A1D60 02002106 */  bgez       $s1, .L800A1D6C
    /* 92564 800A1D64 3C0113AE */   sw        $s3, 0x13C($s0)
    /* 92568 800A1D68 FF002326 */  addiu      $v1, $s1, 0xFF
  .L800A1D6C:
    /* 9256C 800A1D6C 03220300 */  sra        $a0, $v1, 8
    /* 92570 800A1D70 18008400 */  mult       $a0, $a0
    /* 92574 800A1D74 12180000 */  mflo       $v1
    /* 92578 800A1D78 02004106 */  bgez       $s2, .L800A1D84
    /* 9257C 800A1D7C 21104002 */   addu      $v0, $s2, $zero
    /* 92580 800A1D80 FF004226 */  addiu      $v0, $s2, 0xFF
  .L800A1D84:
    /* 92584 800A1D84 03120200 */  sra        $v0, $v0, 8
    /* 92588 800A1D88 18004200 */  mult       $v0, $v0
    /* 9258C 800A1D8C 12380000 */  mflo       $a3
    /* 92590 800A1D90 2BAC030C */  jal        fixedsqrt
    /* 92594 800A1D94 21206700 */   addu      $a0, $v1, $a3
    /* 92598 800A1D98 400102AE */  sw         $v0, 0x140($s0)
    /* 9259C 800A1D9C 02004104 */  bgez       $v0, .L800A1DA8
    /* 925A0 800A1DA0 21184000 */   addu      $v1, $v0, $zero
    /* 925A4 800A1DA4 FF004324 */  addiu      $v1, $v0, 0xFF
  .L800A1DA8:
    /* 925A8 800A1DA8 03220300 */  sra        $a0, $v1, 8
    /* 925AC 800A1DAC 18008400 */  mult       $a0, $a0
    /* 925B0 800A1DB0 12180000 */  mflo       $v1
    /* 925B4 800A1DB4 02006106 */  bgez       $s3, .L800A1DC0
    /* 925B8 800A1DB8 21106002 */   addu      $v0, $s3, $zero
    /* 925BC 800A1DBC FF006226 */  addiu      $v0, $s3, 0xFF
  .L800A1DC0:
    /* 925C0 800A1DC0 03120200 */  sra        $v0, $v0, 8
    /* 925C4 800A1DC4 18004200 */  mult       $v0, $v0
    /* 925C8 800A1DC8 12380000 */  mflo       $a3
    /* 925CC 800A1DCC 2BAC030C */  jal        fixedsqrt
    /* 925D0 800A1DD0 21206700 */   addu      $a0, $v1, $a3
    /* 925D4 800A1DD4 09000424 */  addiu      $a0, $zero, 0x9
    /* 925D8 800A1DD8 24000326 */  addiu      $v1, $s0, 0x24
    /* 925DC 800A1DDC 400102AE */  sw         $v0, 0x140($s0)
    /* 925E0 800A1DE0 01000224 */  addiu      $v0, $zero, 0x1
    /* 925E4 800A1DE4 7C0100A6 */  sh         $zero, 0x17C($s0)
    /* 925E8 800A1DE8 BC0102AE */  sw         $v0, 0x1BC($s0)
    /* 925EC 800A1DEC C00102AE */  sw         $v0, 0x1C0($s0)
    /* 925F0 800A1DF0 840100AE */  sw         $zero, 0x184($s0)
    /* 925F4 800A1DF4 880100AE */  sw         $zero, 0x188($s0)
    /* 925F8 800A1DF8 940014AE */  sw         $s4, 0x94($s0)
    /* 925FC 800A1DFC C40000AE */  sw         $zero, 0xC4($s0)
    /* 92600 800A1E00 740100AE */  sw         $zero, 0x174($s0)
    /* 92604 800A1E04 8C0100AE */  sw         $zero, 0x18C($s0)
    /* 92608 800A1E08 900100AE */  sw         $zero, 0x190($s0)
    /* 9260C 800A1E0C 940100AE */  sw         $zero, 0x194($s0)
    /* 92610 800A1E10 980100AE */  sw         $zero, 0x198($s0)
    /* 92614 800A1E14 9C0100AE */  sw         $zero, 0x19C($s0)
    /* 92618 800A1E18 B00100AE */  sw         $zero, 0x1B0($s0)
    /* 9261C 800A1E1C B40100AE */  sw         $zero, 0x1B4($s0)
    /* 92620 800A1E20 B80100AE */  sw         $zero, 0x1B8($s0)
  .L800A1E24:
    /* 92624 800A1E24 180260AC */  sw         $zero, 0x218($v1)
    /* 92628 800A1E28 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* 9262C 800A1E2C FDFF8104 */  bgez       $a0, .L800A1E24
    /* 92630 800A1E30 FCFF6324 */   addiu     $v1, $v1, -0x4
    /* 92634 800A1E34 01000224 */  addiu      $v0, $zero, 0x1
    /* 92638 800A1E38 920000A2 */  sb         $zero, 0x92($s0)
    /* 9263C 800A1E3C 7E0100A6 */  sh         $zero, 0x17E($s0)
    /* 92640 800A1E40 910002A2 */  sb         $v0, 0x91($s0)
    /* 92644 800A1E44 980000AE */  sw         $zero, 0x98($s0)
    /* 92648 800A1E48 2400BF8F */  lw         $ra, 0x24($sp)
    /* 9264C 800A1E4C 2000B48F */  lw         $s4, 0x20($sp)
    /* 92650 800A1E50 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 92654 800A1E54 1800B28F */  lw         $s2, 0x18($sp)
    /* 92658 800A1E58 1400B18F */  lw         $s1, 0x14($sp)
    /* 9265C 800A1E5C 1000B08F */  lw         $s0, 0x10($sp)
    /* 92660 800A1E60 0800E003 */  jr         $ra
    /* 92664 800A1E64 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii
