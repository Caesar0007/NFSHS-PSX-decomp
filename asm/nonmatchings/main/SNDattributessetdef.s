.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDattributessetdef, 0x34

glabel SNDattributessetdef
    /* F3DB0 801035B0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* F3DB4 801035B4 000082AC */  sw         $v0, 0x0($a0)
    /* F3DB8 801035B8 7F000224 */  addiu      $v0, $zero, 0x7F
    /* F3DBC 801035BC 070082A0 */  sb         $v0, 0x7($a0)
    /* F3DC0 801035C0 40000224 */  addiu      $v0, $zero, 0x40
    /* F3DC4 801035C4 080082A0 */  sb         $v0, 0x8($a0)
    /* F3DC8 801035C8 21100000 */  addu       $v0, $zero, $zero
    /* F3DCC 801035CC 060080A0 */  sb         $zero, 0x6($a0)
    /* F3DD0 801035D0 040080A4 */  sh         $zero, 0x4($a0)
    /* F3DD4 801035D4 090080A0 */  sb         $zero, 0x9($a0)
    /* F3DD8 801035D8 0A0080A0 */  sb         $zero, 0xA($a0)
    /* F3DDC 801035DC 0800E003 */  jr         $ra
    /* F3DE0 801035E0 0B0080A0 */   sb        $zero, 0xB($a0)
endlabel SNDattributessetdef
