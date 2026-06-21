.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ActualDrawController__23tScreenControllerConfigiiiii, 0x268

glabel ActualDrawController__23tScreenControllerConfigiiiii
    /* 3437C 80043B7C 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* 34380 80043B80 5400B1AF */  sw         $s1, 0x54($sp)
    /* 34384 80043B84 21888000 */  addu       $s1, $a0, $zero
    /* 34388 80043B88 6000B4AF */  sw         $s4, 0x60($sp)
    /* 3438C 80043B8C 8000B48F */  lw         $s4, 0x80($sp)
    /* 34390 80043B90 2120A000 */  addu       $a0, $a1, $zero
    /* 34394 80043B94 5C00B3AF */  sw         $s3, 0x5C($sp)
    /* 34398 80043B98 2198C000 */  addu       $s3, $a2, $zero
    /* 3439C 80043B9C 6800B6AF */  sw         $s6, 0x68($sp)
    /* 343A0 80043BA0 6C00BFAF */  sw         $ra, 0x6C($sp)
    /* 343A4 80043BA4 6400B5AF */  sw         $s5, 0x64($sp)
    /* 343A8 80043BA8 5800B2AF */  sw         $s2, 0x58($sp)
    /* 343AC 80043BAC 5000B0AF */  sw         $s0, 0x50($sp)
    /* 343B0 80043BB0 96002286 */  lh         $v0, 0x96($s1)
    /* 343B4 80043BB4 8400B58F */  lw         $s5, 0x84($sp)
    /* 343B8 80043BB8 80004010 */  beqz       $v0, .L80043DBC
    /* 343BC 80043BBC 21B0E000 */   addu      $s6, $a3, $zero
    /* 343C0 80043BC0 2800228E */  lw         $v0, 0x28($s1)
    /* 343C4 80043BC4 05008014 */  bnez       $a0, .L80043BDC
    /* 343C8 80043BC8 3400A2AF */   sw        $v0, 0x34($sp)
    /* 343CC 80043BCC 96002686 */  lh         $a2, 0x96($s1)
    /* 343D0 80043BD0 01000224 */  addiu      $v0, $zero, 0x1
    /* 343D4 80043BD4 1F00C214 */  bne        $a2, $v0, .L80043C54
    /* 343D8 80043BD8 00000000 */   nop
  .L80043BDC:
    /* 343DC 80043BDC 00060524 */  addiu      $a1, $zero, 0x600
    /* 343E0 80043BE0 02006012 */  beqz       $s3, .L80043BEC
    /* 343E4 80043BE4 01008424 */   addiu     $a0, $a0, 0x1
    /* 343E8 80043BE8 01060524 */  addiu      $a1, $zero, 0x601
  .L80043BEC:
    /* 343EC 80043BEC 0580033C */  lui        $v1, %hi(D_800520D8)
    /* 343F0 80043BF0 96002286 */  lh         $v0, 0x96($s1)
    /* 343F4 80043BF4 D8207224 */  addiu      $s2, $v1, %lo(D_800520D8)
    /* 343F8 80043BF8 40100200 */  sll        $v0, $v0, 1
    /* 343FC 80043BFC 21105200 */  addu       $v0, $v0, $s2
    /* 34400 80043C00 00004690 */  lbu        $a2, 0x0($v0)
    /* 34404 80043C04 01004790 */  lbu        $a3, 0x1($v0)
    /* 34408 80043C08 2000B027 */  addiu      $s0, $sp, 0x20
    /* 3440C 80043C0C 1000B3AF */  sw         $s3, 0x10($sp)
    /* 34410 80043C10 1400A0AF */  sw         $zero, 0x14($sp)
    /* 34414 80043C14 A23A010C */  jal        ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 34418 80043C18 1800B0AF */   sw        $s0, 0x18($sp)
    /* 3441C 80043C1C 96002386 */  lh         $v1, 0x96($s1)
    /* 34420 80043C20 02000224 */  addiu      $v0, $zero, 0x2
    /* 34424 80043C24 20006214 */  bne        $v1, $v0, .L80043CA8
    /* 34428 80043C28 00000000 */   nop
    /* 3442C 80043C2C 02006012 */  beqz       $s3, .L80043C38
    /* 34430 80043C30 00060524 */   addiu     $a1, $zero, 0x600
    /* 34434 80043C34 01060524 */  addiu      $a1, $zero, 0x601
  .L80043C38:
    /* 34438 80043C38 1000B3AF */  sw         $s3, 0x10($sp)
    /* 3443C 80043C3C 1400A0AF */  sw         $zero, 0x14($sp)
    /* 34440 80043C40 1800B0AF */  sw         $s0, 0x18($sp)
    /* 34444 80043C44 04004692 */  lbu        $a2, 0x4($s2)
    /* 34448 80043C48 05004792 */  lbu        $a3, 0x5($s2)
    /* 3444C 80043C4C 230F0108 */  j          .L80043C8C
    /* 34450 80043C50 21200000 */   addu      $a0, $zero, $zero
  .L80043C54:
    /* 34454 80043C54 02006012 */  beqz       $s3, .L80043C60
    /* 34458 80043C58 00060524 */   addiu     $a1, $zero, 0x600
    /* 3445C 80043C5C 01060524 */  addiu      $a1, $zero, 0x601
  .L80043C60:
    /* 34460 80043C60 01000424 */  addiu      $a0, $zero, 0x1
    /* 34464 80043C64 0580033C */  lui        $v1, %hi(D_800520D8)
    /* 34468 80043C68 D8206324 */  addiu      $v1, $v1, %lo(D_800520D8)
    /* 3446C 80043C6C 04108600 */  sllv       $v0, $a2, $a0
    /* 34470 80043C70 21104300 */  addu       $v0, $v0, $v1
    /* 34474 80043C74 00004690 */  lbu        $a2, 0x0($v0)
    /* 34478 80043C78 01004790 */  lbu        $a3, 0x1($v0)
    /* 3447C 80043C7C 2000A227 */  addiu      $v0, $sp, 0x20
    /* 34480 80043C80 1000B3AF */  sw         $s3, 0x10($sp)
    /* 34484 80043C84 1400A0AF */  sw         $zero, 0x14($sp)
    /* 34488 80043C88 1800A2AF */  sw         $v0, 0x18($sp)
  .L80043C8C:
    /* 3448C 80043C8C 2130D400 */  addu       $a2, $a2, $s4
    /* 34490 80043C90 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 34494 80043C94 2138F500 */   addu      $a3, $a3, $s5
    /* 34498 80043C98 96002386 */  lh         $v1, 0x96($s1)
    /* 3449C 80043C9C 02000224 */  addiu      $v0, $zero, 0x2
    /* 344A0 80043CA0 0E006210 */  beq        $v1, $v0, .L80043CDC
    /* 344A4 80043CA4 C800043C */   lui       $a0, (0xC8C8C8 >> 16)
  .L80043CA8:
    /* 344A8 80043CA8 0200C012 */  beqz       $s6, .L80043CB4
    /* 344AC 80043CAC 00020524 */   addiu     $a1, $zero, 0x200
    /* 344B0 80043CB0 01020524 */  addiu      $a1, $zero, 0x201
  .L80043CB4:
    /* 344B4 80043CB4 21200000 */  addu       $a0, $zero, $zero
    /* 344B8 80043CB8 21308000 */  addu       $a2, $a0, $zero
    /* 344BC 80043CBC 21388000 */  addu       $a3, $a0, $zero
    /* 344C0 80043CC0 2000A227 */  addiu      $v0, $sp, 0x20
    /* 344C4 80043CC4 1000B6AF */  sw         $s6, 0x10($sp)
    /* 344C8 80043CC8 1400A0AF */  sw         $zero, 0x14($sp)
    /* 344CC 80043CCC 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 344D0 80043CD0 1800A2AF */   sw        $v0, 0x18($sp)
    /* 344D4 80043CD4 6F0F0108 */  j          .L80043DBC
    /* 344D8 80043CD8 00000000 */   nop
  .L80043CDC:
    /* 344DC 80043CDC C8C88434 */  ori        $a0, $a0, (0xC8C8C8 & 0xFFFF)
    /* 344E0 80043CE0 A8002586 */  lh         $a1, 0xA8($s1)
    /* 344E4 80043CE4 222E010C */  jal        CalcFadeVal__Fii
    /* 344E8 80043CE8 30001224 */   addiu     $s2, $zero, 0x30
    /* 344EC 80043CEC 1A000424 */  addiu      $a0, $zero, 0x1A
    /* 344F0 80043CF0 18000524 */  addiu      $a1, $zero, 0x18
    /* 344F4 80043CF4 9E000624 */  addiu      $a2, $zero, 0x9E
    /* 344F8 80043CF8 92000724 */  addiu      $a3, $zero, 0x92
    /* 344FC 80043CFC 01001124 */  addiu      $s1, $zero, 0x1
    /* 34500 80043D00 3800B027 */  addiu      $s0, $sp, 0x38
    /* 34504 80043D04 3C00A2AF */  sw         $v0, 0x3C($sp)
    /* 34508 80043D08 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3450C 80043D0C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 34510 80043D10 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 34514 80043D14 1800B0AF */   sw        $s0, 0x18($sp)
    /* 34518 80043D18 1B000424 */  addiu      $a0, $zero, 0x1B
    /* 3451C 80043D1C 18000524 */  addiu      $a1, $zero, 0x18
    /* 34520 80043D20 9E000624 */  addiu      $a2, $zero, 0x9E
    /* 34524 80043D24 A1000724 */  addiu      $a3, $zero, 0xA1
    /* 34528 80043D28 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3452C 80043D2C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 34530 80043D30 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 34534 80043D34 1800B0AF */   sw        $s0, 0x18($sp)
    /* 34538 80043D38 1C000424 */  addiu      $a0, $zero, 0x1C
    /* 3453C 80043D3C 18000524 */  addiu      $a1, $zero, 0x18
    /* 34540 80043D40 9E000624 */  addiu      $a2, $zero, 0x9E
    /* 34544 80043D44 AC000724 */  addiu      $a3, $zero, 0xAC
    /* 34548 80043D48 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3454C 80043D4C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 34550 80043D50 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 34554 80043D54 1800B0AF */   sw        $s0, 0x18($sp)
    /* 34558 80043D58 1D000424 */  addiu      $a0, $zero, 0x1D
    /* 3455C 80043D5C 18000524 */  addiu      $a1, $zero, 0x18
    /* 34560 80043D60 9E000624 */  addiu      $a2, $zero, 0x9E
    /* 34564 80043D64 BB000724 */  addiu      $a3, $zero, 0xBB
    /* 34568 80043D68 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3456C 80043D6C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 34570 80043D70 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 34574 80043D74 1800B0AF */   sw        $s0, 0x18($sp)
    /* 34578 80043D78 0580023C */  lui        $v0, %hi(ArrowLocations)
    /* 3457C 80043D7C 04214224 */  addiu      $v0, $v0, %lo(ArrowLocations)
    /* 34580 80043D80 40025024 */  addiu      $s0, $v0, 0x240
    /* 34584 80043D84 05000724 */  addiu      $a3, $zero, 0x5
  .L80043D88:
    /* 34588 80043D88 04000586 */  lh         $a1, 0x4($s0)
    /* 3458C 80043D8C 06000686 */  lh         $a2, 0x6($s0)
    /* 34590 80043D90 0C001026 */  addiu      $s0, $s0, 0xC
    /* 34594 80043D94 01005226 */  addiu      $s2, $s2, 0x1
    /* 34598 80043D98 03000224 */  addiu      $v0, $zero, 0x3
    /* 3459C 80043D9C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 345A0 80043DA0 3C00A48F */  lw         $a0, 0x3C($sp)
    /* 345A4 80043DA4 FEFFA524 */  addiu      $a1, $a1, -0x2
    /* 345A8 80043DA8 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 345AC 80043DAC FEFFC624 */   addiu     $a2, $a2, -0x2
    /* 345B0 80043DB0 3600422A */  slti       $v0, $s2, 0x36
    /* 345B4 80043DB4 F4FF4014 */  bnez       $v0, .L80043D88
    /* 345B8 80043DB8 05000724 */   addiu     $a3, $zero, 0x5
  .L80043DBC:
    /* 345BC 80043DBC 6C00BF8F */  lw         $ra, 0x6C($sp)
    /* 345C0 80043DC0 6800B68F */  lw         $s6, 0x68($sp)
    /* 345C4 80043DC4 6400B58F */  lw         $s5, 0x64($sp)
    /* 345C8 80043DC8 6000B48F */  lw         $s4, 0x60($sp)
    /* 345CC 80043DCC 5C00B38F */  lw         $s3, 0x5C($sp)
    /* 345D0 80043DD0 5800B28F */  lw         $s2, 0x58($sp)
    /* 345D4 80043DD4 5400B18F */  lw         $s1, 0x54($sp)
    /* 345D8 80043DD8 5000B08F */  lw         $s0, 0x50($sp)
    /* 345DC 80043DDC 0800E003 */  jr         $ra
    /* 345E0 80043DE0 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel ActualDrawController__23tScreenControllerConfigiiiii
