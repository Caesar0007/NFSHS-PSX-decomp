.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDplaysetdef, 0x50

glabel SNDplaysetdef
    /* D7034 800E6834 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* D7038 800E6838 000082AC */  sw         $v0, 0x0($a0)
    /* D703C 800E683C 040082A0 */  sb         $v0, 0x4($a0)
    /* D7040 800E6840 3C000224 */  addiu      $v0, $zero, 0x3C
    /* D7044 800E6844 050082A0 */  sb         $v0, 0x5($a0)
    /* D7048 800E6848 00100224 */  addiu      $v0, $zero, 0x1000
    /* D704C 800E684C 0C0082A4 */  sh         $v0, 0xC($a0)
    /* D7050 800E6850 0E0082A4 */  sh         $v0, 0xE($a0)
    /* D7054 800E6854 7F000224 */  addiu      $v0, $zero, 0x7F
    /* D7058 800E6858 40000324 */  addiu      $v1, $zero, 0x40
    /* D705C 800E685C 060082A0 */  sb         $v0, 0x6($a0)
    /* D7060 800E6860 080082A0 */  sb         $v0, 0x8($a0)
    /* D7064 800E6864 0A0082A0 */  sb         $v0, 0xA($a0)
    /* D7068 800E6868 21100000 */  addu       $v0, $zero, $zero
    /* D706C 800E686C 070083A0 */  sb         $v1, 0x7($a0)
    /* D7070 800E6870 090083A0 */  sb         $v1, 0x9($a0)
    /* D7074 800E6874 0B0080A0 */  sb         $zero, 0xB($a0)
    /* D7078 800E6878 100080A4 */  sh         $zero, 0x10($a0)
    /* D707C 800E687C 0800E003 */  jr         $ra
    /* D7080 800E6880 120080A4 */   sh        $zero, 0x12($a0)
endlabel SNDplaysetdef
