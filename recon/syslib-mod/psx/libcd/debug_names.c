/* Compatibility storage for the exact public SYS.obj implementation.
 *
 * NFS4 never calls the link-stripped CdComstr/CdIntstr debug helpers and the
 * compact driver compiles all diagnostic printing out.  Keeping zeroed pointer
 * tables satisfies SYS.obj without pulling the 3.5 KiB retail BIOS.obj solely
 * for its human-readable command strings.
 */

char *CD_comstr[32];
char *CD_intstr[7];
