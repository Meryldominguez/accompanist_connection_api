import { useQuery } from '@tanstack/react-query'
import axios from 'axios'

const fetchUser = (userId: number) => axios.post(`/user/${userId}`).then((res) => res.data)

export const useUser = (userId: number) => {
  return useQuery({ queryKey: ['user', userId], queryFn: () => fetchUser(userId) })
}
