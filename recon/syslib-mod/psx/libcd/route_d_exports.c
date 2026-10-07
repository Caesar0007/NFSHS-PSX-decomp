/* Storage exports needed only by the clean Route-D source relink.
 *
 * The retail-slot patch binds core_api's references to EVENT.OBJ's original
 * fixed-address cells.  A source relink omits EVENT.OBJ, so it owns the same
 * two public words here.  Keeping this TU out of build_cd_objects.py avoids
 * wasting resident store bytes in the proven fixed-address build.
 */

int CD_cbread = 0;
int CD_read_dma_mode = 0;
