#!/bin/sh
# w46-a1 psxfront full-TU gate (24 fns).  Usage: sh scratch/a1_gate.sh [--full]
cd "$(dirname "$0")/.." || exit 1
ALL=CleanupSpinningCars__Fv,CleanupSpinningCarsMenu__Fv,DoLanguageScreen__Fv,DoTitleScreen__Fv,DrawFlatShape__FP18tTexture_ShapeInfoiiiPii,DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii,DrawShapeExtended__FiiiiiiP18tDrawShapeExtended,FontUpsideDownBlit__FiiPviiP12charactertbli,Init_PSX_FrontEnd__Fv,Init_RenderingEnvironment__Fv,InitializeSpinningCars__Fv,LoadAllHelpShapes__Fv,PSXDrawGouraudSquare__Fiiiiiiii,PSXDrawSquare__Fiiiii,PSXDrawTransGouraudSquare__Fiiiiiiiii,PSXDrawTransSquare__Fiiiiis,PSXExitFrontend__Fv,PSXFront_AllocateDrawMemory__Fv,PSXFront_FreeDrawMemory__Fv,PSX_AllocShapes__Fv,Quick_DD__Fiii,ScaleFlatShape__FP18tTexture_ShapeInfoiiiiiPii,ScaleGouraudShape__FP18tTexture_ShapeInfoiiiiiPii,ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
TWO=DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii,FontUpsideDownBlit__FiiPviiP12charactertbli
if [ "$1" = "--full" ]; then N=$ALL; else N=$TWO; fi
python tools/verify_asm.py recon/frontend/psx/psxfront.cpp "$N" 2>&1 | grep -E "PASS|FAIL|NO ORACLE|Error|error"
