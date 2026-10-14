/* Consumer declaration of pad.obj's SYM-proven anonymous .63fake object.
 * PAD_COMMON must be visible before inclusion; its source-visible variants
 * remain owner-specific. Original foreign-header visibility is not certified.
 */
#ifndef NFS4_SHARED_PAD_MODULE_GLOBALS_H
#define NFS4_SHARED_PAD_MODULE_GLOBALS_H
extern struct {
    int initialized;
    PAD_COMMON buf[8];
    struct {
        u_char bActive, time;
    } state[8];
} gPadinfo;
#endif
