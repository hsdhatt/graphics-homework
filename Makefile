CCPP = g++
CC = gcc
ifeq ($(shell sw_vers 2>/dev/null | grep Mac | awk '{ print $$2}'),Mac)
	CFLAGS = -g -DGL_GLEXT_PROTOTYPES -I./include/ -I/usr/X11/include -I/home/harshdeep/Downloads/freeglut-3.0.0/include -DOSX
	LDFLAGS = -framework GLUT -framework OpenGL -L./lib/mac/  \
    	-L"/System/Library/Frameworks/OpenGL.framework/Libraries" \
    	-lGL -lGLU -lm -lstdc++ -lGLEW -lfreeimage 
else
	CFLAGS = -g -DGL_GLEXT_PROTOTYPES -I./include/ -I/usr/X11R6/include -I/sw/include \
					 -I/usr/sww/include -I/usr/sww/pkg/Mesa/include -I/home/harshdeep/Downloads/freeglut-3.0.0/include
	LDFLAGS = -L./lib/nix -L/usr/X11R6/lib -L/sw/lib -L/usr/sww/lib \
						-L/usr/sww/bin -L/usr/sww/pkg/Mesa/lib -L/home/harshdeep/Downloads/freeglut-3.0.0/lib -lglut -lGLU -lGL -lX11 -lGLEW -lfreeimage
endif
	
RM = /bin/rm -f 

all: mytest3
mytest3: mytest3.o shaders.o shaders.h geometry3.h
	$(CCPP) $(CFLAGS) -o mytest3 shaders.o mytest3.o $(INCFLAGS) $(LDFLAGS) 
mytest3.o: mytest3.cpp shaders.h geometry3.h
	$(CCPP) $(CFLAGS) $(INCFLAGS) -c mytest3.cpp
shaders.o: shaders.cpp
	$(CCPP) $(CFLAGS) $(INCFLAGS) -c shaders.cpp
teapot: teapot.o
	$(CC) $(CFLAGS) -o teapot teapot.o $(INCFLAGS) -L/home/harshdeep/Downloads/freeglut-3.0.0/lib -L/usr/lib/x86_64-linux-gnu/mesa -lGL -lglut
teapot.o: teapot.c
	$(CC) $(CFLAGS) $(INCFLAGS) -c teapot.c
clean: 
	$(RM) *.o mytest3 *.png


 
