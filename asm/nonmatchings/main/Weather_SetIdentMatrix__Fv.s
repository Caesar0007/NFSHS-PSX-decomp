.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching Weather_SetIdentMatrix__Fv, 0x84

glabel Weather_SetIdentMatrix__Fv
    /* D2694 800E1E94 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D2698 800E1E98 00100324 */  addiu      $v1, $zero, 0x1000
    /* D269C 800E1E9C 00F00224 */  addiu      $v0, $zero, -0x1000
    /* D26A0 800E1EA0 0000A3A7 */  sh         $v1, 0x0($sp)
    /* D26A4 800E1EA4 0200A0A7 */  sh         $zero, 0x2($sp)
    /* D26A8 800E1EA8 0400A0A7 */  sh         $zero, 0x4($sp)
    /* D26AC 800E1EAC 0600A0A7 */  sh         $zero, 0x6($sp)
    /* D26B0 800E1EB0 0800A2A7 */  sh         $v0, 0x8($sp)
    /* D26B4 800E1EB4 0A00A0A7 */  sh         $zero, 0xA($sp)
    /* D26B8 800E1EB8 0C00A0A7 */  sh         $zero, 0xC($sp)
    /* D26BC 800E1EBC 0E00A0A7 */  sh         $zero, 0xE($sp)
    /* D26C0 800E1EC0 1000A3A7 */  sh         $v1, 0x10($sp)
    /* D26C4 800E1EC4 1400A0AF */  sw         $zero, 0x14($sp)
    /* D26C8 800E1EC8 1800A0AF */  sw         $zero, 0x18($sp)
    /* D26CC 800E1ECC 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* D26D0 800E1ED0 0000AC8F */  lw         $t4, 0x0($sp)
    /* D26D4 800E1ED4 0400AD8F */  lw         $t5, 0x4($sp)
    /* D26D8 800E1ED8 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* D26DC 800E1EDC 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* D26E0 800E1EE0 0800AC8F */  lw         $t4, 0x8($sp)
    /* D26E4 800E1EE4 0C00AD8F */  lw         $t5, 0xC($sp)
    /* D26E8 800E1EE8 1000AE8F */  lw         $t6, 0x10($sp)
    /* D26EC 800E1EEC 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* D26F0 800E1EF0 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* D26F4 800E1EF4 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* D26F8 800E1EF8 1400AC8F */  lw         $t4, 0x14($sp)
    /* D26FC 800E1EFC 1800AD8F */  lw         $t5, 0x18($sp)
    /* D2700 800E1F00 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* D2704 800E1F04 1C00AE8F */  lw         $t6, 0x1C($sp)
    /* D2708 800E1F08 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* D270C 800E1F0C 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* D2710 800E1F10 0800E003 */  jr         $ra
    /* D2714 800E1F14 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Weather_SetIdentMatrix__Fv
