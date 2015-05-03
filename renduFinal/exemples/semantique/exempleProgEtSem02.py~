==> PROGRAMME
-------------------------

def max(nombre1,nombre2):
 print "max de " + nombre1 + " et " + nombre2
 if(nombre1>nombre2):
  print "le premier nombre est plus grand"
  return nombre1
 print "le deuxième nombre est plus grand"
 return nombre2

entier=5

maximum=max(entier,10)

print "max(5,10) + max(2,1) = " + (maximum+max(2,1))

==> SEMANTIQUE
-------------------------

Programme(
	IC( 
		Def( 
			Fn_name( max ), 
			[Id_name( nombre1 ),Id_name( nombre2 )],
			Programme(
				Print( 
					Op_bin( 
						Op_bin( 
							Op_bin( 
								Valeur( String( max de  ) ),
								Add,
								Id( Id_name( nombre1 ) ) 
							),
							Add,
							Valeur( String(  et  ) ) 
						),
						Add,
						Id( Id_name( nombre2 ) ) 
					) 
				)
				IC( 
					If( 
						Op_bin( Id( Id_name( nombre1 ) ),GreaterThan,Id( Id_name( nombre2 ) ) ),
						Programme(
							Print( Valeur( String( le premier nombre est plus grand ) ) )
							Return( Id( Id_name( nombre1 ) ) )
						)
					)
				)
				Print( Valeur( String( le deuxième nombre est plus grand ) ) )
				Return( Id( Id_name( nombre2 ) ) )
			)
		)
	)
	Affectation( Id_name( entier ),Valeur( Int( 5 ) ) )
	Affectation( Id_name( maximum ),Call( Fn_name( max ), [Id( Id_name( entier ) ),Valeur( Int( 10 ) )] ) )
	Print( 
		Op_bin( 
			Valeur( String( max(5,10) + max(2,1) =  ) ),
			Add,
			Op_bin( 
				Id( Id_name( maximum ) ),
				Add,
				Call( Fn_name( max ), [Valeur( Int( 2 ) ),Valeur( Int( 1 ) )] ) 
			) 
		) 
	)
)

