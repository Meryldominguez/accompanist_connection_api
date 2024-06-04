import { useMutation } from '@tanstack/react-query'
import useFetch from './useFetch'

type loginUserObject = {
  email: string
  password: string
}

const fetchLoginUser = (data: loginUserObject) => useFetch('POST', '/auth/login', data, false)

const useLoginUser = () =>
  useMutation({
    mutationFn: (data: loginUserObject) => fetchLoginUser(data),
  })

export default useLoginUser
