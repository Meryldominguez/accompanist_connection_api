import axios, { Method } from 'axios'

type requestObject = {
  method: Method
  url: string
  data?: object
  headers: { 'Content-Type': string; Authorization?: string }
}
const useFetch = (
  method: Method = 'GET',
  url: string,
  body?: object,
  token: string | null = localStorage.getItem('token')
) => {
  const requestObject: requestObject = {
    method: method,
    url: url,
    data: body,
    headers: { 'Content-Type': 'application/json' },
  }
  if (token) requestObject.headers['Authorization'] = `Bearer ${token}`
  return axios(requestObject).then((res) => res.data)
}

export default useFetch
