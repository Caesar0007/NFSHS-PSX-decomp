.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_ResetCar__FP8Car_tObj, 0xC

glabel AIPhysic_ResetCar__FP8Car_tObj
    /* 5D454 8006CC54 780280AC */  sw         $zero, 0x278($a0)
    /* 5D458 8006CC58 0800E003 */  jr         $ra
    /* 5D45C 8006CC5C 740280AC */   sw        $zero, 0x274($a0)
endlabel AIPhysic_ResetCar__FP8Car_tObj
