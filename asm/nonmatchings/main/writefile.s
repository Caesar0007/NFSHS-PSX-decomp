.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching writefile, 0x7C

glabel writefile
    /* E4820 800F4020 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E4824 800F4024 1800B2AF */  sw         $s2, 0x18($sp)
    /* E4828 800F4028 2190A000 */  addu       $s2, $a1, $zero
    /* E482C 800F402C 2128C000 */  addu       $a1, $a2, $zero
    /* E4830 800F4030 1400B1AF */  sw         $s1, 0x14($sp)
    /* E4834 800F4034 2188E000 */  addu       $s1, $a3, $zero
    /* E4838 800F4038 FF00023C */  lui        $v0, (0xFFFFFF >> 16)
    /* E483C 800F403C FFFF4234 */  ori        $v0, $v0, (0xFFFFFF & 0xFFFF)
    /* E4840 800F4040 031E0400 */  sra        $v1, $a0, 24
    /* E4844 800F4044 1000B0AF */  sw         $s0, 0x10($sp)
    /* E4848 800F4048 24808200 */  and        $s0, $a0, $v0
    /* E484C 800F404C 02000224 */  addiu      $v0, $zero, 0x2
    /* E4850 800F4050 0B006214 */  bne        $v1, $v0, .L800F4080
    /* E4854 800F4054 1C00BFAF */   sw        $ra, 0x1C($sp)
    /* E4858 800F4058 21200002 */  addu       $a0, $s0, $zero
    /* E485C 800F405C 471B040C */  jal        PClseek
    /* E4860 800F4060 21300000 */   addu      $a2, $zero, $zero
    /* E4864 800F4064 21200002 */  addu       $a0, $s0, $zero
    /* E4868 800F4068 21284002 */  addu       $a1, $s2, $zero
    /* E486C 800F406C 541B040C */  jal        PCwrite
    /* E4870 800F4070 21302002 */   addu      $a2, $s1, $zero
    /* E4874 800F4074 26105100 */  xor        $v0, $v0, $s1
    /* E4878 800F4078 08B4030C */  jal        iFILE_CommandCompleteCallback
    /* E487C 800F407C 0100442C */   sltiu     $a0, $v0, 0x1
  .L800F4080:
    /* E4880 800F4080 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* E4884 800F4084 1800B28F */  lw         $s2, 0x18($sp)
    /* E4888 800F4088 1400B18F */  lw         $s1, 0x14($sp)
    /* E488C 800F408C 1000B08F */  lw         $s0, 0x10($sp)
    /* E4890 800F4090 21100000 */  addu       $v0, $zero, $zero
    /* E4894 800F4094 0800E003 */  jr         $ra
    /* E4898 800F4098 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel writefile
