use strict;

my $lstlisting=0;

while (<>) {
	my $line = $_;
	if (m/%DIFDELCMD\s+<\s+\\begin{lstlisting}/) {
		$lstlisting=1;
		$line =~s/%DIFDELCMD\s+</{\\lstset{escapechar=\\\$} /;
	}
	if ($lstlisting) {
		$line =~ s/%DIFDELCMD\s+< //;
		if (not $line =~ m/\\(?:begin|end){lstlisting}/) {
			$line =~ s/([#&{} ])/\\$1/g;
			$line =~ s/(.*)/\$\\DIFdel{$1}\$/;
		}
		#print "%FIXED BY RULE 1\n";
	}

	# Too many \color directives (generated by DIFdel/addbegin/end)
	# confuse xetex, producing errors:
	# WARNING ** Color stack overflow. Just ignore.
	# and resulting in corrupted color in output.
	# As a work-around, detect cases where it's safe, and replace \color with
	# \textcolor.
	# As a result, number of \color directives goes does sufficiently
	# enough to avoid the overflow error.

	s/\\DIFdelbegin \\DIFdel{([^}]*)}\\DIFdelend/\\DIFdeltext{$1}/;
	s/\\DIFaddbegin \\DIFadd{([^}]*)}\\DIFaddend/\\DIFaddtext{$1}/;

	print $line;
	if (m/%DIFDELCMD\s+<\s+\\end{lstlisting}/) {
		print "}\n";
		$lstlisting=0;
	}
}
