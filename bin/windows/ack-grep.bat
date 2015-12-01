@echo off
set file=%~dp0
set arg=%*
set file=%file:~0,-1%
perl %file%\ack-1.96-single-file.pl %arg:-s=%
