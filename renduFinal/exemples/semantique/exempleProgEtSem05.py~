==> PROGRAMME
-------------------------

def parler(heure, nom):
 def choixmot(h):
  if(h < 12):
   return "Bonjour"
  if(h < 18):
   return "Bon après-midi"
  return "Bonsoir"
 return choixmot(heure) + " " + nom

print parler(10,"Cunégonde")
print parler(17,"Jacques Henri")
print parler(20,"Jacquard")

==> SEMANTIQUE
-------------------------

Programme(
	IC( 
		Def( 
			Fn_name( parler ), 
			[Id_name( heure ),Id_name( nom )],
			Programme(
				IC( 
					Def( 
						Fn_name( choixmot ), 
						[Id_name( h )],
						Programme(
							IC( 
								If( 
									Op_bin( Id( Id_name( h ) ),LessThan,Valeur( Int( 12 ) ) ),
									Programme(
										Return( Valeur( String( Bonjour ) ) )
									)
								)
							)
							IC( 
								If( 
									Op_bin( Id( Id_name( h ) ),LessThan,Valeur( Int( 18 ) ) ),
									Programme(
										Return( Valeur( String( Bon après-midi ) ) )
									)
								)
							)
							Return( Valeur( String( Bonsoir ) ) )
						)
					)
				)
				Return( 
					Op_bin( 
						Op_bin( 
							Call( Fn_name( choixmot ), [Id( Id_name( heure ) )] ),
							Add,
							Valeur( String(   ) ) 
						),
						Add,
						Id( Id_name( nom ) ) 
					) 
				)
			)
		)
	)
	Print( Call( Fn_name( parler ), [Valeur( Int( 10 ) ),Valeur( String( Cunégonde ) )] ) )
	Print( Call( Fn_name( parler ), [Valeur( Int( 17 ) ),Valeur( String( Jacques Henri ) )] ) )
	Print( Call( Fn_name( parler ), [Valeur( Int( 20 ) ),Valeur( String( Jacquard ) )] ) )
)

