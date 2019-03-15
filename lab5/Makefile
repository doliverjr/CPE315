CXX = g++
CXXFLAGS = -g -Wall -O3
CXXSRCS = matmul.cpp matmul-driver.cpp 
CXXSRCS_BColMaj = matmul_BColMaj.cpp matmul-driver.cpp 
CXXSRCS_Tile16 = matmul_Tile16.cpp matmul-driver.cpp 
CXXSRCS_Tile32 = matmul_Tile32.cpp matmul-driver.cpp 
BIN = mm
BIN_BColMaj = mm_BColMaj
BIN_Tile16 = mm_Tile16
BIN_Tile32 = mm_Tile32

all:
	$(CXX) $(CXXFLAGS) -c $(CXXSRCS)
	$(CXX) $(CXXFLAGS) -o $(BIN) *.o
	make clean

BColMaj:
	$(CXX) $(CXXFLAGS) -c $(CXXSRCS_BColMaj)
	$(CXX) $(CXXFLAGS) -o $(BIN_BColMaj) *.o
	make clean

Tile16:
	$(CXX) $(CXXFLAGS) -c $(CXXSRCS_Tile16)
	$(CXX) $(CXXFLAGS) -o $(BIN_Tile16) *.o
	make clean

Tile32:
	$(CXX) $(CXXFLAGS) -c $(CXXSRCS_Tile32)
	$(CXX) $(CXXFLAGS) -o $(BIN_Tile32) *.o
	make clean

clean:
	rm -f *.o
