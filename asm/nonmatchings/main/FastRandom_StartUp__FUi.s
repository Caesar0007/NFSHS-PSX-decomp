.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FastRandom_StartUp__FUi, 0x88

glabel FastRandom_StartUp__FUi
    /* 8BBD0 8009B3D0 6210023C */  lui        $v0, (0x10624DD3 >> 16)
    /* 8BBD4 8009B3D4 D34D4234 */  ori        $v0, $v0, (0x10624DD3 & 0xFFFF)
    /* 8BBD8 8009B3D8 19008200 */  multu      $a0, $v0
    /* 8BBDC 8009B3DC 5B07033C */  lui        $v1, (0x75BCD15 >> 16)
    /* 8BBE0 8009B3E0 15CD6334 */  ori        $v1, $v1, (0x75BCD15 & 0xFFFF)
    /* 8BBE4 8009B3E4 DE3A023C */  lui        $v0, (0x3ADE68B1 >> 16)
    /* 8BBE8 8009B3E8 B1684234 */  ori        $v0, $v0, (0x3ADE68B1 & 0xFFFF)
    /* 8BBEC 8009B3EC B80B83AF */  sw         $v1, %gp_rel(randSeed)($gp)
    /* 8BBF0 8009B3F0 B00B82AF */  sw         $v0, %gp_rel(fastRandom)($gp)
    /* 8BBF4 8009B3F4 10300000 */  mfhi       $a2
    /* 8BBF8 8009B3F8 42190600 */  srl        $v1, $a2, 5
    /* 8BBFC 8009B3FC 40110300 */  sll        $v0, $v1, 5
    /* 8BC00 8009B400 23104300 */  subu       $v0, $v0, $v1
    /* 8BC04 8009B404 80100200 */  sll        $v0, $v0, 2
    /* 8BC08 8009B408 21104300 */  addu       $v0, $v0, $v1
    /* 8BC0C 8009B40C 80100200 */  sll        $v0, $v0, 2
    /* 8BC10 8009B410 23188200 */  subu       $v1, $a0, $v0
    /* 8BC14 8009B414 0E006018 */  blez       $v1, .L8009B450
    /* 8BC18 8009B418 21280000 */   addu      $a1, $zero, $zero
    /* 8BC1C 8009B41C 5B07043C */  lui        $a0, (0x75BCD15 >> 16)
    /* 8BC20 8009B420 15CD8434 */  ori        $a0, $a0, (0x75BCD15 & 0xFFFF)
  .L8009B424:
    /* 8BC24 8009B424 B00B828F */  lw         $v0, %gp_rel(fastRandom)($gp)
    /* 8BC28 8009B428 00000000 */  nop
    /* 8BC2C 8009B42C 18004400 */  mult       $v0, $a0
    /* 8BC30 8009B430 0100A524 */  addiu      $a1, $a1, 0x1
    /* 8BC34 8009B434 12100000 */  mflo       $v0
    /* 8BC38 8009B438 B40B82AF */  sw         $v0, %gp_rel(randtemp)($gp)
    /* 8BC3C 8009B43C FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 8BC40 8009B440 B00B82AF */  sw         $v0, %gp_rel(fastRandom)($gp)
    /* 8BC44 8009B444 2A10A300 */  slt        $v0, $a1, $v1
    /* 8BC48 8009B448 F6FF4014 */  bnez       $v0, .L8009B424
    /* 8BC4C 8009B44C 00000000 */   nop
  .L8009B450:
    /* 8BC50 8009B450 0800E003 */  jr         $ra
    /* 8BC54 8009B454 00000000 */   nop
endlabel FastRandom_StartUp__FUi
