/* eac_codec.h -- EACPSXZ codec group.
 *
 * Decompressors (Huffman, B-tree, RefPack) and CRC-16.
 *
 * A convenience aggregate: it only includes the owner headers, one per archive
 * member, so every declaration keeps its owning module.  Include this when a TU
 * wants the whole group, or the individual owner header when it wants one module.
 *
 * Members (4): crc unbtree unhuff unref
 */
#ifndef _EAC_CODEC_H_
#define _EAC_CODEC_H_

#include "crc.h"
#include "unbtree.h"
#include "unhuff.h"
#include "unref.h"

#endif
