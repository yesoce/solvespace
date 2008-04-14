DEFINES = /D_WIN32_WINNT=0x500 /DISOLATION_AWARE_ENABLED /D_WIN32_IE=0x500 /DWIN32_LEAN_AND_MEAN /DWIN32
CFLAGS  = /W3 /nologo -I..\common\win32 /O2 /D_DEBUG /D_CRT_SECURE_NO_WARNINGS /Zi /I.

HEADERS = ..\common\win32\freeze.h ui.h solvespace.h dsc.h sketch.h expr.h

OBJDIR = obj

FREEZE   = $(OBJDIR)\freeze.obj

W32OBJS  = $(OBJDIR)\w32main.obj \

SSOBJS   = $(OBJDIR)\solvespace.obj \
           $(OBJDIR)\textwin.obj \
           $(OBJDIR)\graphicswin.obj \
           $(OBJDIR)\util.obj \
           $(OBJDIR)\entity.obj \
           $(OBJDIR)\sketch.obj \
           $(OBJDIR)\glhelper.obj \
           $(OBJDIR)\expr.obj \
           $(OBJDIR)\constraint.obj \
           $(OBJDIR)\drawconstraint.obj \


LIBS = user32.lib gdi32.lib comctl32.lib advapi32.lib opengl32.lib glu32.lib

all: $(OBJDIR)/solvespace.exe
    @cp $(OBJDIR)/solvespace.exe .
    solvespace

clean:
	rm -f obj/*

$(OBJDIR)/solvespace.exe: $(SSOBJS) $(W32OBJS) $(FREEZE)
    @$(CC) $(DEFINES) $(CFLAGS) -Fe$(OBJDIR)/solvespace.exe $(SSOBJS) $(W32OBJS) $(FREEZE) $(LIBS)
    @echo solvespace.exe

$(SSOBJS): $(@B).cpp $(HEADERS)
    @$(CC) $(CFLAGS) $(DEFINES) -c -Fo$(OBJDIR)/$(@B).obj $(@B).cpp

$(W32OBJS): win32/$(@B).cpp $(HEADERS)
    @$(CC) $(CFLAGS) $(DEFINES) -c -Fo$(OBJDIR)/$(@B).obj win32/$(@B).cpp

$(FREEZE): ..\common\win32\$(@B).cpp $(HEADERS)
    @$(CC) $(CFLAGS) $(DEFINES) -c -Fo$(OBJDIR)/$(@B).obj ..\common\win32\$(@B).cpp
