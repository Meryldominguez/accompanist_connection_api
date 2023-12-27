import { Box } from '@mui/material'
import { Outlet } from 'react-router-dom'
import Footer from './FooterNavBar'
import Header from './HeaderNavBar'

export const Root = () => {
  return (
    <>
      <Header />
      <Box className="appBody" minHeight={window.innerHeight - 400} margin={2}>
        <Outlet />
      </Box>
      <Footer />
    </>
  )
}
