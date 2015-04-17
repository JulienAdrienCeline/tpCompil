#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char* example(const char *header, char *word)
{
    size_t header_len = strlen(header);
		size_t word_len = strlen(word);
		size_t message_len = header_len + word_len + 2;
    char *message = (char*) malloc(message_len);
    strncat(message, header, header_len);
		strncat(message, word, message_len);
		strncat(message, "\n", message_len);
    
	return message;
}

int main(int argc, char** argv) {
	
	int a = 0;
	int b = 0;

	if (argc > 2) {
		a = strlen(argv[1]);
		b = strlen(argv[2]);
		int c = b;
		if (argc > 3) {
			c += strlen(argv[3]);
		}
		b = c;
	}

	printf("%d ; %d\n",a,b);

  return 0;
}
