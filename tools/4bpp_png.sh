function to4bpp()
{
	echo "args: $1"
	nfile="$1""4bpp"
	echo "outp: $nfile"
	pngtopnm "$1" | pnmquant 4 | pnmtopng > nfile
}

to4bpp $1
