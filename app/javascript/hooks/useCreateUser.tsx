import { useMutation } from '@tanstack/react-query'
import { UserAttributes } from '../components/types/userTypes'
import useFetch from './useFetch'

type createUserObject = {
  first_name: string
  last_name: string
  email: string
  password: string
}
type successResponseObject = {
  token: string
  user: UserAttributes
}
const fetchCreateUser = (data: createUserObject) => useFetch('POST', '/api/users', data, false)

const useCreateUser = () =>
  useMutation({
    mutationFn: (data: createUserObject) => fetchCreateUser(data),
    onSuccess(data: successResponseObject) {
      console.log(data)
      localStorage.setItem('token', data.token)
    },
  })

export default useCreateUser
