import { UseQueryResult } from '@tanstack/react-query'
import * as React from 'react'
import { UserAttributes } from '../components/types/userTypes'
import { useCurrentUser } from '../hooks/useCurrentUser'

interface UserQueryResult extends Omit<UseQueryResult, 'data'> {
  data?: UserAttributes
}
type contextDefaultType = { data: null; isFetching: true; isSuccess: false }
const contextDefault: contextDefaultType = {
  data: null,
  isFetching: true,
  isSuccess: false,
}

const CurrentUserContext = React.createContext<UserQueryResult | contextDefaultType>(contextDefault)

export const useCurrentUserContext = () => {
  return React.useContext(CurrentUserContext)
}

export const CurrentUserContextProvider = ({ children }: { children: React.ReactNode }) => {
  const currentUserQuery = useCurrentUser()

  if (currentUserQuery.isError) {
    localStorage.removeItem('token')
    return <CurrentUserContext.Provider value={contextDefault}>{children}</CurrentUserContext.Provider>
  } else {
    return <CurrentUserContext.Provider value={currentUserQuery}>{children}</CurrentUserContext.Provider>
  }
}
