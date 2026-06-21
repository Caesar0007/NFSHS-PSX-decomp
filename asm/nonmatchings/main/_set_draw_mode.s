.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _set_draw_mode, 0x20

glabel _set_draw_mode
    /* DF078 800EE878 0200A010 */  beqz       $a1, .L800EE884
    /* DF07C 800EE87C 00E1033C */   lui       $v1, (0xE1000200 >> 16)
    /* DF080 800EE880 00026334 */  ori        $v1, $v1, (0xE1000200 & 0xFFFF)
  .L800EE884:
    /* DF084 800EE884 02008010 */  beqz       $a0, .L800EE890
    /* DF088 800EE888 FF09C230 */   andi      $v0, $a2, 0x9FF
    /* DF08C 800EE88C 00044234 */  ori        $v0, $v0, 0x400
  .L800EE890:
    /* DF090 800EE890 0800E003 */  jr         $ra
    /* DF094 800EE894 25106200 */   or        $v0, $v1, $v0
endlabel _set_draw_mode
