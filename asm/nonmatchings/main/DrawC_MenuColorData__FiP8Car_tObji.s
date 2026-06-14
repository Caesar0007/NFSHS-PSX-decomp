.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_MenuColorData__FiP8Car_tObji, 0x220

glabel DrawC_MenuColorData__FiP8Car_tObji
    /* AF324 800BEB24 60FFBD27 */  addiu      $sp, $sp, -0xA0
    /* AF328 800BEB28 9000B2AF */  sw         $s2, 0x90($sp)
    /* AF32C 800BEB2C 21908000 */  addu       $s2, $a0, $zero
    /* AF330 800BEB30 8C00B1AF */  sw         $s1, 0x8C($sp)
    /* AF334 800BEB34 2188A000 */  addu       $s1, $a1, $zero
    /* AF338 800BEB38 9400B3AF */  sw         $s3, 0x94($sp)
    /* AF33C 800BEB3C 9800BFAF */  sw         $ra, 0x98($sp)
    /* AF340 800BEB40 8800B0AF */  sw         $s0, 0x88($sp)
    /* AF344 800BEB44 8802248E */  lw         $a0, 0x288($s1)
    /* AF348 800BEB48 D808228E */  lw         $v0, 0x8D8($s1)
    /* AF34C 800BEB4C 0000838C */  lw         $v1, 0x0($a0)
    /* AF350 800BEB50 74004014 */  bnez       $v0, .L800BED24
    /* AF354 800BEB54 2198C000 */   addu      $s3, $a2, $zero
    /* AF358 800BEB58 BC082286 */  lh         $v0, 0x8BC($s1)
    /* AF35C 800BEB5C 00000000 */  nop
    /* AF360 800BEB60 71004314 */  bne        $v0, $v1, .L800BED28
    /* AF364 800BEB64 00000000 */   nop
    /* AF368 800BEB68 40008290 */  lbu        $v0, 0x40($a0)
    /* AF36C 800BEB6C 3C008390 */  lbu        $v1, 0x3C($a0)
    /* AF370 800BEB70 44008490 */  lbu        $a0, 0x44($a0)
    /* AF374 800BEB74 40100200 */  sll        $v0, $v0, 1
    /* AF378 800BEB78 21186200 */  addu       $v1, $v1, $v0
    /* AF37C 800BEB7C 80200400 */  sll        $a0, $a0, 2
    /* AF380 800BEB80 BC082296 */  lhu        $v0, 0x8BC($s1)
    /* AF384 800BEB84 21186400 */  addu       $v1, $v1, $a0
    /* AF388 800BEB88 F0FF4224 */  addiu      $v0, $v0, -0x10
    /* AF38C 800BEB8C 0300422C */  sltiu      $v0, $v0, 0x3
    /* AF390 800BEB90 03004010 */  beqz       $v0, .L800BEBA0
    /* AF394 800BEB94 B30823A2 */   sb        $v1, 0x8B3($s1)
    /* AF398 800BEB98 07000224 */  addiu      $v0, $zero, 0x7
    /* AF39C 800BEB9C B30822A2 */  sb         $v0, 0x8B3($s1)
  .L800BEBA0:
    /* AF3A0 800BEBA0 80281300 */  sll        $a1, $s3, 2
    /* AF3A4 800BEBA4 1480023C */  lui        $v0, %hi(DrawC_gMenuColor)
    /* AF3A8 800BEBA8 00D84224 */  addiu      $v0, $v0, %lo(DrawC_gMenuColor)
    /* AF3AC 800BEBAC 2128A200 */  addu       $a1, $a1, $v0
    /* AF3B0 800BEBB0 B3082392 */  lbu        $v1, 0x8B3($s1)
    /* AF3B4 800BEBB4 0000A28C */  lw         $v0, 0x0($a1)
    /* AF3B8 800BEBB8 01006430 */  andi       $a0, $v1, 0x1
    /* AF3BC 800BEBBC 00220400 */  sll        $a0, $a0, 8
    /* AF3C0 800BEBC0 21204402 */  addu       $a0, $s2, $a0
    /* AF3C4 800BEBC4 02006330 */  andi       $v1, $v1, 0x2
    /* AF3C8 800BEBC8 001A0300 */  sll        $v1, $v1, 8
    /* AF3CC 800BEBCC 21188300 */  addu       $v1, $a0, $v1
    /* AF3D0 800BEBD0 55004310 */  beq        $v0, $v1, .L800BED28
    /* AF3D4 800BEBD4 21200000 */   addu      $a0, $zero, $zero
    /* AF3D8 800BEBD8 1FB6030C */  jal        DrawSync
    /* AF3DC 800BEBDC 0000A3AC */   sw        $v1, 0x0($a1)
    /* AF3E0 800BEBE0 BC082586 */  lh         $a1, 0x8BC($s1)
    /* AF3E4 800BEBE4 00000000 */  nop
    /* AF3E8 800BEBE8 1C00A228 */  slti       $v0, $a1, 0x1C
    /* AF3EC 800BEBEC 45004010 */  beqz       $v0, .L800BED04
    /* AF3F0 800BEBF0 08004332 */   andi      $v1, $s2, 0x8
    /* AF3F4 800BEBF4 40082296 */  lhu        $v0, 0x840($s1)
    /* AF3F8 800BEBF8 00000000 */  nop
    /* AF3FC 800BEBFC 08004230 */  andi       $v0, $v0, 0x8
    /* AF400 800BEC00 2A006210 */  beq        $v1, $v0, .L800BECAC
    /* AF404 800BEC04 00000000 */   nop
    /* AF408 800BEC08 8802228E */  lw         $v0, 0x288($s1)
    /* AF40C 800BEC0C 00000000 */  nop
    /* AF410 800BEC10 A000468C */  lw         $a2, 0xA0($v0)
    /* AF414 800BEC14 A6BB020C */  jal        R3DCar_GetCarName__FPcii
    /* AF418 800BEC18 1000A427 */   addiu     $a0, $sp, 0x10
    /* AF41C 800BEC1C 0800422A */  slti       $v0, $s2, 0x8
    /* AF420 800BEC20 05004014 */  bnez       $v0, .L800BEC38
    /* AF424 800BEC24 00000000 */   nop
    /* AF428 800BEC28 1000A427 */  addiu      $a0, $sp, 0x10
    /* AF42C 800BEC2C 1480053C */  lui        $a1, %hi(D_8013D7E0)
    /* AF430 800BEC30 11FB0208 */  j          .L800BEC44
    /* AF434 800BEC34 E0D7A524 */   addiu     $a1, $a1, %lo(D_8013D7E0)
  .L800BEC38:
    /* AF438 800BEC38 1000A427 */  addiu      $a0, $sp, 0x10
    /* AF43C 800BEC3C 1480053C */  lui        $a1, %hi(D_8013D7E4)
    /* AF440 800BEC40 E4D7A524 */  addiu      $a1, $a1, %lo(D_8013D7E4)
  .L800BEC44:
    /* AF444 800BEC44 3A9E030C */  jal        strcat
    /* AF448 800BEC48 00000000 */   nop
    /* AF44C 800BEC4C 1180023C */  lui        $v0, %hi(D_801164C8)
    /* AF450 800BEC50 C864458C */  lw         $a1, %lo(D_801164C8)($v0)
    /* AF454 800BEC54 2000B027 */  addiu      $s0, $sp, 0x20
    /* AF458 800BEC58 CA96030C */  jal        strcpy
    /* AF45C 800BEC5C 21200002 */   addu      $a0, $s0, $zero
    /* AF460 800BEC60 21200002 */  addu       $a0, $s0, $zero
    /* AF464 800BEC64 3A9E030C */  jal        strcat
    /* AF468 800BEC68 1000A527 */   addiu     $a1, $sp, 0x10
    /* AF46C 800BEC6C 21200002 */  addu       $a0, $s0, $zero
    /* AF470 800BEC70 1480053C */  lui        $a1, %hi(D_8013D7E8)
    /* AF474 800BEC74 3A9E030C */  jal        strcat
    /* AF478 800BEC78 E8D7A524 */   addiu     $a1, $a1, %lo(D_8013D7E8)
    /* AF47C 800BEC7C 21200002 */  addu       $a0, $s0, $zero
    /* AF480 800BEC80 FA95030C */  jal        loadfileadr
    /* AF484 800BEC84 10000524 */   addiu     $a1, $zero, 0x10
    /* AF488 800BEC88 21804000 */  addu       $s0, $v0, $zero
    /* AF48C 800BEC8C 21200002 */  addu       $a0, $s0, $zero
    /* AF490 800BEC90 21282002 */  addu       $a1, $s1, $zero
    /* AF494 800BEC94 ACF3020C */  jal        CarIO_UpdateCarTextureData__FPcP8Car_tObji
    /* AF498 800BEC98 21306002 */   addu      $a2, $s3, $zero
    /* AF49C 800BEC9C 5095030C */  jal        purgememadr
    /* AF4A0 800BECA0 21200002 */   addu      $a0, $s0, $zero
    /* AF4A4 800BECA4 1FB6030C */  jal        DrawSync
    /* AF4A8 800BECA8 21200000 */   addu      $a0, $zero, $zero
  .L800BECAC:
    /* AF4AC 800BECAC 21280000 */  addu       $a1, $zero, $zero
    /* AF4B0 800BECB0 07005032 */  andi       $s0, $s2, 0x7
    /* AF4B4 800BECB4 B3082292 */  lbu        $v0, 0x8B3($s1)
    /* AF4B8 800BECB8 8408248E */  lw         $a0, 0x884($s1)
    /* AF4BC 800BECBC 02004230 */  andi       $v0, $v0, 0x2
    /* AF4C0 800BECC0 80100200 */  sll        $v0, $v0, 2
    /* AF4C4 800BECC4 21100202 */  addu       $v0, $s0, $v0
    /* AF4C8 800BECC8 1480013C */  lui        $at, %hi(Texture_CarColor)
    /* AF4CC 800BECCC 08DB22AC */  sw         $v0, %lo(Texture_CarColor)($at)
    /* AF4D0 800BECD0 A77E030C */  jal        Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
    /* AF4D4 800BECD4 01000624 */   addiu     $a2, $zero, 0x1
    /* AF4D8 800BECD8 01000524 */  addiu      $a1, $zero, 0x1
    /* AF4DC 800BECDC 8408248E */  lw         $a0, 0x884($s1)
    /* AF4E0 800BECE0 B3082292 */  lbu        $v0, 0x8B3($s1)
    /* AF4E4 800BECE4 88082686 */  lh         $a2, 0x888($s1)
    /* AF4E8 800BECE8 24104500 */  and        $v0, $v0, $a1
    /* AF4EC 800BECEC C0100200 */  sll        $v0, $v0, 3
    /* AF4F0 800BECF0 21800202 */  addu       $s0, $s0, $v0
    /* AF4F4 800BECF4 1480013C */  lui        $at, %hi(Texture_CarColor)
    /* AF4F8 800BECF8 08DB30AC */  sw         $s0, %lo(Texture_CarColor)($at)
    /* AF4FC 800BECFC 47FB0208 */  j          .L800BED1C
    /* AF500 800BED00 00000000 */   nop
  .L800BED04:
    /* AF504 800BED04 21280000 */  addu       $a1, $zero, $zero
    /* AF508 800BED08 8408248E */  lw         $a0, 0x884($s1)
    /* AF50C 800BED0C 88082686 */  lh         $a2, 0x888($s1)
    /* AF510 800BED10 07004232 */  andi       $v0, $s2, 0x7
    /* AF514 800BED14 1480013C */  lui        $at, %hi(Texture_CarColor)
    /* AF518 800BED18 08DB22AC */  sw         $v0, %lo(Texture_CarColor)($at)
  .L800BED1C:
    /* AF51C 800BED1C A77E030C */  jal        Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
    /* AF520 800BED20 00000000 */   nop
  .L800BED24:
    /* AF524 800BED24 400832A6 */  sh         $s2, 0x840($s1)
  .L800BED28:
    /* AF528 800BED28 9800BF8F */  lw         $ra, 0x98($sp)
    /* AF52C 800BED2C 9400B38F */  lw         $s3, 0x94($sp)
    /* AF530 800BED30 9000B28F */  lw         $s2, 0x90($sp)
    /* AF534 800BED34 8C00B18F */  lw         $s1, 0x8C($sp)
    /* AF538 800BED38 8800B08F */  lw         $s0, 0x88($sp)
    /* AF53C 800BED3C 0800E003 */  jr         $ra
    /* AF540 800BED40 A000BD27 */   addiu     $sp, $sp, 0xA0
endlabel DrawC_MenuColorData__FiP8Car_tObji
