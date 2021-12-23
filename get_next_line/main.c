#include "get_next_line.h"
#include <stdio.h>
#include <stdlib.h>

int     main()
{
	char	*line;

	while (42)
	{
		line = get_next_line(STDIN_FILENO);
		if (line == NULL)
				break ;
		printf("%s", line);
		free(line);
	}
	return (0);
}
