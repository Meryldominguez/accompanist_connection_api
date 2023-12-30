import { useQuery } from '@tanstack/react-query'
import useFetch from './useFetch'

export const fetchCurrentUser = () => useFetch('POST', '/auth/current_user')

export const useCurrentUser = () => {
  const token = localStorage.getItem('token')

  return useQuery({
    queryKey: ['user', token],
    queryFn: fetchCurrentUser,
    select: (data) => data.user.data.attributes,
    enabled: !!token,
    retry: 1,
  })
}
