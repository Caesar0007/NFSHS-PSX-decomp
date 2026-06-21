.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__14tScreenMemcard, 0x64

glabel Cleanup__14tScreenMemcard
    /* 385D8 80047DD8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 385DC 80047DDC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 385E0 80047DE0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 385E4 80047DE4 EE1E010C */  jal        ReleaseIcons__14tScreenMemcard
    /* 385E8 80047DE8 21808000 */   addu      $s0, $a0, $zero
    /* 385EC 80047DEC 00D2000C */  jal        DeInit_Memcard__Fv
    /* 385F0 80047DF0 00000000 */   nop
    /* 385F4 80047DF4 0580023C */  lui        $v0, %hi(fMemIcon)
    /* 385F8 80047DF8 3829448C */  lw         $a0, %lo(fMemIcon)($v0)
    /* 385FC 80047DFC 0580023C */  lui        $v0, %hi(menuDefs)
    /* 38600 80047E00 581A458C */  lw         $a1, %lo(menuDefs)($v0)
    /* 38604 80047E04 FEFF0624 */  addiu      $a2, $zero, -0x2
    /* 38608 80047E08 5430A28C */  lw         $v0, 0x3054($a1)
    /* 3860C 80047E0C 8030A38C */  lw         $v1, 0x3080($a1)
    /* 38610 80047E10 24104600 */  and        $v0, $v0, $a2
    /* 38614 80047E14 24186600 */  and        $v1, $v1, $a2
    /* 38618 80047E18 5430A2AC */  sw         $v0, 0x3054($a1)
    /* 3861C 80047E1C 5095030C */  jal        purgememadr
    /* 38620 80047E20 8030A3AC */   sw        $v1, 0x3080($a1)
    /* 38624 80047E24 6898000C */  jal        Cleanup__7tScreen
    /* 38628 80047E28 21200002 */   addu      $a0, $s0, $zero
    /* 3862C 80047E2C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 38630 80047E30 1000B08F */  lw         $s0, 0x10($sp)
    /* 38634 80047E34 0800E003 */  jr         $ra
    /* 38638 80047E38 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__14tScreenMemcard
