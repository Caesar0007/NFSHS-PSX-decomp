/* game/common/anim_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_ANIM_EXTERNS_H_
#define _GAME_COMMON_ANIM_EXTERNS_H_
char *Platform_GetDCTBuffer(int, char *); void Platform_ResetDCTBuffer();
extern Group              *gPersistObjInst;          /* track.obj */
extern int Anim_simGlobalWords[] __asm__("simGlobal");
extern void  Quatern_QuatToMat(tQuat *q, matrixtdef *m);     /* quatern.obj */
extern void *__builtin_vec_new(unsigned int size);
extern void DrawW_ResetAnimationTimer(void);
extern void Quatern_Interpolate(tQuat *q0,tQuat *q1,coorddef *cp0,coorddef *cp1,int weight,tQuat *q,coorddef *cp);
extern void Quatern_VecInterpolate(coorddef *cp0,coorddef *cp1,int weight,coorddef *cp);
extern void __builtin_vec_delete(void *deleteMe);
extern void __builtin_delete(void *deleteMe);

extern "C" {
void blockmove(void *source, void *destination, int size);
int filesize(char *filename);
void *loadfileadrz(char *filename, void *destination);
void *locatebig(void *archive, char *filename);
int purgememadr(void *ptr);
int sprintf(char *buffer, const char *format, ...);
char *strstr(const char *haystack, const char *needle);
}

#endif /* _GAME_COMMON_ANIM_EXTERNS_H_ */
