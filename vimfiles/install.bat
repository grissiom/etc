del /S c:%HOMEPATH%\vimfiles
mkdir c:%HOMEPATH%\vimfiles
robocopy . c:%HOMEPATH%\vimfiles /MIR
copy vimrc c:%HOMEPATH%\_vimrc
del c:%HOMEPATH%\install.bat
