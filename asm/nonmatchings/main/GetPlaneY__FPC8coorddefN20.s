.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetPlaneY__FPC8coorddefN20, 0xA8

glabel GetPlaneY__FPC8coorddefN20
    /* A6914 800B6114 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* A6918 800B6118 1800B2AF */  sw         $s2, 0x18($sp)
    /* A691C 800B611C 21908000 */  addu       $s2, $a0, $zero
    /* A6920 800B6120 1000B0AF */  sw         $s0, 0x10($sp)
    /* A6924 800B6124 2180A000 */  addu       $s0, $a1, $zero
    /* A6928 800B6128 2000BFAF */  sw         $ra, 0x20($sp)
    /* A692C 800B612C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* A6930 800B6130 1400B1AF */  sw         $s1, 0x14($sp)
    /* A6934 800B6134 0000448E */  lw         $a0, 0x0($s2)
    /* A6938 800B6138 0000058E */  lw         $a1, 0x0($s0)
    /* A693C 800B613C CA90030C */  jal        fixedmult
    /* A6940 800B6140 2198C000 */   addu      $s3, $a2, $zero
    /* A6944 800B6144 0400448E */  lw         $a0, 0x4($s2)
    /* A6948 800B6148 0400058E */  lw         $a1, 0x4($s0)
    /* A694C 800B614C CA90030C */  jal        fixedmult
    /* A6950 800B6150 21884000 */   addu      $s1, $v0, $zero
    /* A6954 800B6154 0800448E */  lw         $a0, 0x8($s2)
    /* A6958 800B6158 0800058E */  lw         $a1, 0x8($s0)
    /* A695C 800B615C CA90030C */  jal        fixedmult
    /* A6960 800B6160 21804000 */   addu      $s0, $v0, $zero
    /* A6964 800B6164 21883002 */  addu       $s1, $s1, $s0
    /* A6968 800B6168 21882202 */  addu       $s1, $s1, $v0
    /* A696C 800B616C 0000448E */  lw         $a0, 0x0($s2)
    /* A6970 800B6170 0000658E */  lw         $a1, 0x0($s3)
    /* A6974 800B6174 CA90030C */  jal        fixedmult
    /* A6978 800B6178 23881100 */   negu      $s1, $s1
    /* A697C 800B617C 0800448E */  lw         $a0, 0x8($s2)
    /* A6980 800B6180 0800658E */  lw         $a1, 0x8($s3)
    /* A6984 800B6184 CA90030C */  jal        fixedmult
    /* A6988 800B6188 21804000 */   addu      $s0, $v0, $zero
    /* A698C 800B618C 21800202 */  addu       $s0, $s0, $v0
    /* A6990 800B6190 21801102 */  addu       $s0, $s0, $s1
    /* A6994 800B6194 0400458E */  lw         $a1, 0x4($s2)
    /* A6998 800B6198 0191030C */  jal        rdiv
    /* A699C 800B619C 23201000 */   negu      $a0, $s0
    /* A69A0 800B61A0 2000BF8F */  lw         $ra, 0x20($sp)
    /* A69A4 800B61A4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* A69A8 800B61A8 1800B28F */  lw         $s2, 0x18($sp)
    /* A69AC 800B61AC 1400B18F */  lw         $s1, 0x14($sp)
    /* A69B0 800B61B0 1000B08F */  lw         $s0, 0x10($sp)
    /* A69B4 800B61B4 0800E003 */  jr         $ra
    /* A69B8 800B61B8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel GetPlaneY__FPC8coorddefN20
