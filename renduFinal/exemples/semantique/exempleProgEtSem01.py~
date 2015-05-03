==> PROGRAMME
-------------------------

def compToTreize(a):
 if(a < 13):
  return "a plus petit que 13"
 return "a plus grand que 13"

print compToTreize(12)
print compToTreize(14)

==> SEMANTIQUE
-------------------------

Programme(
	IC( 
		Def( 
			Fn_name( compToTreize ), 
			[Id_name( a )],
			Programme(
				IC( 
					If( Op_bin( Id( Id_name( a ) ),LessThan,Valeur( Int( 13 ) ) ),
						Programme(
							Return( Valeur( String( a plus petit que 13 ) ) ) "LE RETURN MARCHE POUR LE PROGRAMME QUI EST DANS LE IF ..."
						)
					)
				)
				Return( Valeur( String( a plus grand que 13 ) ) )
			)
		)
	)
	Print( Call( Fn_name( compToTreize ), [Valeur( Int( 12 ) )] ) )
	Print( Call( Fn_name( compToTreize ), [Valeur( Int( 14 ) )] ) )
)
