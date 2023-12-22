import React from 'react'
import AppBar from '@mui/material/AppBar'
import Container from '@mui/material/Container'

const Footer = () => {
  return (
    <AppBar
      position="static"
      sx={{
        display: 'flex',
        flexDirection: 'column',
        minHeight: 4,
        bottom: 0,
      }}
      component="footer">
      <Container maxWidth="xl"></Container>
    </AppBar>
  )
}

export default Footer
