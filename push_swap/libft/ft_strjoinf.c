/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strjoinf.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: roliveir <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/07 17:51:49 by roliveir          #+#    #+#             */
/*   Updated: 2019/01/29 04:30:22 by roliveir         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

char	*ft_strjoinf(char *s1, char *s2)
{
	char	*line;

	if (!(line = ft_strjoin(s1, s2)))
		return (NULL);
	ft_strdel(&s1);
	return (line);
}
