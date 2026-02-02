#DMA_RAL
```bash
# Running the test
Using Questasim simulator
cd DMA_RAL/sim/

# Compilation:  
make compile top_file=<top_file>

ex: make run top_module=dma_top

# Simulation:
make run top_module=<module_name> arg="+UVM_TESTNAME=<testname>"

ex: make run top_module=dma_top arg="+TESTNAME=Interrupt_test"

# Wavefrom:  
make view &

# Clean:
make clean
```
