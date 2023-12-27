import * as React from 'react'
import useCurrentUser from '../hooks/useCurrentUser'

const CurrentUserContext = React.createContext<object | null>(null)

export const useCurrentUserContext = () => {
  return React.useContext(CurrentUserContext)
}

export const CurrentUserContextProvider = ({ children }: { children: React.ReactNode }) => {
  const currentUserQuery = useCurrentUser()

  if (currentUserQuery.status == 'error') {
    console.log('token error')
    localStorage.removeItem('token')
  }

  return <CurrentUserContext.Provider value={currentUserQuery.data}>{children}</CurrentUserContext.Provider>
}
