import { useQuery } from '@tanstack/react-query'
import useFetch from './useFetch'

export const fetchCurrentUser = () => useFetch('POST', '/auth/current_user')

export const useCurrentUser = (token: string | null) => {
  return useQuery({
    queryKey: ['currentUser', token],
    queryFn: fetchCurrentUser,
    select: (data) => data.user,
    enabled: !!token,
    retry: 1,
  })
}
