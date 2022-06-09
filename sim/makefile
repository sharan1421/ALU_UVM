# This is for cadence TOOL
#                                                                         
#------------------------------------------------------------------------------
VERBOSITY = LOW 
TESTNAME  = alu_test
DFORMAT   = shm
SEED      = 1
ASSERT    = ON
#------------------------------------------------------------------------------
                                                                            
#------------------------------------------------------------------------------
comp : 
	    xrun  -64bit -sv -compile -uvm -f filelist.f  -disable_sem2009 +define+TST_NAME=${TESTNAME}
	     
#------------------------------------------------------------------------------
                                                                         
#------------------------------------------------------------------------------
elab : 
	    xrun  -64bit -sv -elaborate -uvm  -f filelist.f -top test  +define+TST_NAME=${TESTNAME}
#------------------------------------------------------------------------------
                                                                             
#------------------------------------------------------------------------------
coel : 
	    irun  -64bit -sv -elaborate -uvm -f filelist.f -top test +define+TST_NAME=${TESTNAME}
#------------------------------------------------------------------------------
                                                                            
#------------------------------------------------------------------------------
sim : 
	    xrun -64bit -sv -uvm -f filelist.f  -access +rwc -top test  +UVM_TESTNAME=${TESTNAME} +UVM_VERBOSITY=UVM_${VERBOSITY} -log ${TESTNAME}_${SEED}.log -disable_sem2009 +define+TST_NAME=${TESTNAME} -seed ${SEED} +UVM_VERBOSITY=UVM_${VERBOSITY} +define+ASSERT_${ASSERT}

#------------------------------------------------------------------------------
                                                                            
#------------------------------------------------------------------------------
run : 
	    xrun -64bit -sv -uvm -f filelist.f  -access +rwc -input ${TESTNAME}_${SEED}.tcl -top test  +UVM_TESTNAME=${TESTNAME} -seed ${SEED} +UVM_VERBOSITY=UVM_${VERBOSITY} -log ${TESTNAME}_${SEED}.log -disable_sem2009 +define+TST_NAME=${TESTNAME} +define+ASSERT_${ASSERT} -warn_multiple_driver 
#------------------------------------------------------------------------------
                                                                             
#------------------------------------------------------------------------------
cov : 
	    xrun -64bit -sv -uvm -f filelist.f -access +rwc -top tb_top  +UVM_TESTNAME=${TESTNAME} -seed ${SEED} +UVM_VERBOSITY=UVM_${VERBOSITY} -log ${TESTNAME}_${SEED}.log -disable_sem2009 +UVM_MAX_QUIT_COUNT=1000  -covscope scope -covwork coverage -coverage all -covtest ${TESTNAME}_${SEED} -covoverwrite +define+TST_NAME=${TESTNAME} +define+ASSERT_${ASSERT}
#------------------------------------------------------------------------------
                                                                       
#------------------------------------------------------------------------------
clean :
	    rm -rf *.log;rm -rf xcelium.d;rm -rf *.history;rm -rf *.shm;rm -rf *.tcl;
			rm -rf *.key;rm -rf *_lib_1;rm -rf *_lib_*;rm -rf *_lib
			rm -rf coverage cov_work INCA_libs

