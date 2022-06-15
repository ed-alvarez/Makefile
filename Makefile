## +--------------------------------------------------------------------+
## The purpose of this Makefile is to serve as a template for future
## development. Help comments are displayed in the order defined within 
## the Makefile.
## 
## Help output can be written down by simply defining comments using: ##
## (double numerals). e.g:
## 
## ╔═════════   Makefile   ═════════╗
## ║  ...                           ║
## ║  run:  ## Run finished build   ║
## ║      @$(BUILDDIR)/$(TARGET)    ║
## ║  ...                           ║
## ╚════════════════════════════════╝
## 
## Running "make" without parameters will build the main target into
## your current "$(BUILDIR)" directory.
## 
## If you wish to supress this message, simply remove it from the source.
## +--------------------------------------------------------------------+
## 

CXX = g++
CXXFLAGS = -std=c++20 -g -Wall
LDFLAGS = # My libs

TARGET = Executable_Name

OBJDIR = obj
SRCDIR = src
INCDIRS = inc

BUILDDIR = build

INC=$(INCDIRS:%=-I%)
SRC := $(shell find $(SRCDIR) -name "*.cpp")
OBJ := $(SRC:%.cpp=$(OBJDIR)/%.o)

C_WHITE := "\e[1;37m"

M_RESET := "\e[0m"

M_OK := "\e[1;32mOK"
M_ERR := "\e[1;31mERROR"
M_DBUG := "\e[1;35mDEBUG"

define log_cli
	@echo $(M_$1)$(M_RESET) "=>" $2
endef

all: $(TARGET)

$(TARGET): $(OBJ)
	$(call log_cli,DBUG, "LINKING EXECUTABLE $(TARGET)")

	@mkdir -p $(BUILDDIR)
	$(CXX) $^ $(LDFLAGS) -o $(BUILDDIR)/$(TARGET)

$(OBJDIR)/%.o: %.cpp
	$(call log_cli,DBUG, "COMPILING SOURCE $< INTO OBJECT $@")

	@mkdir -p $(@D)
	$(CXX) -c $(CXXFLAGS) -I./inc $< -o $@

help:	## Show available commands.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

run:	## Run finished build
	@$(BUILDDIR)/$(TARGET)

clean:	## Clean build folder and other temporary files
	@find . -name *.o -delete
	@rm -f $(BUILDDIR)/$(TARGET)

	$(call log_cli,OK, Cleaned builds)
