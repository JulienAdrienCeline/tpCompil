#include <stdio.h>

int f(int a, int b) {
	return (a + b)*(a - b);
}

int carre(int a) {
	int z = a*a - 12;
	z = f(z + a - 8, z - a + 8);
	return z;
}

int main() {
	char* affiche = "le resultat est %d\n";
	int t = f(12, 6);
	int z = carre(t + 4);
	z = carre(f(t,z));
  printf(affiche, z);
  return 0;
}
