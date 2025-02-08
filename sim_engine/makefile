TARGET_SYS = top
TARGET_SIM = top
VSRC_SIM = $(shell find ./vsrc_sim -name *.v) \
       $(shell find ./vsrc_sim -name *.sv) 
VSRC_SYS = $(shell find ./vsrc_sys -name *.v) \
       $(shell find ./vsrc_sys -name *.sv) 

CSRC_SIM = $(shell find ./csrc_sim -name *.cpp) \
		$(shell find ./csrc_sim/ncnn -name *.cpp) \
		$(shell find ./csrc_sim/layer -name *.cpp) \
       $(shell find ./csrc_sim/net -name *.cpp)
INC_SIM = -I./csrc_sim/hw -I./csrc_sim/net  -I./csrc_sim/ncnn -I./csrc_sim/layer

CSRC_SYS = $(shell find ./csrc_sys -name *.cpp) \
		$(shell find ./csrc_sys/ncnn -name *.cpp) \
		$(shell find ./csrc_sys/layer -name *.cpp) \
       $(shell find ./csrc_sys/net -name *.cpp)
INC_SYS = -I./csrc_sys/hw -I./csrc_sys/net  -I./csrc_sys/ncnn -I./csrc_sys/layer
# all: $(CSRC)
# 	@echo "[ log ]: Compiling..."
# 	g++ -fopenmp -std=c++0x -w -g $^ -o top_sim
	
# 	@echo "[ log ]: Compiling finish!"
# 	@echo "[ log ]: Excute begin..."
# 	./top_sim
# 	@echo "[ log ]: Excute successful..."
parallel_veri_sim:
	make veri_sim -j$(shell nproc)

veri_sim: $(CSRC_SIM) $(VSRC_SIM)
	rm -rf log.txt
	@echo "[ log ]: Compiling Verilator..."
	
	verilator -Wno-fatal $^ $(INC_SIM)   --top-module $(TARGET_SIM) --cc --exe --build --trace --CFLAGS -O2 --threads 12
	@# verilator  -O2 -Wno-fatal $^ $(INC_SIM)   --top-module $(TARGET_SIM) --cc --exe --build --trace --threads 4
	@# verilator -O3 -Wno-fatal $^ $(INC_SIM)   --top-module $(TARGET_SIM) --cc --exe --build --trace --CFLAGS -O2 --threads 4
	@# verilator -Wno-fatal $^ $(INC_SIM)   --top-module $(TARGET_SIM) --cc --exe --build --trace --LDFLAGS -fsanitize=address --CFLAGS -fsanitize=address
	
	@echo "[ log ]: Running simulation..."
	./obj_dir/Vtop
	# gdb --args ./obj_dir/Vtop


parallel_veri_sys:
	make veri_sys -j$(shell nproc)

veri_sys: $(CSRC_SYS) $(VSRC_SYS)
	rm -rf log.txt
	@echo "[ log ]: Compiling Verilator..."
	
	verilator -Wno-fatal $^ $(INC_SYS)   --top-module $(TARGET_SYS) --cc --exe --build --trace --CFLAGS -O2 --threads 12
	@# verilator  -O2 -Wno-fatal $^ $(INC_SYS)   --top-module $(TARGET_SYS) --cc --exe --build --trace --threads 4
	@# verilator -O3 -Wno-fatal $^ $(INC_SYS)   --top-module $(TARGET_SYS) --cc --exe --build --trace --CFLAGS -O2 --threads 4
	@# verilator -Wno-fatal $^ $(INC_SYS)   --top-module $(TARGET_SYS) --cc --exe --build --trace --LDFLAGS -fsanitize=address --CFLAGS -fsanitize=address
	
	@echo "[ log ]: Running simulation..."
	./obj_dir/Vtop
	# gdb --args ./obj_dir/Vtop
