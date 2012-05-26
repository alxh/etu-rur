#!perl -w

use strict;

## Lecture du fichier
use File::Slurp;
my $text = read_file( 'auteurs.csv' );
my @text = split "\n", $text; # de chaine à tableau
shift @text; # enleve la ligne "AUT1 AUT2 AUT3 AUT4"

## Analyse
my @list_auteurs; # tableau de sortie, des auteurs avec cpte double
foreach my $ligne ( @text ) {
	while ( $ligne =~ /^(.*?)\,(.*)$/ ){
		push @list_auteurs, $1;
		$ligne = $2;
	}	push @list_auteurs, $ligne;
}

## Compte
my %compteur;
foreach my $auteur ( @list_auteurs ) { $compteur{$auteur}++; }
## Tri par compte décroissant
my @aut_tri = sort { $compteur{$b} <=> $compteur{$a} } keys %compteur;

## Affichage
foreach ( @aut_tri ) {print $_, "\t", $compteur{$_}, "\n"; }