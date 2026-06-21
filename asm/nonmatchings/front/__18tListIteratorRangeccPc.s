.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __18tListIteratorRangeccPc, 0x5C

glabel __18tListIteratorRangeccPc
    /* 14D34 80024534 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 14D38 80024538 1000B0AF */  sw         $s0, 0x10($sp)
    /* 14D3C 8002453C 21808000 */  addu       $s0, $a0, $zero
    /* 14D40 80024540 1400B1AF */  sw         $s1, 0x14($sp)
    /* 14D44 80024544 2188A000 */  addu       $s1, $a1, $zero
    /* 14D48 80024548 1800B2AF */  sw         $s2, 0x18($sp)
    /* 14D4C 8002454C 2190C000 */  addu       $s2, $a2, $zero
    /* 14D50 80024550 21280000 */  addu       $a1, $zero, $zero
    /* 14D54 80024554 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 14D58 80024558 748F000C */  jal        __13tListIteratorPsPc
    /* 14D5C 8002455C 2130E000 */   addu      $a2, $a3, $zero
    /* 14D60 80024560 21100002 */  addu       $v0, $s0, $zero
    /* 14D64 80024564 0180033C */  lui        $v1, %hi(_vt_18tListIteratorRange)
    /* 14D68 80024568 08136324 */  addiu      $v1, $v1, %lo(_vt_18tListIteratorRange)
    /* 14D6C 8002456C 0C0043AC */  sw         $v1, 0xC($v0)
    /* 14D70 80024570 080051A0 */  sb         $s1, 0x8($v0)
    /* 14D74 80024574 090052A0 */  sb         $s2, 0x9($v0)
    /* 14D78 80024578 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 14D7C 8002457C 1800B28F */  lw         $s2, 0x18($sp)
    /* 14D80 80024580 1400B18F */  lw         $s1, 0x14($sp)
    /* 14D84 80024584 1000B08F */  lw         $s0, 0x10($sp)
    /* 14D88 80024588 0800E003 */  jr         $ra
    /* 14D8C 8002458C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __18tListIteratorRangeccPc
