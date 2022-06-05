CXX = g++
CXXFLAGS = -g -Wall
LDFLAGS = -L

TARGET = CPP_Sand

OBJDIR = ./obj
SRCDIR = ./src
INCDIR = ./inc

BUILDDIR = ./build

LDFLAGS += $(INCDIR)

SRC := $(shell find $(SRCDIR) -name "*.cpp")
OBJ := $(SRC:%.cpp=$(OBJDIR)/%.o)

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
	@$(CXX) $^ $(LDFLAGS) -o $(BUILDDIR)/$(TARGET)

$(OBJDIR)/%.o: %.cpp
	$(call log_cli,DBUG, "COMPILING SOURCE $< INTO OBJECT $@")

	@mkdir -p $(@D)
	@$(CXX) -c $(CXXFLAGS) $< -o $@

run:
	@$(BUILDDIR)/$(TARGET)

BUILD_PRINT = "\e[1;34mBuilding $<\e[0m"

clean:
	@find . -name *.o -delete
	@rm -f $(BUILDDIR)/$(TARGET)

	$(call log_cli,OK, Cleaned builds)
