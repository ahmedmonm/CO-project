#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_SIZE 100 // Maximum string size

int  stringlength(char s[])
{
     int j;
     for(j=0;s[j];j++);

	 return j;

}
//four
void frequencyofcharacters(char s[])
{
	int i,j,count=0,n;

    n=stringlength(s);

	printf(" frequency count character in string:\n");


    for(i=0;i<n;i++)
    {
     	count=1;
    	if(s[i]&&s[i]!=' ')
    	{

 		  for(j=i+1;j<n;j++)
	      {

	        if(s[i]==s[j] )
    	    {
                 count++;
                 s[j]='\0';
	     	}
	      }
            if(count<=3){
			printf("Frequency of character  %c is %d \n",s[i],count);
            }

        }

 	}

}
//two
int count_word_Occurrences(char  str[], char  word[])
{
    int found, count;

    int stringLen = strlen(str);      // length of string
    int wordLen = strlen(word); // length of word to be searched

    count = 0;

    for(int i=0; i <= stringLen-wordLen; i++)
    {
        /* Match word with string */
        found = 1;
        for(int j=0; j<wordLen; j++)
        {
            if(str[i + j] != word[j])
            {
                found = 0;
                break;
            }
        }

        if(found == 1)
        {
            count++;
        }
    }

    return count;
}

//three
char* replaceWord( char string[],  char oldWord[], char newWord[])
{
    char* result;
    int i, cnt = 0;
    int newWordlen = strlen(newWord);
    int oldWordlen = strlen(oldWord);

    // number of oldWord string
    // occur in the string
    for (i = 0; string[i] != '\0'; i++) {
        if (strstr(&string[i], oldWord) == &string[i]) {
            cnt++;

            // Jumping to index after the old word.
            i += oldWordlen - 1;
        }
    }

    // Making new string of enough length
    result = (char*)malloc(i + cnt * (newWordlen - oldWordlen) + 1);

    i = 0;
    while (*string) {
        // compare the substring with the result
        if (strstr(string, oldWord) == string) {
            strcpy(&result[i], newWord);
            i += newWordlen;
            string += oldWordlen;
        }
        else
            result[i++] = *string++;
    }

    result[i] = '\0';
    return result;
}

//five
     void search_wordorchar_idex(char string[],char s[]){

    char words[100][100];
    int key[100];
    key[0]=0;
    int i = 0, j = 0, k, length, count;

    for(k=0; string[k]!='\0'; k++){

        if(string[k] != ' '){

            words[i][j++] =string[k];
        }
        else{
            words[i][j] = '\0';
            key[i+1]=k+1;
            i++;
            j = 0;
        }
    }

    length = i+1;


    printf("Duplicate words in the given string: \n");
    for(int i = 0; i < length; i++){
        if(strcmp(words[i],s) == 0){
            printf("%s in %d \n",s,key[i]);
            count++;
        }


    }
    printf("It appeared %d Times",count);

   }
      //Character Statistics/Frequency
void count_chars(char string[],char s){
           int j=0;
           for(int i = 0 ; i < strlen(string) ; i++){
               if(string[i]==s){
                   j++;
                   printf("%c appeared in index = %d \n",s,i);
           }
           }
           printf("%c appeared %d Times \n",s,j);

   }

// Function to sort the paragraph
void sorting_paragraph(char str[100])
{
    // Using for Nested loop
    int   i, j;
    int col, space = 0;
    char   arr[50][100], temp[50];


    for (i = 0, j = 0, col = 0;j < strlen(str);j++)
    {
        //  To ignore string If find space or (,) or (.)
        if ((str[j] == ' ')||(str[j] == ',')||(str[j] == "."))
        {
            space++;
            i++;
            col = 0;
        }

        else
             // Moving the string from 1D array to 2D array
             arr[i][col++] = str[j];
    }


     //loop for sorting
    for (i = 0;i < space;i++)
    {
        for (j = i + 1; j <= space; j++)
        {

            //if the ASCII value of the first unmatched character is greater than the second.
            if ((strcmp(arr[i], arr[j]) > 0))
            {
                strcpy(temp, arr[i]);
                strcpy(arr[i], arr[j]);
                strcpy(arr[j], temp);
            }
        }
    }

    printf("\nAfter sorting string is: \n");

    for (i = 0;i <= space;i++)
    {
        printf("%s ", arr[i]);
    }

    printf("\n");

}

int main()
{

    char s[1000],p[50][100];
    int op_num;

    char word[MAX_SIZE];
    int count;

    char c[MAX_SIZE] ;
    char d[MAX_SIZE] ;

    char* result = NULL;

    char str[100];
    char ch;

    printf("please, Enter paragraph: ");
    gets(s);

    sorting_paragraph(s);

    printf("\n1-Character Statistics/Frequency\n2-Word Statistics\n3-Find and replace for a character or a word.\n4-Get all characters/words that have frequencies of one, two and three.\n5-Search on a specific word/character.\n6-Exit\n\n");

    while(op_num!=6)
    {
        printf("\nplease, Choose the number of operation you want: ");
        scanf("%d",&op_num);

        if (op_num==1)
        {
            int count =0;
            char ch;
            //input character to check frequency
            printf("Enter a character: ");
            scanf("%s",&ch);
            //calculate frequency of character
            for(int i=0; s[i]!='\0'; i++)
            {
                if(s[i]==ch)
                    count++;
            }

            printf("\'%c\' found %d times in \"%s\"\n",ch,count,s);
        }

        if (op_num==2)
        {
            printf("\nEnter word to search occurrences: \n");
            //gets(word);
            scanf("%s",&word);

            count = count_word_Occurrences(s, word);
            printf("Total occurrences of '%s': %d\n", word, count);
        }

        if (op_num==3)
        {
            printf("word want to replace: \n");
            //gets(c);
            scanf("%s",&c);

            printf("new word : \n");
            //gets(d);
            scanf("%s",&d);

            result = replaceWord(s, c, d);

            for(int i=0;i<1000;i++) {
                s[i] = result[i];
            }

            printf("New String: %s\n", s);

            free(result);
        }

        if (op_num==4)
        {
           frequencyofcharacters(&s);
        }
        if (op_num==5)
        {
            puts("Enter the search word/character.. \n");
            //gets(str);
            scanf("%s",&str);
            if(strlen(str)>1)
            search_wordorchar_idex(s,str);
            else
            count_chars(s,str[0]);
        }
    }



	return 0;

}
