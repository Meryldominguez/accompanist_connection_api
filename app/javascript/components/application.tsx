import * as React from 'react'
import * as ReactDOM from 'react-dom'
import { createBrowserRouter, RouterProvider, Outlet } from 'react-router-dom'
import ThemeProvider from '@mui/material/styles/ThemeProvider'
import { theme } from '../../assets/stylesheets/theme'
import { Box } from '@mui/material'
import Header from './Header'
import Footer from './Footer'

//   TODO: See if theres a user in the token, if so, pass it into the app

const Root = () => {
  return (
    <>
      <Header />
      <Box className="appBody" minHeight={window.innerHeight - 100} margin={2}>
        <Outlet />
      </Box>
      <Footer />
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
    <ThemeProvider theme={theme}>
      <RouterProvider router={router} />
    </ThemeProvider>
  </React.StrictMode>,
  document.getElementById('root')
)
