#ifndef _SNDPSXZ_SST_H_
#define _SNDPSXZ_SST_H_

struct SNDPLAYOPTS;
struct SndStream;
struct SndStreamChunkHeaderPrefix;

extern int iSNDstreamdestroyall(void); /* @0x800E8C14 */
extern struct SndStream *iSNDstreamgetstreamptr(int idx); /* @0x800E8C48 */ /* sst */
extern void iSNDstreamremoverequest(unsigned int reqid); /* @0x800E8C64 */
extern void iSNDstreamreleasecallback(unsigned char *sample); /* @0x800E8D90 */
extern void iSNDstreamnotifycallback(int handle, unsigned int bytes); /* @0x800E8DD4 */
extern int iSNDstreamparseheader(struct SndStream *S, struct SndStreamChunkHeaderPrefix *data); /* @0x800E8E9C */
extern int iSNDstreamparsenumchunks(struct SndStream *S, struct SndStreamChunkHeaderPrefix *data); /* @0x800E9044 */
extern int iSNDstreamparsedata(struct SndStream *S, struct SndStreamChunkHeaderPrefix *chunk); /* @0x800E90AC (oracle: always returns 1) */
extern int iSNDstreamparseend(struct SndStream *S, unsigned char *chunk); /* @0x800E9230 */
extern int iSNDstreamparsechunk(struct SndStream *S, unsigned char *chunk); /* @0x800E9270 */
extern int iSNDstreamisheld(struct SndStream *S); /* @0x800E9318 */
extern void iSNDstreamhotroddatachunks(void); /* sst */ /* @0x800E9438 */
extern void iSNDstreamservice(void); /* @0x800E9590 (serve hook) */ /* @0x800E9590 */
extern int iSNDstreamnumcreated(void); /* @0x800E96F8 */
extern int iSNDstreamcreate(struct SNDPLAYOPTS *priority, int numReq, int pktArg, char *objbuf, int memsize, int extHandle, int extFlag); /* @0x800E9730 */
extern int iSNDstreamqueue(unsigned int s, int name, char *filename, int off, int mode); /* @0x800E9970 */

extern struct SndStream *sndss[];
extern unsigned char sndStreamMap[];

#endif /* _SNDPSXZ_SST_H_ */
