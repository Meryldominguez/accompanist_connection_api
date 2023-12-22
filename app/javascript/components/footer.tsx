import { Container } from '@mui/material'
import AppBar from '@mui/material/AppBar'
import useTheme from '@mui/material/styles/useTheme'

const Footer = () => {
  const theme = useTheme()
  console.log(theme)
  return (
    <AppBar
    position='static'
      sx={{
        display: 'flex',
        flexDirection: 'column',
        minHeight:4,
        bottom:0
      }}
      component="footer"
    >
      <Container maxWidth="xl">
        
      </Container>
    </AppBar>
  )
}

export default Footer
