import { QueryObserverBaseResult } from '@tanstack/react-query'
import { Dispatch, SetStateAction, createContext, useContext, useState } from 'react'
import { UserAttributes } from '../components/types/userTypes'
import { useCurrentUser } from '../hooks/useCurrentUser'

interface UserQueryResult extends Omit<QueryObserverBaseResult, 'data'> {
  data?: UserAttributes
  setToken: Dispatch<SetStateAction<string | null>>
}
type contextDefaultType = {
  data: null
  isFetching: true
  isSuccess: false
  setToken: Dispatch<SetStateAction<string | null>>
}

const contextDefault: contextDefaultType = {
  data: null,
  isFetching: true,
  isSuccess: false,
  setToken: () => {},
}

const CurrentUserContext = createContext<UserQueryResult | contextDefaultType>(contextDefault)

export const useCurrentUserContext = () => {
  return useContext(CurrentUserContext)
}

export const CurrentUserContextProvider = ({ children }: { children: React.ReactNode }) => {
  const [token, setToken] = useState(localStorage.getItem('token'))

  const currentUserQuery = useCurrentUser(token)

  if (currentUserQuery.isError) {
    localStorage.removeItem('token')
    return <CurrentUserContext.Provider value={{ ...contextDefault, setToken }}>{children}</CurrentUserContext.Provider>
  } else {
    return (
      <CurrentUserContext.Provider value={{ ...currentUserQuery, setToken }}>{children}</CurrentUserContext.Provider>
    )
  }
}
