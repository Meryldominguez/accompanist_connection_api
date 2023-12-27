import ThemeProvider from '@mui/material/styles/ThemeProvider'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { ReactQueryDevtools } from '@tanstack/react-query-devtools'
import React from 'react'
import ReactDOM from 'react-dom'
import { RouterProvider, createBrowserRouter } from 'react-router-dom'
import { theme } from '../../assets/stylesheets/theme'
import { CurrentUserContextProvider, useCurrentUserContext } from '../providers/CurrentUserProvider'
import { generateRoutes } from '../routing'

const queryClient = new QueryClient()

const App = () => {
  const currentUser = useCurrentUserContext()

  const routes = [...generateRoutes(Boolean(currentUser))]
  console.log(routes)
  const router = createBrowserRouter(routes)

  return <RouterProvider router={router} />
}

ReactDOM.render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
      <CurrentUserContextProvider>
        <ThemeProvider theme={theme}>
          <ReactQueryDevtools initialIsOpen={false} />
          <App />
        </ThemeProvider>
      </CurrentUserContextProvider>
    </QueryClientProvider>
  </React.StrictMode>,
  document.getElementById('root')
)
