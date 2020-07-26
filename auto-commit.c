#include <stdio.h>
#include <stdlib.h>

int main(void)
{
	printf("Git auto-commit by Roma \n");
	system("git status");
	system("git add .");
	system("git commit -m \"auto-commit\"");
	system("git push -u origin roma");
	return 0;
}