.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hide__11tDialogBase, 0xB4

glabel Hide__11tDialogBase
    /* 9104 80018904 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9108 80018908 1800B2AF */  sw         $s2, 0x18($sp)
    /* 910C 8001890C 21908000 */  addu       $s2, $a0, $zero
    /* 9110 80018910 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 9114 80018914 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9118 80018918 1000B0AF */  sw         $s0, 0x10($sp)
    /* 911C 8001891C 7000428E */  lw         $v0, 0x70($s2)
    /* 9120 80018920 00000000 */  nop
    /* 9124 80018924 1E004010 */  beqz       $v0, .L800189A0
    /* 9128 80018928 21800000 */   addu      $s0, $zero, $zero
    /* 912C 8001892C 700040AE */  sw         $zero, 0x70($s2)
    /* 9130 80018930 0580023C */  lui        $v0, %hi(_front_data_orgend)
    /* 9134 80018934 382B5124 */  addiu      $s1, $v0, %lo(_front_data_orgend)
    /* 9138 80018938 00141000 */  sll        $v0, $s0, 16
  .L8001893C:
    /* 913C 8001893C 033C0200 */  sra        $a3, $v0, 16
    /* 9140 80018940 80180700 */  sll        $v1, $a3, 2
    /* 9144 80018944 21287100 */  addu       $a1, $v1, $s1
    /* 9148 80018948 0000A28C */  lw         $v0, 0x0($a1)
    /* 914C 8001894C 00000000 */  nop
    /* 9150 80018950 0D005214 */  bne        $v0, $s2, .L80018988
    /* 9154 80018954 01000226 */   addiu     $v0, $s0, 0x1
    /* 9158 80018958 04002426 */  addiu      $a0, $s1, 0x4
    /* 915C 8001895C 21206400 */  addu       $a0, $v1, $a0
    /* 9160 80018960 07000624 */  addiu      $a2, $zero, 0x7
    /* 9164 80018964 2330C700 */  subu       $a2, $a2, $a3
    /* 9168 80018968 80300600 */  sll        $a2, $a2, 2
    /* 916C 8001896C 700040AE */  sw         $zero, 0x70($s2)
    /* 9170 80018970 B798030C */  jal        blockmove
    /* 9174 80018974 0000A0AC */   sw        $zero, 0x0($a1)
    /* 9178 80018978 12000424 */  addiu      $a0, $zero, 0x12
    /* 917C 8001897C 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* 9180 80018980 1C0020AE */   sw        $zero, 0x1C($s1)
    /* 9184 80018984 01000226 */  addiu      $v0, $s0, 0x1
  .L80018988:
    /* 9188 80018988 21804000 */  addu       $s0, $v0, $zero
    /* 918C 8001898C 00140200 */  sll        $v0, $v0, 16
    /* 9190 80018990 03140200 */  sra        $v0, $v0, 16
    /* 9194 80018994 08004228 */  slti       $v0, $v0, 0x8
    /* 9198 80018998 E8FF4014 */  bnez       $v0, .L8001893C
    /* 919C 8001899C 00141000 */   sll       $v0, $s0, 16
  .L800189A0:
    /* 91A0 800189A0 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 91A4 800189A4 1800B28F */  lw         $s2, 0x18($sp)
    /* 91A8 800189A8 1400B18F */  lw         $s1, 0x14($sp)
    /* 91AC 800189AC 1000B08F */  lw         $s0, 0x10($sp)
    /* 91B0 800189B0 0800E003 */  jr         $ra
    /* 91B4 800189B4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Hide__11tDialogBase
