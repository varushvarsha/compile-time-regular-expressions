.PHONY: default all clean grammar compare single-header single-header/ctre.hpp single-header/ctre-unicode.hpp single-header/unicode-db.hpp

TARGET := main #$(wildcard tests/benchmark-exec/*.cpp)

CXX := g++-10
CXX_STANDARD := 20

CXXFLAGS := $(CXXFLAGS) -std=gnu++$(CXX_STANDARD) -fsanitize=address -I./include -O3 -pedantic -Wall -Wextra -Werror
LDFLAGS := -lasan -lm -lpthread

OBJECTS := $(TARGETS:%.cpp=%.o) $(TESTS:%.cpp=%.o)
override OBJECTS := $(filter-out $(IGNORE:%.cpp=%.o),$(OBJECTS))
DEPEDENCY_FILES := $(OBJECTS:%.o=%.d)

all: $(TARGET) $(OBJECTS)

$(OBJECTS): %.o: %.cpp
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $@

clean:
	rm -f *~ $(TARGET) $(OBJECTS)
