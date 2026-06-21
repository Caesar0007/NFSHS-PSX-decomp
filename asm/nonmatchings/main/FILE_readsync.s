.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_readsync, 0x30

glabel FILE_readsync
    /* DB120 800EA920 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DB124 800EA924 0F80023C */  lui        $v0, %hi(FILE_read)
    /* DB128 800EA928 3000A38F */  lw         $v1, 0x30($sp)
    /* DB12C 800EA92C ECC44224 */  addiu      $v0, $v0, %lo(FILE_read)
    /* DB130 800EA930 1800BFAF */  sw         $ra, 0x18($sp)
    /* DB134 800EA934 1400A2AF */  sw         $v0, 0x14($sp)
    /* DB138 800EA938 FAA9030C */  jal        syncblockio
    /* DB13C 800EA93C 1000A3AF */   sw        $v1, 0x10($sp)
    /* DB140 800EA940 1800BF8F */  lw         $ra, 0x18($sp)
    /* DB144 800EA944 00000000 */  nop
    /* DB148 800EA948 0800E003 */  jr         $ra
    /* DB14C 800EA94C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FILE_readsync
