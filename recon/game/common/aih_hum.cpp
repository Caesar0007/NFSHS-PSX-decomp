/* game/common/aih_hum.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Composition-modeled inheritance (_base_ members); manual _vf vtable dispatch (8-byte
 *   __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "../../nfs4_types.h"
#include "aih_hum_externs.h"


/* ---- HighExecute__12AIHigh_Human  AIHigh_Human::HighExecute  [AIH_HUM.CPP:26-34] SLD-VERIFIED ---- */

void AIHigh_Human::HighExecute()



{

  this->_base_AIHigh_Player.HandleCops();

  (((this->_base_AIHigh_Player)._base_AIHigh_BasicPerp._base_AIHigh_Base.carObj_)->N).active = '\x01';

  ((this->_base_AIHigh_Player)._base_AIHigh_BasicPerp._base_AIHigh_Base.state_)->StateExecute();

  return;

}








/* ---- __12AIHigh_HumanP8Car_tObj  AIHigh_Human::ctor  [AIH_HUM.CPP:38-39] SLD-VERIFIED ---- */
AIHigh_Human::AIHigh_Human(Car_tObj *carObj)



{

  (new(&this->_base_AIHigh_Player) AIHigh_Player(carObj));

  (this->_base_AIHigh_Player)._base_AIHigh_BasicPerp._base_AIHigh_Base._vf =

       (__vtbl_ptr_type (*) [3])AIHigh_Human_vtable;

  return;

}








/* ---- _._12AIHigh_Human  AIHigh_Human::dtor  [AIH_HUM.CPP:?] SLD-FLAG:NO_SLD ---- */

AIHigh_Human::~AIHigh_Human()



{

  (this->_base_AIHigh_Player)._base_AIHigh_BasicPerp._base_AIHigh_Base._vf =

       (__vtbl_ptr_type (*) [3])AIHigh_BasicPerp_vtable;


  return;

}







/* end of aih_hum.cpp */
