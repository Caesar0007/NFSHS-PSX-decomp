.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LocateGroupType__15SerializedGroupii, 0x70

glabel LocateGroupType__15SerializedGroupii
    /* 8C950 8009C150 21400000 */  addu       $t0, $zero, $zero
    /* 8C954 8009C154 0C00878C */  lw         $a3, 0xC($a0)
    /* 8C958 8009C158 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 8C95C 8009C15C FFFFE724 */  addiu      $a3, $a3, -0x1
    /* 8C960 8009C160 1500E210 */  beq        $a3, $v0, .L8009C1B8
    /* 8C964 8009C164 10008424 */   addiu     $a0, $a0, 0x10
    /* 8C968 8009C168 21484000 */  addu       $t1, $v0, $zero
  .L8009C16C:
    /* 8C96C 8009C16C 0000828C */  lw         $v0, 0x0($a0)
    /* 8C970 8009C170 00000000 */  nop
    /* 8C974 8009C174 05004514 */  bne        $v0, $a1, .L8009C18C
    /* 8C978 8009C178 00000000 */   nop
    /* 8C97C 8009C17C 03000615 */  bne        $t0, $a2, .L8009C18C
    /* 8C980 8009C180 01000825 */   addiu     $t0, $t0, 0x1
    /* 8C984 8009C184 0800E003 */  jr         $ra
    /* 8C988 8009C188 21108000 */   addu      $v0, $a0, $zero
  .L8009C18C:
    /* 8C98C 8009C18C 0400828C */  lw         $v0, 0x4($a0)
    /* 8C990 8009C190 00000000 */  nop
    /* 8C994 8009C194 03004330 */  andi       $v1, $v0, 0x3
    /* 8C998 8009C198 03006010 */  beqz       $v1, .L8009C1A8
    /* 8C99C 8009C19C 04004224 */   addiu     $v0, $v0, 0x4
    /* 8C9A0 8009C1A0 23104300 */  subu       $v0, $v0, $v1
    /* 8C9A4 8009C1A4 040082AC */  sw         $v0, 0x4($a0)
  .L8009C1A8:
    /* 8C9A8 8009C1A8 0400828C */  lw         $v0, 0x4($a0)
    /* 8C9AC 8009C1AC FFFFE724 */  addiu      $a3, $a3, -0x1
    /* 8C9B0 8009C1B0 EEFFE914 */  bne        $a3, $t1, .L8009C16C
    /* 8C9B4 8009C1B4 21208200 */   addu      $a0, $a0, $v0
  .L8009C1B8:
    /* 8C9B8 8009C1B8 0800E003 */  jr         $ra
    /* 8C9BC 8009C1BC 21100000 */   addu      $v0, $zero, $zero
endlabel LocateGroupType__15SerializedGroupii
