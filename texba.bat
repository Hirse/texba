@ECHO off
IF NOT EXIST document\info MKDIR document\info
pdflatex -help >NUL 2>&1
IF %errorlevel%==9009 (
	IF EXIST document/info/path (
		SET /p texpath=<document/info/path
	) ELSE (
		SET /p texpath=Path to MiKTeX bin directory:
		ECHO %texpath%>document/info/path
	)
) ELSE (
	SET texpath=
)
IF EXIST document/info/filename (
	SET /p pdfname=<document/info/filename
) ELSE (
	SET /p pdfname=Pdf name [document]: || SET pdfname=document
)
IF %pdfname:~-4% NEQ .pdf (
	SET pdfname=%pdfname%.pdf
)
ECHO %pdfname%>document/info/filename

CD document
ECHO Generating %pdfname% ...
%texpath%pdflatex -quiet document
IF EXIST document.glo (
	ECHO Indexing Glossary ...
	%texpath%makeindex -q -s document.ist -t document.glg -o document.gls document.glo
)
IF EXIST document.acn (
	ECHO Indexing Acronyms ...
	%texpath%makeindex -q -s document.ist -t document.alg -o document.acr document.acn
)
ECHO Creating Bibliography ...
%texpath%biber -q document
ECHO Creating pdf Document ...
%texpath%pdflatex -quiet document
%texpath%pdflatex -quiet document
%texpath%pdflatex -quiet document
MOVE /y document.pdf ../"%pdfname%" > NUL
MOVE /y document.log ../texba.log > NUL
IF NOT "%1"=="--keep" (
	ECHO Removing Auxiliary Files ...
	FOR %%i IN (document.*) DO IF NOT %%i == document.tex DEL %%i
)
CD ..
ECHO Finished. Log written to texba.log.
start "" "%pdfname%"
::PAUSE > NUL