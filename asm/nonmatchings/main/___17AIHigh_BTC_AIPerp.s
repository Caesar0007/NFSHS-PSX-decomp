.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___17AIHigh_BTC_AIPerp, 0x50

glabel ___17AIHigh_BTC_AIPerp
    /* 50B7C 8006037C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 50B80 80060380 0580023C */  lui        $v0, %hi(_vt_17AIHigh_BTC_AIPerp)
    /* 50B84 80060384 1000BFAF */  sw         $ra, 0x10($sp)
    /* 50B88 80060388 0000868C */  lw         $a2, 0x0($a0)
    /* 50B8C 8006038C 9C00838C */  lw         $v1, 0x9C($a0)
    /* 50B90 80060390 A04F4224 */  addiu      $v0, $v0, %lo(_vt_17AIHigh_BTC_AIPerp)
    /* 50B94 80060394 140082AC */  sw         $v0, 0x14($a0)
    /* 50B98 80060398 B800C3AC */  sw         $v1, 0xB8($a2)
    /* 50B9C 8006039C 0000838C */  lw         $v1, 0x0($a0)
    /* 50BA0 800603A0 A000828C */  lw         $v0, 0xA0($a0)
    /* 50BA4 800603A4 00000000 */  nop
    /* 50BA8 800603A8 BC0062AC */  sw         $v0, 0xBC($v1)
    /* 50BAC 800603AC 0580023C */  lui        $v0, %hi(_vt_16AIHigh_BasicPerp)
    /* 50BB0 800603B0 6C4E4224 */  addiu      $v0, $v0, %lo(_vt_16AIHigh_BasicPerp)
    /* 50BB4 800603B4 F16C010C */  jal        ___11AIHigh_Base
    /* 50BB8 800603B8 140082AC */   sw        $v0, 0x14($a0)
    /* 50BBC 800603BC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 50BC0 800603C0 00000000 */  nop
    /* 50BC4 800603C4 0800E003 */  jr         $ra
    /* 50BC8 800603C8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___17AIHigh_BTC_AIPerp
