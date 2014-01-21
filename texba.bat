@ECHO off
IF EXIST document/filename (
	SET /p pdfname=<document/filename
) ELSE (
	SET /p pdfname=Pdf name [document]: || SET pdfname=document
)
IF %pdfname:~-4% NEQ .pdf (
	SET pdfname=%pdfname%.pdf
)
ECHO %pdfname%>document/filename

CD document
ECHO Generating %pdfname% ...
pdflatex -quiet document
IF EXIST document.glo (
	ECHO Indexing Glossary ...
	makeindex -q -s document.ist -t document.glg -o document.gls document.glo
)
IF EXIST document.acn (
	ECHO Indexing Acronyms ...
	makeindex -q -s document.ist -t document.alg -o document.acr document.acn
)
ECHO Creating Bibliography ...
biber -q document
pdflatex -quiet document
pdflatex -quiet document
ECHO Creating pdf Document ...
pdflatex -quiet document
MOVE /y document.pdf ../"%pdfname%" > NUL
MOVE /y document.log ../texba.log > NUL
IF NOT "%1"=="--keep" (
	ECHO Removing Auxiliary Files ...
	FOR %%i IN (document.*) DO IF NOT %%i == document.tex DEL %%i
)
CD ..
ECHO Finished. Log written to texba.log.
PAUSE > NUL