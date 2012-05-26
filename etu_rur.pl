#!perl

use strict;
use WWW::Mechanize;
use HTML::TreeBuilder;

#### LIENS SOMMAIRES DES NUMEROS
my $mech = WWW::Mechanize->new( stack_size => 0, autocheck => 0 );
$mech->get('http://etudesrurales.revues.org/');
my @som_links = $mech->find_all_links( url_regex => qr/sommaire/ );

# #### TEST
# my $som = $som_links[2]->url;
#### RUN
open SORTIE, '>>', 'etu_rur.txt';
foreach my $som (@som_links) {

    #### FETCH PAGE
	$mech->get( $som );
	## Decode: voir premières lignes du code source HTML, s'il existe un 'charset = iso-8859-1' par exemple (si non, c'est facile)
	my $t = $mech->response->decoded_content( charset => 'iso-8859-1' );

	#### PARSE
	my $tree = HTML::TreeBuilder->new_from_content($t);

	    #### INFOS SUR LE NUMERO
		## Variables de sortie
	    my %NUM = ( num => 0, titre => '', sous_t => '' );
	    ## Numéro et titre
	    if ( $tree->look_down( _tag => 'h1', class => 'accueil' )->as_text() =~
	        /(\d+)\s+(.*)/s )
	    {
	        $NUM{num}   = $1;
	        $NUM{titre} = $2;
	    }
	    ## Sous-titre
	    if ( $tree->look_down( _tag => 'h1', class => 'som' )->as_text =~
	        /\s+(.*)/s )
	    {
	        $NUM{sous_t} = $1;
	    }
	
	    ## Affichage pour l'utilisateur
	    print "Études rurales\t$NUM{titre}\t$NUM{sous_t}\t$NUM{num}\n";
	
	    #### ARTICLES
	    ## Traitement de chaque article
	    foreach
	      my $art ( $tree->look_down( _tag => 'div', class => 'afficherdocument' ) )
	    {
	        ## Variables de sortie
	        my %ART = ( auteurs => [], titre => '', sous_t => '' );
	        ## Auteurs
	        foreach ( $art->look_down( class => 'auteur' ) ) {
	            foreach ( $_->look_down( class => 'smallcaps' ) ) {
	                push $ART{auteurs}, $_->as_trimmed_text;
	            }
	        }
	        ## Titre et sous-titre
	        if ( $art->look_down( class => 'article' )->as_trimmed_text =~
	            /^\s*(.*?)\[.*?\]\s*(.*)$/s )
	        {
	            $ART{titre}  = $1;
	            $ART{sous_t} = $2;
	        }
	
	        ## Écriture dans le fichier de sortie
	        print SORTIE "Études rurales\t$NUM{titre}\t$NUM{sous_t}\t$NUM{num}\t$ART{titre}\t$ART{sous_t}\t", join "\t", @{ $ART{auteurs} }, "\n";
	    }
	
	    $tree = $tree->delete();

## RUN - à enlever pour les tests
    sleep(1);
}
close SORTIE;
