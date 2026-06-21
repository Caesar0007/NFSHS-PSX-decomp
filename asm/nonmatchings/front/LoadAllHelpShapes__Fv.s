.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadAllHelpShapes__Fv, 0x90

glabel LoadAllHelpShapes__Fv
    /* 3F3B4 8004EBB4 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 3F3B8 8004EBB8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3F3BC 8004EBBC 1180023C */  lui        $v0, %hi(D_801164E8)
    /* 3F3C0 8004EBC0 0180053C */  lui        $a1, %hi(D_8001283C)
    /* 3F3C4 8004EBC4 E864468C */  lw         $a2, %lo(D_801164E8)($v0)
    /* 3F3C8 8004EBC8 3C28A524 */  addiu      $a1, $a1, %lo(D_8001283C)
    /* 3F3CC 8004EBCC 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* 3F3D0 8004EBD0 4800B2AF */  sw         $s2, 0x48($sp)
    /* 3F3D4 8004EBD4 4400B1AF */  sw         $s1, 0x44($sp)
    /* 3F3D8 8004EBD8 2F91030C */  jal        sprintf
    /* 3F3DC 8004EBDC 4000B0AF */   sw        $s0, 0x40($sp)
    /* 3F3E0 8004EBE0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3F3E4 8004EBE4 0FC7030C */  jal        loadshapeadr
    /* 3F3E8 8004EBE8 21280000 */   addu      $a1, $zero, $zero
    /* 3F3EC 8004EBEC 21884000 */  addu       $s1, $v0, $zero
    /* 3F3F0 8004EBF0 0E002012 */  beqz       $s1, .L8004EC2C
    /* 3F3F4 8004EBF4 21800000 */   addu      $s0, $zero, $zero
    /* 3F3F8 8004EBF8 0580123C */  lui        $s2, %hi(gHelpShapes)
    /* 3F3FC 8004EBFC 21202002 */  addu       $a0, $s1, $zero
  .L8004EC00:
    /* 3F400 8004EC00 21280002 */  addu       $a1, $s0, $zero
    /* 3F404 8004EC04 40111000 */  sll        $v0, $s0, 5
    /* 3F408 8004EC08 642A468E */  lw         $a2, %lo(gHelpShapes)($s2)
    /* 3F40C 8004EC0C 01001026 */  addiu      $s0, $s0, 0x1
    /* 3F410 8004EC10 EE3C010C */  jal        FETexture_LoadPmx__FPciP18tTexture_ShapeInfo
    /* 3F414 8004EC14 2130C200 */   addu      $a2, $a2, $v0
    /* 3F418 8004EC18 3B00022A */  slti       $v0, $s0, 0x3B
    /* 3F41C 8004EC1C F8FF4014 */  bnez       $v0, .L8004EC00
    /* 3F420 8004EC20 21202002 */   addu      $a0, $s1, $zero
    /* 3F424 8004EC24 5095030C */  jal        purgememadr
    /* 3F428 8004EC28 21202002 */   addu      $a0, $s1, $zero
  .L8004EC2C:
    /* 3F42C 8004EC2C 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* 3F430 8004EC30 4800B28F */  lw         $s2, 0x48($sp)
    /* 3F434 8004EC34 4400B18F */  lw         $s1, 0x44($sp)
    /* 3F438 8004EC38 4000B08F */  lw         $s0, 0x40($sp)
    /* 3F43C 8004EC3C 0800E003 */  jr         $ra
    /* 3F440 8004EC40 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel LoadAllHelpShapes__Fv
