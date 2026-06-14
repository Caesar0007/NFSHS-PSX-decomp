.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_LoadBank__FPci, 0x84

glabel AudioCmn_LoadBank__FPci
    /* AC68C 800BBE8C 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* AC690 800BBE90 6400B1AF */  sw         $s1, 0x64($sp)
    /* AC694 800BBE94 21888000 */  addu       $s1, $a0, $zero
    /* AC698 800BBE98 6800B2AF */  sw         $s2, 0x68($sp)
    /* AC69C 800BBE9C 2190A000 */  addu       $s2, $a1, $zero
    /* AC6A0 800BBEA0 1000A427 */  addiu      $a0, $sp, 0x10
    /* AC6A4 800BBEA4 21282002 */  addu       $a1, $s1, $zero
    /* AC6A8 800BBEA8 6C00BFAF */  sw         $ra, 0x6C($sp)
    /* AC6AC 800BBEAC CA96030C */  jal        strcpy
    /* AC6B0 800BBEB0 6000B0AF */   sw        $s0, 0x60($sp)
    /* AC6B4 800BBEB4 1000A427 */  addiu      $a0, $sp, 0x10
    /* AC6B8 800BBEB8 1480053C */  lui        $a1, %hi(D_8013D514)
    /* AC6BC 800BBEBC 3A9E030C */  jal        strcat
    /* AC6C0 800BBEC0 14D5A524 */   addiu     $a1, $a1, %lo(D_8013D514)
    /* AC6C4 800BBEC4 1000A427 */  addiu      $a0, $sp, 0x10
    /* AC6C8 800BBEC8 EA95030C */  jal        loadfileadrz
    /* AC6CC 800BBECC 10000524 */   addiu     $a1, $zero, 0x10
    /* AC6D0 800BBED0 21804000 */  addu       $s0, $v0, $zero
    /* AC6D4 800BBED4 08000012 */  beqz       $s0, .L800BBEF8
    /* AC6D8 800BBED8 21100000 */   addu      $v0, $zero, $zero
    /* AC6DC 800BBEDC 9B95030C */  jal        filesize
    /* AC6E0 800BBEE0 1000A427 */   addiu     $a0, $sp, 0x10
    /* AC6E4 800BBEE4 21202002 */  addu       $a0, $s1, $zero
    /* AC6E8 800BBEE8 21284000 */  addu       $a1, $v0, $zero
    /* AC6EC 800BBEEC 21300002 */  addu       $a2, $s0, $zero
    /* AC6F0 800BBEF0 59EF020C */  jal        AudioCmn_AddBank__FPciT0i
    /* AC6F4 800BBEF4 21384002 */   addu      $a3, $s2, $zero
  .L800BBEF8:
    /* AC6F8 800BBEF8 6C00BF8F */  lw         $ra, 0x6C($sp)
    /* AC6FC 800BBEFC 6800B28F */  lw         $s2, 0x68($sp)
    /* AC700 800BBF00 6400B18F */  lw         $s1, 0x64($sp)
    /* AC704 800BBF04 6000B08F */  lw         $s0, 0x60($sp)
    /* AC708 800BBF08 0800E003 */  jr         $ra
    /* AC70C 800BBF0C 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel AudioCmn_LoadBank__FPci
