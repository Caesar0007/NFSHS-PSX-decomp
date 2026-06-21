.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DeInit_Memcard__Fv, 0xA0

glabel DeInit_Memcard__Fv
    /* 25000 80034800 0580033C */  lui        $v1, %hi(MEMCARD_INITIALIZED)
    /* 25004 80034804 801A628C */  lw         $v0, %lo(MEMCARD_INITIALIZED)($v1)
    /* 25008 80034808 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2500C 8003480C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 25010 80034810 1F004010 */  beqz       $v0, .L80034890
    /* 25014 80034814 1000B0AF */   sw        $s0, 0x10($sp)
    /* 25018 80034818 0980103C */  lui        $s0, %hi(Clock_MasterInterruptHandler__Fv)
    /* 2501C 8003481C 38B91026 */  addiu      $s0, $s0, %lo(Clock_MasterInterruptHandler__Fv)
    /* 25020 80034820 21200002 */  addu       $a0, $s0, $zero
    /* 25024 80034824 12AC030C */  jal        deltimer
    /* 25028 80034828 801A60AC */   sw        $zero, %lo(MEMCARD_INITIALIZED)($v1)
    /* 2502C 8003482C 363D010C */  jal        MCRD_restore
    /* 25030 80034830 00000000 */   nop
    /* 25034 80034834 FAAB030C */  jal        addtimer
    /* 25038 80034838 21200002 */   addu      $a0, $s0, $zero
    /* 2503C 8003483C 5690030C */  jal        PAD_restore
    /* 25040 80034840 00000000 */   nop
    /* 25044 80034844 1480023C */  lui        $v0, %hi(ticks)
    /* 25048 80034848 21184000 */  addu       $v1, $v0, $zero
    /* 2504C 8003484C ACDC648C */  lw         $a0, %lo(ticks)($v1)
  .L80034850:
    /* 25050 80034850 ACDC628C */  lw         $v0, %lo(ticks)($v1)
    /* 25054 80034854 00000000 */  nop
    /* 25058 80034858 23104400 */  subu       $v0, $v0, $a0
    /* 2505C 8003485C C0004228 */  slti       $v0, $v0, 0xC0
    /* 25060 80034860 FBFF4014 */  bnez       $v0, .L80034850
    /* 25064 80034864 00000000 */   nop
    /* 25068 80034868 3A90030C */  jal        padinit
    /* 2506C 8003486C 00000000 */   nop
    /* 25070 80034870 1480023C */  lui        $v0, %hi(MEMCARDFRONTENDISINITTED)
    /* 25074 80034874 84D2428C */  lw         $v0, %lo(MEMCARDFRONTENDISINITTED)($v0)
    /* 25078 80034878 00000000 */  nop
    /* 2507C 8003487C 04004010 */  beqz       $v0, .L80034890
    /* 25080 80034880 0580023C */   lui       $v0, %hi(FEApp)
    /* 25084 80034884 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 25088 80034888 584F000C */  jal        UpdateMusic__14tFEApplication
    /* 2508C 8003488C 00000000 */   nop
  .L80034890:
    /* 25090 80034890 1400BF8F */  lw         $ra, 0x14($sp)
    /* 25094 80034894 1000B08F */  lw         $s0, 0x10($sp)
    /* 25098 80034898 0800E003 */  jr         $ra
    /* 2509C 8003489C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DeInit_Memcard__Fv
