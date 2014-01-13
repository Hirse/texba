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
texify --pdf document.tex
MOVE /y document.pdf ../"%pdfname%"
CD ..