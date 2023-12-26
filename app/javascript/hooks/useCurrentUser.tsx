import { useQuery } from '@tanstack/react-query'
import axios from 'axios'

export const fetchCurrentUser = (token: string) =>
  axios.post(`/auth/current_user`, { token: token }).then((res) => res.data)

export default function useCurrentUser() {
  const token = localStorage.getItem('token')
  if (token) {
    return useQuery({
      queryKey: ['user', token],
      queryFn: () => fetchCurrentUser(token),
      select: (data) => data.user.data.attributes,
    })
  }
  return { data: null, status: null, error: 'No Token' }
}
