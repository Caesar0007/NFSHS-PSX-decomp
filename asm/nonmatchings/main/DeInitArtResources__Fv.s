.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DeInitArtResources__Fv, 0x24

glabel DeInitArtResources__Fv
    /* A9C08 800B9408 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A9C0C 800B940C 1280023C */  lui        $v0, %hi(D_8011E164)
    /* A9C10 800B9410 1000BFAF */  sw         $ra, 0x10($sp)
    /* A9C14 800B9414 4C2E020C */  jal        Chunk_DeInit__Fv
    /* A9C18 800B9418 64E140AC */   sw        $zero, %lo(D_8011E164)($v0)
    /* A9C1C 800B941C 1000BF8F */  lw         $ra, 0x10($sp)
    /* A9C20 800B9420 00000000 */  nop
    /* A9C24 800B9424 0800E003 */  jr         $ra
    /* A9C28 800B9428 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DeInitArtResources__Fv
