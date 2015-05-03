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
