/* eac_system.h -- EACPSXZ system group.
 *
 * Timers, the tick counters, system tasks, threads, mutexes, exit hooks and
 * the $gp save/restore pair.
 *
 * A convenience aggregate: it only includes the owner headers, one per archive
 * member, so every declaration keeps its owning module.  Include this when a TU
 * wants the whole group, or the individual owner header when it wants one module.
 *
 * Members (10): addtimer callback devsys exit inittmr joystkn savegp systask threads
 *          timer
 */
#ifndef _EAC_SYSTEM_H_
#define _EAC_SYSTEM_H_

#include "addtimer.h"
#include "callback.h"
#include "devsys.h"
#include "exit.h"
#include "inittmr.h"
#include "joystkn.h"
#include "savegp.h"
#include "systask.h"
#include "threads.h"
#include "timer.h"

#endif
