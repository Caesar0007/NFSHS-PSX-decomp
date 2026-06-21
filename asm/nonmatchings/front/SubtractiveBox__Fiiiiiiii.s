.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SubtractiveBox__Fiiiiiiii, 0x160

glabel SubtractiveBox__Fiiiiiiii
    /* C8FC 8001C0FC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* C900 8001C100 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* C904 8001C104 21888000 */  addu       $s1, $a0, $zero
    /* C908 8001C108 2160A000 */  addu       $t4, $a1, $zero
    /* C90C 8001C10C 2000B2AF */  sw         $s2, 0x20($sp)
    /* C910 8001C110 801F123C */  lui        $s2, (0x1F800004 >> 16)
    /* C914 8001C114 04005236 */  ori        $s2, $s2, (0x1F800004 & 0xFFFF)
    /* C918 8001C118 FF000A3C */  lui        $t2, (0xFFFFFF >> 16)
    /* C91C 8001C11C FFFF4A35 */  ori        $t2, $t2, (0xFFFFFF & 0xFFFF)
    /* C920 8001C120 02000424 */  addiu      $a0, $zero, 0x2
    /* C924 8001C124 21288000 */  addu       $a1, $a0, $zero
    /* C928 8001C128 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* C92C 8001C12C 21A82602 */  addu       $s5, $s1, $a2
    /* C930 8001C130 21300000 */  addu       $a2, $zero, $zero
    /* C934 8001C134 2400B3AF */  sw         $s3, 0x24($sp)
    /* C938 8001C138 21988701 */  addu       $s3, $t4, $a3
    /* C93C 8001C13C 00010724 */  addiu      $a3, $zero, 0x100
    /* C940 8001C140 2800B4AF */  sw         $s4, 0x28($sp)
    /* C944 8001C144 801F143C */  lui        $s4, (0x1F800000 >> 16)
    /* C948 8001C148 00FF0B3C */  lui        $t3, (0xFF000000 >> 16)
    /* C94C 8001C14C 3000BFAF */  sw         $ra, 0x30($sp)
    /* C950 8001C150 1800B0AF */  sw         $s0, 0x18($sp)
    /* C954 8001C154 0000488E */  lw         $t0, 0x0($s2)
    /* C958 8001C158 0000898E */  lw         $t1, (0x1F800000 & 0xFFFF)($s4)
    /* C95C 8001C15C 0000038D */  lw         $v1, 0x0($t0)
    /* C960 8001C160 0000228D */  lw         $v0, 0x0($t1)
    /* C964 8001C164 24186B00 */  and        $v1, $v1, $t3
    /* C968 8001C168 24104A00 */  and        $v0, $v0, $t2
    /* C96C 8001C16C 25186200 */  or         $v1, $v1, $v0
    /* C970 8001C170 000003AD */  sw         $v1, 0x0($t0)
    /* C974 8001C174 4800AD8F */  lw         $t5, 0x48($sp)
    /* C978 8001C178 4C00AE8F */  lw         $t6, 0x4C($sp)
    /* C97C 8001C17C 5000AF8F */  lw         $t7, 0x50($sp)
    /* C980 8001C180 5400B08F */  lw         $s0, 0x54($sp)
    /* C984 8001C184 0000228D */  lw         $v0, 0x0($t1)
    /* C988 8001C188 24000325 */  addiu      $v1, $t0, 0x24
    /* C98C 8001C18C 000043AE */  sw         $v1, 0x0($s2)
    /* C990 8001C190 24180A01 */  and        $v1, $t0, $t2
    /* C994 8001C194 24104B00 */  and        $v0, $v0, $t3
    /* C998 8001C198 25104300 */  or         $v0, $v0, $v1
    /* C99C 8001C19C 000022AD */  sw         $v0, 0x0($t1)
    /* C9A0 8001C1A0 08000224 */  addiu      $v0, $zero, 0x8
    /* C9A4 8001C1A4 030002A1 */  sb         $v0, 0x3($t0)
    /* C9A8 8001C1A8 3A000224 */  addiu      $v0, $zero, 0x3A
    /* C9AC 8001C1AC 04000DAD */  sw         $t5, 0x4($t0)
    /* C9B0 8001C1B0 0C000EAD */  sw         $t6, 0xC($t0)
    /* C9B4 8001C1B4 14000FAD */  sw         $t7, 0x14($t0)
    /* C9B8 8001C1B8 1C0010AD */  sw         $s0, 0x1C($t0)
    /* C9BC 8001C1BC 070002A1 */  sb         $v0, 0x7($t0)
    /* C9C0 8001C1C0 080011A5 */  sh         $s1, 0x8($t0)
    /* C9C4 8001C1C4 0A000CA5 */  sh         $t4, 0xA($t0)
    /* C9C8 8001C1C8 100015A5 */  sh         $s5, 0x10($t0)
    /* C9CC 8001C1CC 12000CA5 */  sh         $t4, 0x12($t0)
    /* C9D0 8001C1D0 180011A5 */  sh         $s1, 0x18($t0)
    /* C9D4 8001C1D4 1A0013A5 */  sh         $s3, 0x1A($t0)
    /* C9D8 8001C1D8 200015A5 */  sh         $s5, 0x20($t0)
    /* C9DC 8001C1DC 220013A5 */  sh         $s3, 0x22($t0)
    /* C9E0 8001C1E0 0000508E */  lw         $s0, 0x0($s2)
    /* C9E4 8001C1E4 0000888E */  lw         $t0, (0x1F800000 & 0xFFFF)($s4)
    /* C9E8 8001C1E8 0000038E */  lw         $v1, 0x0($s0)
    /* C9EC 8001C1EC 0000028D */  lw         $v0, 0x0($t0)
    /* C9F0 8001C1F0 24186B00 */  and        $v1, $v1, $t3
    /* C9F4 8001C1F4 24104A00 */  and        $v0, $v0, $t2
    /* C9F8 8001C1F8 25186200 */  or         $v1, $v1, $v0
    /* C9FC 8001C1FC 000003AE */  sw         $v1, 0x0($s0)
    /* CA00 8001C200 0C000326 */  addiu      $v1, $s0, 0xC
    /* CA04 8001C204 0000028D */  lw         $v0, 0x0($t0)
    /* CA08 8001C208 24500A02 */  and        $t2, $s0, $t2
    /* CA0C 8001C20C 000043AE */  sw         $v1, 0x0($s2)
    /* CA10 8001C210 24104B00 */  and        $v0, $v0, $t3
    /* CA14 8001C214 25104A00 */  or         $v0, $v0, $t2
    /* CA18 8001C218 FFC6030C */  jal        GetTPage
    /* CA1C 8001C21C 000002AD */   sw        $v0, 0x0($t0)
    /* CA20 8001C220 21200002 */  addu       $a0, $s0, $zero
    /* CA24 8001C224 21280000 */  addu       $a1, $zero, $zero
    /* CA28 8001C228 2130A000 */  addu       $a2, $a1, $zero
    /* CA2C 8001C22C FFFF4730 */  andi       $a3, $v0, 0xFFFF
    /* CA30 8001C230 EFB8030C */  jal        SetDrawMode
    /* CA34 8001C234 1000A0AF */   sw        $zero, 0x10($sp)
    /* CA38 8001C238 3000BF8F */  lw         $ra, 0x30($sp)
    /* CA3C 8001C23C 2C00B58F */  lw         $s5, 0x2C($sp)
    /* CA40 8001C240 2800B48F */  lw         $s4, 0x28($sp)
    /* CA44 8001C244 2400B38F */  lw         $s3, 0x24($sp)
    /* CA48 8001C248 2000B28F */  lw         $s2, 0x20($sp)
    /* CA4C 8001C24C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* CA50 8001C250 1800B08F */  lw         $s0, 0x18($sp)
    /* CA54 8001C254 0800E003 */  jr         $ra
    /* CA58 8001C258 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel SubtractiveBox__Fiiiiiiii
