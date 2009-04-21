@ECHO OFF
IF NOT "%~f0" == "~f0" GOTO :WinNT
@"jruby.bat" "C:/smarteda/trunk/sup/jruby-1.2.0/bin/../bin/autospec" %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO :EOF
:WinNT
@"jruby.bat" "%~dpn0" %*
