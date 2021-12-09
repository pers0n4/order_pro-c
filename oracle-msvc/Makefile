#/bin/make
###############################################################################
#                       Make file for PROC
###############################################################################
#  Usage :
# For compiling proc
#    make
#
# For precompiling, compiling & linking the main.pc file
#    make build EXE=main OBJS=main.o
#
# In general, for any proc program
#    make build EXE=<exename> OBJS="<list of dependent objs>"
#
#    To make use of any PROC options during precompilation,
#        make build PROCFLAGS="<list of proc options>"
#            EXE=<exename> OBJS="<list of dependent objs>"
#
# NOTES:
#    1. Please change "cc/CC" and the "InstantClient directories" to point to
#       appropiate locations on your machine before using this makefile.
#    2. In case of RPM installation, please change the following variables
#       as mentioned below:
#         PROC=/usr/lib/oracle/VV.v/client/bin/proc
#         CCINCLUDES=$(I_SYM)/usr/include/oracle/VV.v/client
#         PRECOMPPUBH=/usr/include/oracle/VV.v/client
#         ICLIBHOME=/usr/lib/oracle/21/client64/lib
#       Legend:
#         VV - Major Oracle version number
#          v - Minor Oracle version number
#         (Ex:  For the release 11.2, VV = 11 and v = 2)
#
###############################################################################


CC=/usr/bin/gcc
cc=/usr/bin/gcc

# InstantClient Directories.
ICSDKHOME=/usr/include/oracle/21/client64
ICLIBHOME=/usr/lib/oracle/21/client64

MKLINK=ln
REMOVE=rm -rf
CLNCACHE=cleancache
CACHEDIR=SunWS_cachea
MAKE=make
MAKEFILE=Makefile
PROJECT=main

PROC=$(ICLIBHOME)/bin/proc
SO_EXT=.so
I_SYM=-I

CCINCLUDES= $(I_SYM)$(ICSDKHOME)

# Pre-compiler Flags.
PRECOMPPUBH=$(ICSDKHOME)

# Compiler Flags.
OPTIMIZE=-O2
LDPATHFLAG=-L
SPFLAGS=-DLINUX -D_GNU_SOURCE -D_LARGEFILE64_SOURCE=1 -D_LARGEFILE_SOURCE=1 -DSLTS_ENABLE -DSLMXMX_ENABLE -D_REENTRANT -DNS_THREADS
CCFLAGS= -fPIC -DPRECOMP
LDFLAGS=-g
LPFLAGS=
GFLAG=
CDEBUG=
USRFLAGS=
ICLIBPATH=$(LDPATHFLAG)$(ICLIBHOME)/lib
PFLAGS=$(CCINCLUDES) $(SPFLAGS) $(LPFLAGS)
CFLAGS=$(GFLAG) $(OPTIMIZE) $(CDEBUG) $(CCFLAGS) $(PFLAGS) $(USRFLAGS)

# Libraries.
PROLDLIBS=$(LDCLIENTLIBS) $(THREADLIBS)
LDCLIENTLIBS=$(ICLIBPATH) $(LLIBCLNTSH) $(LDLIBS)
LLIBCLNTSH=$(LDLIBFLAG)$(LIBCLNTSHNAME)
LDLIBFLAG=-l
LIBCLNTCORENAME=clntshcore
LIBCLNTSHNAME=clntsh
LDLIBS=$(EXSYSLIBS) $(MATHLIB) $(USRLIBS)
EXSYSLIBS=-ldl
MATHLIB=-lm
THREADLIBS=-lpthread

C2O=$(CC) $(CFLAGS) -c $*.c
PCC2C=$(PROC) $(PROCFLAGS) iname=$(PCCSRC)
PROC_BUILD=$(CC) -o $(EXE) $(OBJS) $(LDFLAGS) $(PROLDLIBS)
PROC_SOURCES=database
C_SOURCES=terminal

#-----------------------------------------------------------------------------
# Targets for building the proc sample programs.
all: clean $(PROJECT)

$(PROJECT):
	$(MAKE) -f $(MAKEFILE) build OBJS="$@.o $(addsuffix .o,$(C_SOURCES) $(PROC_SOURCES))" EXE=$@

build: $(CLNCACHE) $(OBJS)
	$(PROC_BUILD)

#-----------------------------------------------------------------------------
# Here are some rules for converting .pc -> .c -> .o
.SUFFIXES: .pc .c .o

pc1:
	$(PCC2C)

.pc.c:
	$(MAKE) -f $(MAKEFILE) PROCFLAGS="$(PROCFLAGS)" PCCSRC=$* I_SYM=include= pc1

.pc.o:
	$(MAKE) -f $(MAKEFILE) PROCFLAGS="$(PROCFLAGS)" PCCSRC=$* I_SYM=include= pc1
	$(C2O)

.c.o:
	$(C2O)

#-----------------------------------------------------------------------------
# Clean up all executables, *.o and generated *.c files
clean: $(CLNCACHE)
	$(REMOVE) $(PROJECT) $(PROJECT).o $(PROJECT).c $(PROJECT).lis
	$(REMOVE) $(addsuffix .o,$(C_SOURCES) $(PROC_SOURCES)) $(addsuffix .c,$(PROC_SOURCES)) $(addsuffix .lis,$(PROC_SOURCES))

cleancache:
	$(REMOVE) $(CACHEDIR)
