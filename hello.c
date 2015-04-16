#include <stdio.h>

int f(int a, int b) {
	return (a + b)*(a - b);
}

int carre(int a) {
	int z = a*a - 12;
	z = f(z + a - 8, z - a + 8);
	return z;
}

int compToTreize(int a) {
	int b;
	if (a < 13) {
		int t = f(12, 6);
		int z = carre(t + 4);
		z = carre(f(t,z));
		printf("a est plus petit que 13 et z vaut %d", z);
		b = a + 13;
	}
	else {
		int t = f(6, 6);
		int z = carre(t + 2);
		z = carre(f(z,z));
		int n = carre(f(t,z));
		printf("a est plus grand que 13 et z vaut %d et n vaut %d", z, n);
		b = a - 13;
	}
	return b;
}

int main() {
	int x = compToTreize(7);
	int y = compToTreize(25);
	printf("x = %d ; y = %d\n",x,y);
  return 0;
}
