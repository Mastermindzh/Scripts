//build: gcc ani2png.c -o ani2png

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void ReadFile(char *name);
int teststring(char *buffer,int start);

int main(int argc, char **argv)
{
    if (argc != 2) {
		fprintf(stderr, "Usage: ani2png /path.ani");
        return 0;
    }
	ReadFile(*(argv+1));
	return 0;
}

int teststring(char *buffer,int start)
{
    if (*(buffer+start) == 0x69) {
        if (*(buffer+start+1) == 0x63) {
            if (*(buffer+start+2) == 0x6f) {
                if (*(buffer+start+3) == 0x6e) {
                    return 1;
                }
            }
        }
    } else return 0;
}

void ReadFile(char *name)
{
	FILE *file;
	char *buffer,*fileName;
	unsigned long fileLen;

    if (!strstr(name,".ani")) {
		fprintf(stderr, "Usage: ani2png /path.ani");
        return;
    }

    fileName=malloc(strlen(name)+1);
    strcpy(fileName,name);
    *strstr(fileName,".ani")='\0';

	file = fopen(name, "rb");
	
	fseek(file, 0, SEEK_END);
	fileLen=ftell(file);
	fseek(file, 0, SEEK_SET);

	buffer=(char *)malloc(fileLen+1);

	fread(buffer, fileLen, 1, file);
	fclose(file);

    char *new_png_name=malloc(strlen(name)+5);

    char png_counter_string[5];
	int i,j,png_counter=1;
    FILE *png_image;

	for (i=0;i <= fileLen;i++) {
        if (png_counter == 9999) {
			free(fileName);
			free(buffer);
			free(new_png_name);
            return;
		}
		
        if ((i+4 <= fileLen) && teststring(buffer,i) == 1) {
            sprintf(png_counter_string,"%d",png_counter);
            strcpy(new_png_name,fileName);
            strcat(new_png_name,png_counter_string);
            strcat(new_png_name,".png");
            png_counter++;

            png_image = fopen(new_png_name,"wb");
            if (!png_image) {
                fprintf(stderr, "Unable to open file %s.\n", new_png_name);
                free(fileName);
                free(buffer);
                free(new_png_name);
                return;
            }

            j=8;
            while (i+j+4 <= fileLen) {
                if (teststring(buffer,i+j+1) == 1)
                    break;
                if (j==10)
                    putc(0x01,png_image);
                else
                    putc(*(buffer+i+j),png_image);
                j++;
            }
            if (i+j <= fileLen)
                putc(*(buffer+i+j),png_image);
            if (fileLen-i-j<=3) {
                putc(*(buffer+i+j+1),png_image);
                putc(*(buffer+i+j+2),png_image);
            }
            fclose(png_image);
            i+=j;
        }
    }
        
    free(new_png_name);
    free(buffer);
    free(fileName);
}
