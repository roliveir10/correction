/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strlen.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: roliveir <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/11/08 15:36:22 by roliveir          #+#    #+#             */
/*   Updated: 2018/11/11 17:38:06 by roliveir         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

size_t		ft_strlen(const char *str)
{
	int		i;
	char	*m_str;

	m_str = (char*)str;
	i = 0;
	while (m_str[i])
	{
		i++;
	}
	return (i);
}