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

ex: make run top_module=dma_top arg="+UVM_TESTNAME=Interrupt_test"

#compilation with coverage:
make compile_with_cov top_file=<top_file>

ex: make compile_with_cov top_file=dma_top.sv

#simulation with coverage
make run_with_cov top_module=<module_name> arg="+UVM_TESTNAME=<testname>"

ex: make run_with_cov top_module=dma_top arg="+UVM_TESTNAME=Interrupt_test"

# Wavefrom:  
make view &

# Clean:
make clean

#Regression
python3 regression.py

```
