/* SPEECH.H -- typed public interface for the recovered Speech class.
 * The including owner provides the basic game/PsyQ scalar types. The class
 * declaration remains in the shared type surface while that include graph is
 * restored; encoded linker names are not extra free-function source APIs. */
#ifndef _GAME_COMMON_SPEECH_H_
#define _GAME_COMMON_SPEECH_H_
#include "speech_class.h"

char *Speech_AllocateRAM(long numBytes, char *message);
void Speech_PurgeRAM(char *memPtr);
long Speech_HandleRequest(long bank, long localoffset, long size, long event);
void Speech_Server(void);

#endif /* _GAME_COMMON_SPEECH_H_ */
