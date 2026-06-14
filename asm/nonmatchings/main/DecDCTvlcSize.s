.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching DecDCTvlcSize, 0x30

glabel DecDCTvlcSize
    /* E7C00 800F7400 1380083C */  lui        $t0, %hi(D_801369E8)
    /* E7C04 800F7404 E8690825 */  addiu      $t0, $t0, %lo(D_801369E8)
    /* E7C08 800F7408 FFFF8120 */  addi       $at, $a0, -0x1 /* handwritten instruction */
    /* E7C0C 800F740C 04002018 */  blez       $at, .L800F7420
    /* E7C10 800F7410 0000028D */   lw        $v0, 0x0($t0)
    /* E7C14 800F7414 40080400 */  sll        $at, $a0, 1
    /* E7C18 800F7418 0800E003 */  jr         $ra
    /* E7C1C 800F741C 000001AD */   sw        $at, 0x0($t0)
  .L800F7420:
    /* E7C20 800F7420 FF00013C */  lui        $at, (0xFFFFFF >> 16)
    /* E7C24 800F7424 FFFF2134 */  ori        $at, $at, (0xFFFFFF & 0xFFFF)
    /* E7C28 800F7428 0800E003 */  jr         $ra
    /* E7C2C 800F742C 000001AD */   sw        $at, 0x0($t0)
endlabel DecDCTvlcSize
