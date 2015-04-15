==> PROGRAMME
-------------------------

def d(x):
 if(x < 10):
  a = "a-"
 if(x > 10):
  a = "a+"
 if(x == 10):
  a = "a"
 print a

d(2)
d(15)
d(10)

==> RETOUR
-------------------------
a-
a+
a

==> SEMANTIQUE
-------------------------

Programme(
	IC( 
		Def( 
			Fn_name( d ), 
			[Id_name( x )],
			Programme(
				IC( 
					If( 
						Op_bin( Id( Id_name( x ) ),LessThan,Valeur( Int( 10 ) ) ),
						Programme(
							Affectation( Id_name( a ),Valeur( String( a- ) ) )
						)
					)
				)
				IC( 
					If( 
						Op_bin( Id( Id_name( x ) ),GreaterThan,Valeur( Int( 10 ) ) ),
						Programme(
							Affectation( Id_name( a ),Valeur( String( a+ ) ) )
						)
					)
				)
				IC( 
					If( 
						Op_bin( Id( Id_name( x ) ),Equal,Valeur( Int( 10 ) ) ),
						Programme(
							Affectation( Id_name( a ),Valeur( String( a ) ) )
						)
					)
				)
				Print( Id( Id_name( a ) ) )
			)
		)
	)

	Expr( Call( Fn_name( d ), [Valeur( Int( 2 ) )] ) )
	Expr( Call( Fn_name( d ), [Valeur( Int( 15 ) )] ) )
	Expr( Call( Fn_name( d ), [Valeur( Int( 10 ) )] ) )

)

