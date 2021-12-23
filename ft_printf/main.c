#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <stdarg.h>

#ifndef TEST_REF
int	ft_printf(const char *format, ...);
# else
int	ft_printf(const char *format, ...)
{
	va_list	args;
	int		ret;

	va_start(args, format);
	ret = vprintf(format, args);
	va_end(args);
	return (ret);
}
#endif

int	main()
{
	char	*str = "Hello, %s %s %c %c %d %d %d %d %d %x %x %x %x %x\n";
	char	*arg1 = "World!";
	char	arg2 = '4';
	char	arg3 = '2';
	int		arg4 = 42;
	int		arg5 = -42;
	int		arg6 = 0;
	int		arg7 = INT_MAX;
	int		arg8 = INT_MIN;
	int		ret;

	ret = ft_printf(
		str,
		arg1,
		NULL,
		arg2,
		arg3,
		arg4,
		arg5,
		arg6,
		arg7,
		arg8,
		arg4,
		arg5,
		arg6,
		arg7,
		arg8
	);
	ft_printf("%d\n", ret);
	return (EXIT_SUCCESS);
}
