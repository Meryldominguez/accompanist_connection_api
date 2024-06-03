import axios, { Method } from 'axios'

type requestObject = {
  method: Method
  url: string
  data?: object
  headers: { 'Content-Type': string; Authorization?: string }
}
const useFetch = (method: Method = 'GET', url: string, body?: object, withAuth: boolean = true) => {
  const requestObject: requestObject = {
    method: method,
    url: url,
    data: body,
    headers: { 'Content-Type': 'application/json' },
  }
  if (withAuth && localStorage.getItem('token'))
    requestObject.headers['Authorization'] = `Bearer ${localStorage.getItem('token')}`
  return axios(requestObject).then((res) => res.data)
}

export default useFetch
