import { useMutation } from '@tanstack/react-query'
import useFetch from './useFetch'

type createUserObject = {
  first_name: string
  last_name: string
  email: string
  password: string
}

const fetchCreateUser = (data: createUserObject) => useFetch('POST', '/api/users', data, false)

const useCreateUser = () =>
  useMutation({
    mutationFn: (data: createUserObject) => fetchCreateUser(data),
  })

export default useCreateUser
