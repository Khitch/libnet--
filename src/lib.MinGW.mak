############################
# Makefile for MSYS + MinGW
############################
# GNU C++ Compiler
CC=g++

SRCDIR=src
BUILD=build

# -mconsole: Create a console application
# -mwindows: Create a GUI application
# -Wl,--enable-auto-import: Let the ld.exe linker automatically import from libraries
LDFLAGS= -mconsole -Wl,--enable-auto-import

#Minimum Windows version: Windows XP, IE 6.01
CPPFLAGS= -DMINGW -D_WIN32_WINNT=0x0500 -DWINVER=0x0500 -D_WIN32_IE=0x0601

#SRC files in SRCDIR directory
SRC=$(addprefix $(SRCDIR)/, $(SRCFILES))

# Choose object file names from source file names
OBJFILES=$(SRCFILES:.cpp=.o)
OBJ=$(addprefix $(BUILD)/, $(OBJFILES))

# All warnings, optimization level 3
CFLAGS=-Wall -O3

# Default target of make is "all"
.all: all      
all: $(BIN) $(LIBBIN)

# Build object files with chosen options
$(BUILD)/%.o: $(SRCDIR)/%.cpp
	$(CC) $(CFLAGS) $(CPPFLAGS) $(INCLUDES) -o $@ -c $<

# Uncomment to build a binary instead of a library!
# Build executable from objects and libraries to current directory
#$(BIN): $(OBJ)
#	$(CC) $^ $(LDFLAGS) $(LIBS) -o $@

# Build library
$(BIN): $(OBJ)
	ar r $@ $^
	ranlib $@
	
# Remove object files and core files with "clean" (- prevents errors from exiting)
RM=rm -f
.clean: clean
clean:
	-$(RM) $(BIN) $(OBJ) core
