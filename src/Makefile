# Makefile for running the design using iverilog
# and gtkwave for viewing outputs

# INPUTS FOR TOOL
SRC_DIR = src
TESTBENCH = test
OUTPUT_PATH = output

#Source files
SRC_FILES = ARMLEGvtf.v

#COMPILER SETUP 
COMPILER = iverilog
SIMULATOR = vvp
VIEWER = gtkwave
WAVE_NAME = ARMLEGvtf.vcd

#COMPILER OPTIONS
FLAGS = -o

#TOOL OUTPUT
COUTPUT = ARM_LEG_SIM.out

###############################################
# runs simulation
simulate: 
	$(COMPILER) $(FLAGS) $(COUTPUT) $(SRC_FILES)


run: simulate
	vvp $(COUTPUT)

# Views the waveform using gtkwave
display: run
	$(VIEWER) $(WAVE_NAME)

#removes output files
clean: 
		rm *.vcd
		rm *.out

#Create output directory if it does not exist
$(OUTPUT_PATH):
	mkdir -p ../$(OUTPUT_PATH)