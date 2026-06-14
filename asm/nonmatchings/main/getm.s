.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching getm, 0x68

glabel getm
    /* E3824 800F3024 00008990 */  lbu        $t1, 0x0($a0)
    /* E3828 800F3028 FDFFA824 */  addiu      $t0, $a1, -0x3
    /* E382C 800F302C 0F000005 */  bltz       $t0, .L800F306C
    /* E3830 800F3030 00120900 */   sll       $v0, $t1, 8
    /* E3834 800F3034 01008A90 */  lbu        $t2, 0x1($a0)
    /* E3838 800F3038 08000011 */  beqz       $t0, .L800F305C
    /* E383C 800F303C 25104A00 */   or        $v0, $v0, $t2
    /* E3840 800F3040 02008B90 */  lbu        $t3, 0x2($a0)
    /* E3844 800F3044 03008C90 */  lbu        $t4, 0x3($a0)
    /* E3848 800F3048 00140200 */  sll        $v0, $v0, 16
    /* E384C 800F304C 005A0B00 */  sll        $t3, $t3, 8
    /* E3850 800F3050 25586C01 */  or         $t3, $t3, $t4
    /* E3854 800F3054 0800E003 */  jr         $ra
    /* E3858 800F3058 25104B00 */   or        $v0, $v0, $t3
  .L800F305C:
    /* E385C 800F305C 02008B90 */  lbu        $t3, 0x2($a0)
    /* E3860 800F3060 00120200 */  sll        $v0, $v0, 8
    /* E3864 800F3064 0800E003 */  jr         $ra
    /* E3868 800F3068 25104B00 */   or        $v0, $v0, $t3
  .L800F306C:
    /* E386C 800F306C 01008A90 */  lbu        $t2, 0x1($a0)
    /* E3870 800F3070 FEFFA824 */  addiu      $t0, $a1, -0x2
    /* E3874 800F3074 03000005 */  bltz       $t0, .L800F3084
    /* E3878 800F3078 00000000 */   nop
    /* E387C 800F307C 0800E003 */  jr         $ra
    /* E3880 800F3080 25104A00 */   or        $v0, $v0, $t2
  .L800F3084:
    /* E3884 800F3084 0800E003 */  jr         $ra
    /* E3888 800F3088 25100900 */   or        $v0, $zero, $t1
endlabel getm
