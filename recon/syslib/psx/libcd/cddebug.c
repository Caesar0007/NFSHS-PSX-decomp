/* The command/interrupt debug tables belong to libcd's single BIOS.OBJ, not
 * to a separate cddebug object.  Their definitions live beside the driver
 * body in drv.c so GCC can reproduce BIOS.OBJ's one contiguous .rdata/.data
 * layout.  This intentionally empty compatibility TU remains in the source
 * manifest until the build orchestrator removes the historical split. */


