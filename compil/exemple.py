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
