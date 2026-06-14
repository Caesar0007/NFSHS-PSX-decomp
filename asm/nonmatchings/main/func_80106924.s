.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80106924, 0x24

glabel func_80106924
    /* F7124 80106924 0600A010 */  beqz       $a1, .L80106940
    /* F7128 80106928 FFFFA224 */   addiu     $v0, $a1, -0x1
    /* F712C 8010692C FFFF0324 */  addiu      $v1, $zero, -0x1
  .L80106930:
    /* F7130 80106930 000080AC */  sw         $zero, 0x0($a0)
    /* F7134 80106934 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* F7138 80106938 FDFF4314 */  bne        $v0, $v1, .L80106930
    /* F713C 8010693C 04008424 */   addiu     $a0, $a0, 0x4
  .L80106940:
    /* F7140 80106940 0800E003 */  jr         $ra
    /* F7144 80106944 00000000 */   nop
endlabel func_80106924
    /* F7148 80106948 00000000 */  nop
