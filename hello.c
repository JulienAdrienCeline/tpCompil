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
	
	char* myHead = "Hello World!\n";
	char* myWord = argv[1];

	char* message = example(myHead, myWord);

	puts(message);

  return 0;
}
