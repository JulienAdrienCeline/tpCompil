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
