/* psxfront_screen_late.h -- PSXFront.obj owner hook (NFS4_COLOR_HOOK_AFTER_CAR): retail records tShapeInformation right after
 * Car_tObj, so tScreen (which holds two tShapeInformation by value) is defined there too (FRONTORD3 fe_screen_late.h lever). */
#include "../../shared/tActiveLine.h"
#include "../../shared/tShapeInformation.h"
#include "../common/fescreen.h"
