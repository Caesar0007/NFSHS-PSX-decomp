/* game/common/nfs3.h — reconstructed from game/common/nfs3.cpp (11 fns) */
#ifndef _GAME_COMMON_NFS3_H_
#define _GAME_COMMON_NFS3_H_
#include "../../nfs4_types.h"

/* P875: native signatures and defining exports verified by typed-reference
 * probes. Source names let the compiler emit the original C++ linkage. */

void Nfs2_SystemNLibStartUp(void);   /* :118 */
void Nfs2_BefuddleCode(void);   /* :178 */
void Nfs2_ResetGame(void);   /* :186 */
/* NFS4_LoadPerps is native STAT (2c698e); private to nfs3.cpp. */
void Nfs2_GameModuleStartUp(int *FrontEndDataStream);   /* :357 */
void Nfs2_CleanUpGameModule(void);   /* :464 */
void LoadFrontendOverlay(void);   /* :560 */
void LoadOverlay(void);   /* :589 */
void NFS4_LoadingIcon(void);   /* :626 */
void NFS3_CheckForFileOperations(void);   /* :686 */
int main(void);   /* :703 */

#endif /* _GAME_COMMON_NFS3_H_ */
