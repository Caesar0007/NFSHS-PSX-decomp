.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching stopreadfile, 0x78

glabel stopreadfile
    /* E4900 800F4100 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E4904 800F4104 FF00023C */  lui        $v0, (0xFFFFFF >> 16)
    /* E4908 800F4108 FFFF4234 */  ori        $v0, $v0, (0xFFFFFF & 0xFFFF)
    /* E490C 800F410C 031E0400 */  sra        $v1, $a0, 24
    /* E4910 800F4110 24208200 */  and        $a0, $a0, $v0
    /* E4914 800F4114 01000224 */  addiu      $v0, $zero, 0x1
    /* E4918 800F4118 05006214 */  bne        $v1, $v0, .L800F4130
    /* E491C 800F411C 1000BFAF */   sw        $ra, 0x10($sp)
    /* E4920 800F4120 41EA030C */  jal        CD_Stopread
    /* E4924 800F4124 00000000 */   nop
    /* E4928 800F4128 5AD00308 */  j          .L800F4168
    /* E492C 800F412C 00000000 */   nop
  .L800F4130:
    /* E4930 800F4130 02000224 */  addiu      $v0, $zero, 0x2
    /* E4934 800F4134 0C006214 */  bne        $v1, $v0, .L800F4168
    /* E4938 800F4138 1480033C */   lui       $v1, %hi(readcmd)
    /* E493C 800F413C 0004628C */  lw         $v0, %lo(readcmd)($v1)
    /* E4940 800F4140 00000000 */  nop
    /* E4944 800F4144 08004010 */  beqz       $v0, .L800F4168
    /* E4948 800F4148 00046524 */   addiu     $a1, $v1, %lo(readcmd)
    /* E494C 800F414C 0400A28C */  lw         $v0, 0x4($a1)
    /* E4950 800F4150 00000000 */  nop
    /* E4954 800F4154 04004414 */  bne        $v0, $a0, .L800F4168
    /* E4958 800F4158 00000000 */   nop
    /* E495C 800F415C 000460AC */  sw         $zero, %lo(readcmd)($v1)
    /* E4960 800F4160 08B4030C */  jal        iFILE_CommandCompleteCallback
    /* E4964 800F4164 01000424 */   addiu     $a0, $zero, 0x1
  .L800F4168:
    /* E4968 800F4168 1000BF8F */  lw         $ra, 0x10($sp)
    /* E496C 800F416C 00000000 */  nop
    /* E4970 800F4170 0800E003 */  jr         $ra
    /* E4974 800F4174 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel stopreadfile
