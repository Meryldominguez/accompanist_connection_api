import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { ReactQueryDevtools } from '@tanstack/react-query-devtools'
import React from 'react'
import { Outlet, RouterProvider, createBrowserRouter } from 'react-router-dom'

import { Box } from '@mui/material'
import ThemeProvider from '@mui/material/styles/ThemeProvider'
import ReactDOM from 'react-dom'
import { theme } from '../../assets/stylesheets/theme'
import { CurrentUserContextProvider } from '../providers/CurrentUserProvider'
import Footer from './Footer'
import Header from './Header'

const queryClient = new QueryClient()

const Root = () => {
  return (
    <>
      <CurrentUserContextProvider>
        <Header />
        <Box className="appBody" minHeight={window.innerHeight - 400} margin={2}>
          <Outlet />
        </Box>
        <Footer />
      </CurrentUserContextProvider>
    </>
  )
}

const router = createBrowserRouter([
  {
    path: '/',
    Component: Root,
    children: [
      {
        path: 'login',
        Component: () => <h1>Login Index</h1>,
      },
    ],
  },
  {
    path: '*',
    Component: () => <h1>Error!</h1>,
  },
  // {
  //     path: "*",
  //     element: <div>OH NO!</div>
  // },
])

ReactDOM.render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
      <ThemeProvider theme={theme}>
        <ReactQueryDevtools initialIsOpen={false} />

        <RouterProvider router={router} />
      </ThemeProvider>
    </QueryClientProvider>
  </React.StrictMode>,
  document.getElementById('root')
)
