/* Resident restore loader for the syslib race overlay.  This object must be linked outside every
 * range named by race_reclaim*.json.  Payload entries copy retail code/rodata/data; zero entries
 * reconstruct BSS.  The blob is trusted only after host/build-time SHA/CRC validation. */
typedef unsigned int u32;
typedef unsigned char u8;
typedef struct { char magic[4]; u32 version,count,table_bytes,payload_bytes; } RestoreHeader;
typedef struct { u32 address,size,flags,offset,crc32,name_crc32; } RestoreEntry;
typedef struct { char magic[4]; u32 version,count; } DynamicHeader;
#include "overlay_arena_table.inc"
extern void FlushCache(void);
extern void EnterCriticalSection(void);
extern void ExitCriticalSection(void);
extern int asyncloadfileat(char *name,void *dest);
extern int getasyncreadstatus(int handle);
extern unsigned int systemtask(int mode);
extern int unrefpack(unsigned char *source,unsigned char *dest,int reverse);
extern void AudioCmn_DeInit(void);
static void copy_bytes(u8 *dst,const u8 *src,u32 size){while(size--)*dst++=*src++;}
static void zero_bytes(u8 *dst,u32 size){while(size--)*dst++=0;}
void SyslibMod_ArenaReset(void){*(volatile u32 *)0x80140DBC=0;*(volatile u32 *)0x80140DC0=0;}
void *SyslibMod_ArenaAlloc(u32 size,u32 align)
{
 volatile u32 *index=(volatile u32 *)0x80140DBC,*used=(volatile u32 *)0x80140DC0;u32 i=*index,n=*used,start,p;
 if(align==0)align=1;
 while(i<SYSLIBMOD_ARENA_COUNT){start=arena_start[i];p=(start+n+align-1)&~(align-1);if(p+size<=start+arena_size[i]){*index=i;*used=p+size-start;return(void *)p;}i++;n=0;}
 return 0;
}
u32 SyslibMod_ArenaCapacity(void){u32 i,total=0;for(i=0;i<SYSLIBMOD_ARENA_COUNT;i++)total+=arena_size[i];return total;}
int SyslibMod_RestoreOverlay(const void *blob)
{
 const RestoreHeader *h=(const RestoreHeader *)blob;const RestoreEntry *e;const u8 *payload;u32 i;
 if(h->magic[0]!='N'||h->magic[1]!='S'||h->magic[2]!='R'||h->magic[3]!='O'||h->version!=1)return 0;
 e=(const RestoreEntry *)(h+1);payload=(const u8 *)e+h->table_bytes;
 for(i=0;i<h->count;i++){
  if(e[i].flags==1)copy_bytes((u8 *)e[i].address,payload+e[i].offset,e[i].size);
  else if(e[i].flags==2)zero_bytes((u8 *)e[i].address,e[i].size);
  else return 0;
 }
 EnterCriticalSection();FlushCache();ExitCriticalSection();return 1;
}

int SyslibMod_SaveDynamic(const void *map,void *snapshot)
{
 const DynamicHeader *h=(const DynamicHeader *)map;const u32 *address=(const u32 *)(h+1);u8 *out=(u8 *)snapshot;u32 i;
 if(h->magic[0]!='N'||h->magic[1]!='S'||h->magic[2]!='D'||h->magic[3]!='Y'||h->version!=1)return 0;
 for(i=0;i<h->count;i++)out[i]=*(volatile u8 *)address[i];
 return (int)h->count;
}
int SyslibMod_RestoreDynamic(const void *map,const void *snapshot)
{
 const DynamicHeader *h=(const DynamicHeader *)map;const u32 *address=(const u32 *)(h+1);const u8 *in=(const u8 *)snapshot;u32 i;
 if(h->magic[0]!='N'||h->magic[1]!='S'||h->magic[2]!='D'||h->magic[3]!='Y'||h->version!=1)return 0;
 for(i=0;i<h->count;i++)*(volatile u8 *)address[i]=in[i];
 return (int)h->count;
}

static const char dynamic_name[]="NFS4.MAP";
static const char restore_name[]="NFS4.SYM";
static int load_async(const char *name,void *dest)
{
 int handle,status;handle=asyncloadfileat((char *)name,dest);if(handle==0)return 0;
 do {status=getasyncreadstatus(handle);if(status==0)systemtask(0);} while(status==0);
 return status>0;
}
int SyslibMod_EnterRace(void)
{
 void *work=(void *)0x80140634;void *snapshot=(void *)0x80140454;volatile int *status=(volatile int *)0x80140DB8;
 if(!load_async(restore_name,(void *)0x80140DC4)){*status=-1;return 0;}
 if(!load_async(dynamic_name,work)){*status=-3;return 0;}
 *status=SyslibMod_SaveDynamic(work,snapshot);SyslibMod_ArenaReset();return *status;
}
int SyslibMod_ExitRace(void)
{
 void *work=(void *)0x80140634;void *snapshot=(void *)0x80140454;volatile int *status=(volatile int *)0x80140DB8;
 if(unrefpack((unsigned char *)0x80140DC4,(unsigned char *)0x80010000,1)!=33368){*status=-2;return 0;}
 if(!SyslibMod_RestoreOverlay((void *)0x80010000))return 0;
 *status=SyslibMod_RestoreDynamic(work,snapshot);return *status;
}
void SyslibMod_CleanupAudioAndRestore(void)
{
 AudioCmn_DeInit();SyslibMod_ExitRace();
}
