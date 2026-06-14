.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpacketplayoverhead, 0x14

glabel iSNDpacketplayoverhead
    /* F30BC 801028BC 40100400 */  sll        $v0, $a0, 1
    /* F30C0 801028C0 21104400 */  addu       $v0, $v0, $a0
    /* F30C4 801028C4 C0100200 */  sll        $v0, $v0, 3
    /* F30C8 801028C8 0800E003 */  jr         $ra
    /* F30CC 801028CC 40004224 */   addiu     $v0, $v0, 0x40
endlabel iSNDpacketplayoverhead
