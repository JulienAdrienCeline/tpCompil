==> PROGRAMME
-------------------------

def d(x):
 if(x < 10):
  def da(x):
   if(x<5):
    return "a--"
   return "a-"
 if(x > 10):
  def da(x):
   if(x<15):
    return "a+"
   return "a++"
 if(x == 10):
  def da(x):
   return "a"
 print da(x+5)

d(2)
d(8)
d(15)
d(11)
d(10)

==> RETOUR
-------------------------
a-
a-
a++
a++
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
							IC( 
								Def( 
									Fn_name( da ), 
									[Id_name( x )],
									Programme(
										IC( 
											If( 
												Op_bin( Id( Id_name( x ) ),LessThan,Valeur( Int( 5 ) ) ),
												Programme(
													Return( Valeur( String( a-- ) ) )
												)
											)
										)
										Return( Valeur( String( a- ) ) )
									)
								)
							)
						)
					)
				)
				IC( 
					If( 
						Op_bin( Id( Id_name( x ) ),GreaterThan,Valeur( Int( 10 ) ) ),
						Programme(
							IC( 
								Def( 
									Fn_name( da ), 
									[Id_name( t )],
									Programme(
										IC( 
											If( 
												Op_bin( Id( Id_name( t ) ),LessThan,Valeur( Int( 15 ) ) ),
												Programme(
													Return( Valeur( String( a+ ) ) )
												)
											)
										)
										Return( Valeur( String( a++ ) ) )
									)
								)
							)
						)
					)
				)
				IC( 
					If( 
						Op_bin( Id( Id_name( x ) ),Equal,Valeur( Int( 10 ) ) ),
						Programme(
							IC( 
								Def( 
									Fn_name( da ), 
									[Id_name( t )],
									Programme(
										Return( Valeur( String( a ) ) )
									)
								)
							)
						)
					)
				)
				Print( Call( Fn_name( da ), [Op_bin( Id( Id_name( x ) ),Add,Valeur( Int( 5 ) ) )] ) )
			)
		)
	)
	Expr( Call( Fn_name( d ), [Valeur( Int( 2 ) )] ) )
	Expr( Call( Fn_name( d ), [Valeur( Int( 8 ) )] ) )
	Expr( Call( Fn_name( d ), [Valeur( Int( 15 ) )] ) )
	Expr( Call( Fn_name( d ), [Valeur( Int( 11 ) )] ) )
	Expr( Call( Fn_name( d ), [Valeur( Int( 10 ) )] ) )
)

