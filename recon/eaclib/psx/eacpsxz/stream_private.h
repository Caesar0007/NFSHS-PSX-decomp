/* stream_private.h -- stream.obj internals: the consumer filter slot (stream.c only).
 * Game and frontend code include the public stream.h only. */
#ifndef _STREAM_PRIVATE_H_
#define _STREAM_PRIVATE_H_

#include "stream.h"

typedef struct StreamFilter {
    unsigned int mask;
    unsigned int value;
    unsigned int consumer;
} StreamFilter;

#endif
